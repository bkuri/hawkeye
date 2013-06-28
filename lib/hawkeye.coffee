#!../node_modules/coffee-script/bin/coffee
'use strict'

CONFIG_TEMPLATE = "'.':\n\t'*': 'echo %% was just modified!'\n"
DEFAULT_FILENAME = '.hawkeye'
RE_ENV = /\$(\S+)/
VERSION = '0.2.0'

CoffeeScript = require '../node_modules/coffee-script'
Inotify = require('inotify').Inotify
MiniLog = require 'minilog'
MiniLog.pipe(logBackend).format logBackend.formatNpm
args = require 'commander'
deploy = require('child_process').exec
fs = require 'fs'
inotify = new Inotify()
log = MiniLog 'hawkeye'
logBackend = MiniLog.backends.nodeConsole
minimatch = require 'minimatch'
path = require 'path'

class App
  @addItem: (dir, globs) ->
    callback = (event) ->
      file = event.name or 'n/a'
      for glob in Object.keys globs
        if minimatch file, glob
          log.debug "file #{file} matched pattern '#{glob}'"
          warhead = App.handle globs[glob], dir, file
          log.info "launching '#{warhead}'" if verbose
          deploy warhead, (error, stdout, stderr) ->
            if error then log.error stderr
            else if stdout then log.debug stdout

    try
      process.chdir path.dirname config
    catch error
      log.error error
      process.exit 1
    finally
      env = dir.match RE_ENV
      dir = path.resolve unless env then dir else dir.replace env[0], process.env[env[1]]
      log.info "tracking target '#{dir}'" if verbose
      inotify.addWatch path: dir, watch_for: Inotify.IN_CLOSE_WRITE, callback: callback

  @coffee: (data) -> eval CoffeeScript.compile data, bare: true

  @createConfig: (file=DEFAULT_FILENAME) ->
    fs.writeFile file, CONFIG_TEMPLATE, (error) ->
      if error then log.error error
      else log.info "created config file '#{file}'"
      process.exit if error then 1 else 0

  @handle: (text, dir, file) ->
    vars =
      b: path.basename file, path.extname file
      c: dir
      d: new Date().toISOString()
      e: path.extname file
      f: path.basename file
      h: process.env.PWD
      '': path.join dir, file

    env = text.match RE_ENV
    text = unless env then text else text.replace env[0], process.env[env[1]]
    text = (text.replace "%%#{key}", vars[key]) for key in Object.keys vars
    text

  constructor: (config, verbose=false) ->
    fs.readFile config, 'utf-8', (error, data) =>
      if error
        log.error "error opening file '#{path.resolve config}'. Check your syntax."
        process.exit 1

      log.info "version #{VERSION} deployed" if verbose
      log.info "opened watch file '#{path.resolve config}'" if verbose
      items = App.coffee data
      App.addItem item, items[item] for item in Object.keys items

args
  .version(VERSION)
  .option('-c, --config [path]', "use this config file [#{DEFAULT_FILENAME}]", DEFAULT_FILENAME)
  .option('-C, --create [path]', "create a new config file here [#{DEFAULT_FILENAME}]", DEFAULT_FILENAME)
  .option('-v, --verbose', "output events to stdout")
  .parse process.argv

if args.config is DEFAULT_FILENAME and args.create isnt args.config then App.createConfig args.create
else app = new App args.config, args.verbose

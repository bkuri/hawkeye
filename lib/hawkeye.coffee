#!../node_modules/coffee-script/bin/coffee
'use strict'

CONFIG_TEMPLATE = '.': '*' : "echo %% was just modified!"
NA = '[not available]'
VERSION = '0.1.4'

args = require 'commander'
CoffeeScript = require '../node_modules/coffee-script'
deploy = require('child_process').exec
fs = require 'fs'
Inotify = require('inotify').Inotify
inotify = new Inotify()
minimatch = require 'minimatch'
path = require 'path'
MiniLog = require 'minilog'
log = MiniLog 'hawkeye'
logBackend = MiniLog.backends.nodeConsole
MiniLog.pipe(logBackend).format logBackend.formatNpm

class App
  @createConfig: (file) ->
    fs.writeFile file, (JSON.stringify CONFIG_TEMPLATE, null, 4), (error) ->
      if error then log.error error
      else log.info "created config file '#{file}'"
      process.exit if error then 1 else 0

  constructor: (config, verbose=false) ->
    @addItem = (dir, globs) ->
      callback = (event) ->
        file = event.name or NA
        for glob in Object.keys globs
          if minimatch file, glob
            log.info "matched target #{file} with directive '#{glob}'" if verbose
            warhead = globs[glob].replace '%%', (path.join dir, file)
            log.info "deploying warhead '#{warhead}'" if verbose
            deploy warhead, (error, stdout, stderr) ->
              if error then log.error stderr
              else log.debug if stdout then stdout else NA

      try
        process.chdir path.dirname config
      catch error
        log.error error
        process.exit 1
      finally
        dir = path.resolve dir
        log.info "tracking target '#{dir}'" if verbose
        props = path: dir, watch_for: Inotify.IN_CLOSE_WRITE, callback: callback
        inotify.addWatch props

    @destroy = ->
      log.info "hawkeye down" if verbose
      inotify.close()

    log.info "version #{VERSION} deployed" if verbose
    fs.readFile config, 'utf-8', (error, data) =>
      if error
        log.error "error opening file '#{config}'. Check your syntax."
        process.exit 1

      log.info "opened watch file '#{config}'" if verbose
      items = eval CoffeeScript.compile data, bare:true
      @addItem item, items[item] for item in Object.keys items

args
  .version(VERSION)
  .option('-c, --config <path>', "use this config file")
  .option('-C, --create <path>', "create a new config file")
  .option('-v, --verbose', "output events to stdout")
  .parse process.argv

if args.create then App.createConfig args.create
else app = new App args.config, args.verbose

#!../node_modules/coffee-script/bin/coffee
'use strict'

APP = 'hawkeye'
TOKEN = '%%'
CONFIG_TEMPLATE = '.': '*' : "echo #{TOKEN} was just modified!"
VERSION = '0.1.3'

args = require 'commander'
CoffeeScript = require '../node_modules/coffee-script'
deploy = require('child_process').exec
fs = require 'fs'
Inotify = require('inotify').Inotify
inotify = new Inotify()
minimatch = require 'minimatch'
path = require 'path'
MiniLog = require 'minilog'
log = MiniLog APP
logBackend = MiniLog.backends.nodeConsole
MiniLog.pipe(logBackend).format logBackend.formatNpm

class App
  @createConfig: (file) ->
    fs.writeFile file, (JSON.stringify CONFIG_TEMPLATE, null, 2), (error) ->
      if error then log.error error
      else log.info "created config file '#{file}'"
      process.exit if error then 1 else 0

  constructor: (config, verbose=false) ->
    @addItem = (dir, globs) ->
      callback = (event) ->
        file = event.name or '[N/A]'
        for glob in Object.keys globs
          if minimatch file, glob
            log.info "matched target #{file} with directive '#{glob}'" if verbose
            warhead = globs[glob].replace TOKEN, (path.join dir, file)
            log.info "deploying warhead '#{warhead}'" if verbose
            deploy warhead, (error, stdout, stderr) ->
              if error then log.error stderr
              else log.debug stdout

      log.info "tracking target '#{path.resolve dir}'" if verbose
      props = path: dir, watch_for: Inotify.IN_CLOSE_WRITE, callback: callback
      inotify.addWatch props

    @destroy = ->
      log.info "destroyed" if verbose
      inotify.close()

    log.info "version #{VERSION} deployed" if verbose
    fs.readFile config, 'utf-8', (error, data) =>
      if error
        log.error "error opening file '#{config}'. Check your syntax."
        return

      log.info "opened watch file '#{config}'" if verbose
      items = eval CoffeeScript.compile data, bare:true
      @addItem item, items[item] for item in Object.keys items

args
  .version(VERSION)
  .option('-c, --config <path>', "set config file path")
  .option('-C, --create <path>', "create a boilerplate config file in the specified path")
  .option('-v, --verbose', "output events to stdout")
  .parse process.argv

if args.create then App.createConfig args.create
else app = new App args.config, args.verbose

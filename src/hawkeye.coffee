#!/usr/bin/env coffee
'use strict'

APP = 'hawkeye'
INOTIFY_LIB = '/usr/lib/node_modules/inotify'
TOKEN = '%%'
CONFIG_TEMPLATE = '.': '*' : "echo #{TOKEN} was just modified!"
VERSION = '0.0.1'

args = require 'commander'
deploy = require('child_process').exec
fs = require 'fs'
Inotify = require(INOTIFY_LIB).Inotify
inotify = new Inotify()
minimatch = require 'minimatch'
MiniLog = require 'minilog'
log = MiniLog APP
MiniLog.pipe process.stdout

class App
  @createConfig: (file) ->
    fs.writeFile file, JSON.stringify CONFIG_TEMPLATE, (error) ->
      if error then log.error error
      else log.info "created config file '#{file}'"
      process.exit if error then 1 else 0

  constructor: (config, verbose=false) ->
    @addItem = (path, globs) ->
      callback = (event) ->
        file = event.name or '[N/A]'
        for glob in Object.keys globs
          if minimatch file, glob
            log.info "matched target #{file} with directive '#{glob}'" if verbose
            warhead = globs[glob].replace TOKEN, (path + file)
            log.info "deploying warhead '#{warhead}'" if verbose
            deploy warhead, (error, stdout, stderr) ->
              if error then log.error stderr
              else log.debug stdout

      log.info "tracking target '#{path}'" if verbose
      props = path: path, watch_for: Inotify.IN_CLOSE_WRITE, callback: callback
      inotify.addWatch props

    @destroy = ->
      log.info "destroyed" if verbose
      inotify.close()

    log.info "version #{VERSION} deployed" if verbose
    fs.readFile config, 'utf-8', (error, data) =>
      if error
        log.error "error opening file '#{path}'. Check your syntax."
        return

      log.info "opened watch file '#{config}'" if verbose
      items = JSON.parse data
      @addItem item, items[item] for item in Object.keys items

args
  .version(VERSION)
  .option('-c, --config <path>', "set config file path")
  .option('-C, --create <path>', "create a boilerplate config file in the specified path")
  .option('-v, --verbose', "output events to stdout")
  .parse process.argv

if args.create then App.createConfig args.create
else app = new App args.config, args.verbose

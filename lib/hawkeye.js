// Generated by CoffeeScript 1.6.2
'use strict';
var App, CONFIG_TEMPLATE, CoffeeScript, DEFAULT_FILENAME, Inotify, MiniLog, RE_ENV, VERSION, app, args, deploy, fs, inotify, log, logBackend, minimatch, path;

CONFIG_TEMPLATE = "'.':\n\t'*': 'echo %% was just modified!'\n";

DEFAULT_FILENAME = '.hawkeye';

RE_ENV = /\$(\S+)/;

VERSION = '0.2.4';

args = require('commander');

CoffeeScript = require('../node_modules/coffee-script');

deploy = require('child_process').exec;

fs = require('fs');

Inotify = require('inotify').Inotify;

inotify = new Inotify();

minimatch = require('minimatch');

path = require('path');

MiniLog = require('minilog');

log = MiniLog('hawkeye');

logBackend = MiniLog.backends.nodeConsole;

MiniLog.pipe(logBackend).format(logBackend.formatNpm);

App = (function() {
  App.coffee = function(data) {
    return eval(CoffeeScript.compile(data, {
      bare: true
    }));
  };

  App.createConfig = function(file) {
    if (file == null) {
      file = DEFAULT_FILENAME;
    }
    return fs.writeFile(file, CONFIG_TEMPLATE, function(error) {
      if (error) {
        log.error(error);
      } else {
        log.info("created config file '" + file + "'");
      }
      return process.exit(error ? 1 : 0);
    });
  };

  App.handle = function(text, dir, file) {
    var env, key, rules, _i, _len, _ref;

    env = text.match(RE_ENV);
    text = !env ? text : text.replace(new RegExp("\\" + env[0], 'g'), process.env[env[1]]);
    rules = {
      b: path.basename(file, path.extname(file)),
      c: dir,
      d: new Date().toISOString(),
      e: path.extname(file),
      f: path.basename(file),
      h: process.env.PWD,
      '': path.join(dir, file)
    };
    _ref = Object.keys(rules);
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      key = _ref[_i];
      text = text.replace(new RegExp("%%" + key, 'g'), rules[key]);
    }
    return text;
  };

  function App(config, verbose) {
    var _this = this;

    if (verbose == null) {
      verbose = false;
    }
    this.addItem = function(dir, globs) {
      var callback, env, error;

      callback = function(event) {
        var file, glob, warhead, _i, _len, _ref, _results;

        file = event.name || 'n/a';
        _ref = Object.keys(globs);
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          glob = _ref[_i];
          if (minimatch(file, glob)) {
            log.debug("file " + file + " matched pattern '" + glob + "'");
            warhead = App.handle(globs[glob], dir, file);
            if (verbose) {
              log.info("launching '" + warhead + "'");
            }
            _results.push(deploy(warhead, function(error, stdout, stderr) {
              if (error) {
                return log.error(stderr);
              } else if (stdout) {
                return log.debug(stdout);
              }
            }));
          } else {
            _results.push(void 0);
          }
        }
        return _results;
      };
      try {
        return process.chdir(path.dirname(config));
      } catch (_error) {
        error = _error;
        log.error(error);
        return process.exit(1);
      } finally {
        env = dir.match(RE_ENV);
        dir = path.resolve(!env ? dir : dir.replace(new RegExp("\\" + env[0], 'g'), process.env[env[1]]));
        if (verbose) {
          log.info("tracking target '" + dir + "'");
        }
        inotify.addWatch({
          path: dir,
          watch_for: Inotify.IN_CLOSE_WRITE,
          callback: callback
        });
      }
    };
    fs.readFile(config, 'utf-8', function(error, data) {
      var item, items, _i, _len, _ref, _results;

      if (error) {
        log.error("error opening file '" + (path.resolve(config)) + "'. Check your syntax.");
        process.exit(1);
      }
      if (verbose) {
        log.info("version " + VERSION + " deployed");
      }
      if (verbose) {
        log.info("opened watch file '" + (path.resolve(config)) + "'");
      }
      items = App.coffee(data);
      _ref = Object.keys(items);
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        item = _ref[_i];
        _results.push(_this.addItem(item, items[item]));
      }
      return _results;
    });
  }

  return App;

})();

args.version(VERSION).option('-c, --config [path]', "use this config file [" + DEFAULT_FILENAME + "]", DEFAULT_FILENAME).option('-C, --create [path]', "create a new config file here [" + DEFAULT_FILENAME + "]", DEFAULT_FILENAME).option('-v, --verbose', "output events to stdout").parse(process.argv);

if (args.config === DEFAULT_FILENAME && args.create !== args.config) {
  App.createConfig(args.create);
} else {
  app = new App(args.config, args.verbose);
}

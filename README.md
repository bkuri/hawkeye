# hawkeye - track files and deploy commands at them.

Why reinvent the wheel?
-----------------------
This functionality was inspired by tools like [grunt][1] and [fsniper][2] (to name a few). The reason why I decided to take a whack at it was because I thought they are either too complex for the job at hand or too difficult to configure. Hawkeye uses a very simple configuration syntax to get you going. Plus it's written in around 70 lines of coffesscript, which is stuff that only nerds like me appreciate.

Target any file
---------------
You can use any valid glob-style pattern to target files. This is very useful for anything that requires real-time execution of a specific command as soon as a file changes on disk.

If you already know you way around the command line, you probably already know how to glob files:

* A single asterisk (\*) selects everything
* Specific extensions are specified with an asterisk followed by the extension (\*.txt)
* A literal file name can be specified by just naming it (i.e. *example.txt*)
* More complex patterns can be found in the [minimatch readme][3]

Run any command
---------------
The moment a tracked file is modified on disk, the related command is executed and the results are logged by stdout/stderr (for now, although I will add support for standard log files soon). Real time tracking is provided by the most excellent [node-]inotify.

Examples
--------
Create a JSON file on the current path which serves as a config file:

    $ hawkeye -C watch.json

A file with contents similar to this one is created:

    {
      "/your/path" : {
        "*" : "echo the file %% was just modified!"
      }
    }

Specify the path that you want to track by changing */your/path* with... well, your path. Then simply provide a pattern to track file(s) and the command to execute once a modification is detected. The two percentage signs get replaced with the absolute path of the file being tracked at runtime. For example, if you create a file called /your/path/example.txt, you will get the following command:

    $ echo file /your/path/example was just modified!

Which in this case will simply (you guessed it) echo that command on screen.

A slightly more complicated example:

    {
      "/etc" : {
        "*.conf" : "logger someone just changed %%",
      },
      "/mnt/downloads/" : {
        "*.pdf" : "mupdf %%",
        "*.zip": "unzip %%"
      }
    }

Both abosulte and relative paths work, so you can simply use a single dot to specify the current working directory:

    {
      "." : {
        "*.txt" : "echo the text file %% was just detected."
      }
    }

The tracking is NOT made recursively, so you will need to specify both the parent and child paths if you want to track them both:

    {
      "downloads/": {
        "*.pdf" : "logger 'new download: %%'"
      },
      "downloads/ebooks" : {
        "*.pdf" : "mupdf %%"
      }
    }

Running
-------
Once the config file is saved, point to it using the *-c* switch:

    $ hawkeye -c example.json

Add *-v* if you want verbose output:

    $ hawkeye -vc example.json
    hawkeye info version 0.0.1 deployed
    hawkeye info opened watch file './example.json'
    hawkeye info tracking target '/any/absolute/path'
    hawkeye info tracking target 'relative/paths/too'

Usage
-----
    $ hawkeye -h

    Usage: hawkeye [options]

      Options:

        -h, --help           output usage information
        -V, --version        output the version number
        -c, --config <path>  set config file path
        -C, --create <path>  create a boilerplate config file in the specified path
        -v, --verbose        output events to stdout

Credits
-------
Hawkeye uses the following excellent libraries:

* [commander.js][3] for command-line parsing (like a boss)
* [node-inotify][4] for tracking directories (like a boss)
* [minimatch][5] for glob-style file matching (like a boss)
* [minilog][6] for logging (like a boss)

Finally
-------
If you happen to be running this under Linux with systemd, you can use [this service file][7] to run hawkeye in the background (like a boss).

Contact
-------
Feel free to fork away and/or submit a pull request. If you want to contact me directly, you can email me ([hawkeye at bkuri.com][8]) or send me a tweet ([@bkuri][9]). I read and try to reply to everything.

[1]: http://gruntjs.com                          "Grunt website"
[2]: https://github.com/l3ib/fsniper             "fsniper"
[3]: https://github.com/visionmedia/commander.js "Commander.js"
[4]: https://github.com/c4milo/node-inotify      "node-inotify"
[5]: https://github.com/isaacs/minimatch         "minimatch"
[6]: https://github.com/mixu/minilog             "minilog"
[7]: https://dropbox.com/                        "systemd service file"
[8]: mailto:hawkeye@bkuri.com                    "e-mail me"
[9]: https://twitter.com/bkuri                   "tweet tweet"

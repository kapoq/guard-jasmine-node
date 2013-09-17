Guard::JasmineNode [![travis-ci](https://secure.travis-ci.org/kapoq/guard-jasmine-node.png)](https://secure.travis-ci.org/kapoq/guard-jasmine-node)
==================

JasmineNode guard automatically & intelligently executes jasmine node specs when files are modified.

It works brilliantly with Node projects whereas [guard-jasmine](https://github.com/netzpirat/guard-jasmine)
looks better for jasmine specs in the context of e.g. a Rails app.

* Tested against Node 0.8.9, jasmine-node 1.0.26

Requirements
------------

* [Node](http://nodejs.org/)
* [jasmine-node](https://github.com/mhevery/jasmine-node)
* [Ruby](http://ruby-lang.org) and rubygems

Install
-------

Install the gem:

    $ gem install guard-jasmine-node

Add guard definition to your Guardfile by running this command:

    $ guard init jasmine-node

Usage
-----

    $ guard

This will watch your project and execute your specs when files
change. It's worth checking out [the docs](https://github.com/guard/guard#readme).

Options
-------

* `:all_on_start     # default => true`

Run all the specs as soon as Guard is started.

* `:all_after_pass   # default => true`

When files are modified and the specs covering the modified files
pass, run all the specs automatically.

* `:keep_failed      # default => true`

When files are modified, run failing specs as well as specs covering
the modified files.

* `:notify           # default => true` 

Display growl/libnotify notifications.

* `:coffeescript     # default => true`

Load coffeescript and all execution of .coffee files.

* `:forceexit        # default => false`

Force jasmine-node process to quit after test (can help fix hanging specs)

* `:verbose     # default => false`

Execute jasmine-node in verbose mode

* `:spec_paths  # default => [spec]`

Array of paths containing all specs (supply a comma-separated list of paths to override the default)

* `:jasmine_node_bin`

Specify the path to the jasmine-node binary that will execute your specs.

The default `:jasmine_node_bin` in the Guardfile assumes:

* you are running guard from the root of the project
* you installed jasmine-node using npm
* you installed jasmine-node locally to node_modules

If you delete the option completely from the Guardfile, it assumes the
jasmine-node binary is already in your `$PATH`.

So if you have installed jasmine-node globally using e.g. `npm install
-g jasmine-node`, remove the `:jasmine_node_bin` option from the Guardfile.

Guardfile
---------

Please read the [guard docs](https://github.com/guard/guard#readme) for
more information about the Guardfile DSL.

It's powerful stuff.

Development
-----------

* Source hosted at [GitHub](https://github.com/kapoq/guard-jasmine-node)
* Report issues/Questions/Feature requests on [GitHub Issues](https://github.com/kapoq/guard-jasmine-node/issues)
* CI at [Travis](http://travis-ci.org/#!/textgoeshere/guard-jasmine-node)

Pull requests are very welcome! Make sure your patches are well tested. Please create a topic branch for every separate change
you make.

TODO
----

* write a JsonFormatter for jasmine-node so we have finer-grained
  control over rendering output
* write an RSpec-style progress formatter (aka lots of green dots)
* patch Guard to locate CamelCased modules correctly

Testing
-------

    $ rake

Author
------

[Dave Nolan](http://kapoq.com)

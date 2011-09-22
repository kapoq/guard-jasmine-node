Guard::JasmineNode ![travis-ci](http://travis-ci.org/textgoeshere/guard-jasmine-node.png)
==================

JasmineNode guard allows to automatically & intelligently execute
jasmine node specs when files are modified.

It works brilliantly with Node projects whereas [guard-jasmine](https://github.com/netzpirat/guard-jasmine)
looks better for jasmine specs in the context of e.g. a Rails app.

* Compatible with RSpec 1.x & RSpec 2.x (>= 2.4 needed for the notification feature)
* Tested against Node 0.4, jasmine-node 1.0.10

Requirements
------------

* [Node](http://nodejs.org/)
* [jasmine-node](https://github.com/mhevery/jasmine-node)
* [Ruby](http://ruby-lang.org)

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

guard-jasmine-node allows you to specify the path to the jasmine-node
binary that will execute your specs.

Just change the `:jasmine_node_bin` option in your Guardfile.

The default `:jasmine_node_bin` assumes:

* you are running guard from the root of the project
* you installed jasmine-node using npm
* you installed jasmine-node locally to node_modules

For more information, please read the [guard docs](https://github.com/guard/guard#readme)

Guardfile
---------

Please read the [guard docs](https://github.com/guard/guard#readme) for
more information about the Guardfile DSL.

It's powerful stuff.

Development
-----------

* Source hosted at [GitHub](https://github.com/kapoq/guard-jasmine-node)
* Report issues/Questions/Feature requests on [GitHub Issues](https://github.com/kapoq/guard-jasmine-node/issues)

Pull requests are very welcome! Make sure your patches are well tested. Please create a topic branch for every separate change
you make.

Testing
-------

  $ rake

Author
------

[Dave Nolan](https://github.com/textgoeshere)

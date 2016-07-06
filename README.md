# MemoryTestFix

A simple fix to run your Rails tests with sqlite. From the
[example by Chris Roos](http://blog.seagul.co.uk/articles/2006/02/08/in-memory-sqlite-database-for-rails-testing).

## Status

[![Dependency Status](https://gemnasium.com/mvz/memory_test_fix.png)](https://gemnasium.com/mvz/memory_test_fix)
[![Build Status](https://travis-ci.org/mvz/memory_test_fix.png?branch=master)](https://travis-ci.org/mvz/memory_test_fix)
[![Code Climate](https://codeclimate.com/github/mvz/memory_test_fix.png)](https://codeclimate.com/github/mvz/memory_test_fix)

## Usage

Add the gem to your bundle by adding

    gem 'memory_test_fix'

to your `Gemfile`.

In your database.yml, use:

    test:
      adapter: sqlite3
      database: ":memory:"

It runs much faster!

You can also adjust the verbosity of the output:

    test:
      adapter: sqlite3
      database: ":memory:"
      verbosity: silent

To use rails migrations instead of loading `db/schema.rb`

    test:
      adapter: sqlite3
      database: ":memory:"
      migrate: true

You can also use this with other (testing) environments, not just 'test'.

## Rails Versions

In general, Bundler should pick a compatible version for you if you don't
specify one in your `Gemfile`.

That said, the latest version of this gem is compatible with Rails 5.0.
If you're still on Rails 4, you can use version 1.3.0. Unfortunately, the hard
requirement of Ruby 2.2 or above for Rails 5 means `memory_test_fix` cannot
support Rails 4 and 5 at the same time.

If you're using a version of Rails older than 4, your first priority should be
upgrading Rails. If that's really not an option, you can use version 1.2.2 of
this gem with Rails 3.2. If you're using Rails 3.1 or 3.0, use version 1.1.0.
If you're using Rails 2.3, use version 0.2.2. If you're using an even older
version of Rails, use version 0.1.3.

## Authors

The [original
hack](http://chrisroos.co.uk/blog/2006-02-08-in-memory-sqlite-database-for-rails-testing)
this gem is based on was created by Chris Roos.

The hack was adapted as a Rails plugin by [Geoffrey
Grosenbach](http://nubyonrails.com).

The following people have contributed:

* Kakutani Shintaro
* Matijs van Zuijlen
* Erik Hanson & Matt Scilipoti
* Greg Weber
* Stephan Zalewski

MemoryTestFix is maintained by [Matijs van Zuijlen](http://www.matijs.net/)

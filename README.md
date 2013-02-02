# MemoryTestFix

A simple fix to run your Rails tests with sqlite. From the
[example by Chris Roos](http://blog.seagul.co.uk/articles/2006/02/08/in-memory-sqlite-database-for-rails-testing).

## Usage

Add the gem to your bundle by adding

```ruby
  gem 'memory_test_fix'
```

to your `Gemfile`


In your database.yml, use:

```yaml
  test:
    adapter: sqlite3
    database: ":memory:"
```

It runs much faster!

You can also adjust the verbosity of the output:

```yaml
  test:
    adapter: sqlite3
    database: ":memory:"
    verbosity: silent
```

You can also use this with other (testing) environments, not just 'test'.

## Rails Versions

This gem is compatible with Rails 3 and Rails 2.3. If you're using an
older version of Rails, use the 0.1.x version of this gem.

## Authors

MemoryTestFix is maintained by [Matijs van Zuijlen](http://www.matijs.net/)

The following people have contributed to this gem:

* [Original hack](http://chrisroos.co.uk/blog/2006-02-08-in-memory-sqlite-database-for-rails-testing) by Chris Roos
* Adapted by [Geoffrey Grosenbach](http://nubyonrails.com)
* Verbosity patch by Kakutani Shintaro
* Adapted as GemPlugin by Matijs van Zuijlen
* Support for environments besides 'test' by Erik Hanson & Matt Scilipoti
* Support for Rails 3 by Greg Weber
* Fix for Rails 3.2 by Stephan Zalewski

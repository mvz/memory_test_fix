# Changelog

## 1.2.2 / 2014-09-09

* Make dependency declaration match set of supported Rails versions
* Document public API
* Add integration test for upcoming Rails 4.2

## 1.2.1 / 2014-09-07

* Ensure all files are available in the gem

## 1.2.0 / 2014-09-07

* Drop support for Rails 3.0 and 3.1

## 1.1.0 / 2014-08-30

* Officially add support for Rails 4.1
* Add 'migrate' option (thanks, Stephan Zalewski)
* Use railties to run init_schema at the appropriate moment
  (thanks, Stephan Zalewski)
* Fix Rails 4.0 support by initializing the schema whenever an
  ActiveRecord connection is established

## 1.0.0 / 2014-04-07

* Officially add support for Rails 4.0
* Drop support for Rails 2.3

## 0.2.2 / 2013-02-02

* Fix broken Rails 3.0 compatibility
* Restore Rails 2.3 compatibility

## 0.2.1 / 2013-02-02

* Add support for Rails 3.2 (thanks, Stephan Zalewski)

## 0.2.0 / 2011-01-06

* Rails 3 compatibility (thanks, Greg Weber)
* Only support Rails 3
* Use Rails 3 plugin loading mechanism to avoid loading the schema
  before initialization is complete
* Use 'verbosity' setting from the current environment, not from
  'test'

## 0.1.3 / 2010-06-26

* Support other environments besides 'test' (thanks, Erik Hanson &
  Matt Scilipoti)

## 0.1.1 / 2009-02-08

* Fix broken gemspec that did not include any files, nor all
  authors.

## 0.1 / 2009-02-08

* Initial release as a GemPlugin

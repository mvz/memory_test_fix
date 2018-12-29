# frozen_string_literal: true

require 'rake'
require 'rake/testtask'
require 'rspec/core/rake_task'
require 'bundler/gem_tasks'
require 'rake/clean'

CLEAN.include 'fixtures/**/Gemfile.lock'
CLOBBER.include 'pkg'

desc 'Default: run tests.'
task default: :test

namespace :test do
  Rake::TestTask.new(:integration) do |t|
    t.libs += %w(lib test)
    t.pattern = 'test/integration/**/*_test.rb'
    t.verbose = true
  end
end

RSpec::Core::RakeTask.new(:spec)

desc 'Test the memory_test_fix plugin.'
task test: [:spec, 'test:integration']

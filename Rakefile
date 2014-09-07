require 'rake'
require 'rake/testtask'
require 'rspec/core/rake_task'

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

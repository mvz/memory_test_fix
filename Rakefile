require 'rake'
require 'rake/testtask'
require 'rdoc/task'

desc 'Default: run unit tests.'
task default: :test

namespace :test do
  Rake::TestTask.new(:integration) do |t|
    t.libs += ['lib', 'test']
    t.pattern = 'test/integration/**/*_test.rb'
    t.verbose = true
  end

  Rake::TestTask.new(:unit) do |t|
    t.libs << 'test'
    t.pattern = 'test/unit/**/*_test.rb'
    t.verbose = true
  end
end

desc 'Generate documentation for the memory_test_fix gem.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'MemoryTestFix'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc 'Test the memory_test_fix plugin.'
task test: ['test:unit', 'test:integration']

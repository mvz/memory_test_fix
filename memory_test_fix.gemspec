Gem::Specification.new do |spec|
  spec.name = 'memory_test_fix'
  spec.version = '1.5.0'

  spec.authors = ['Matijs van Zuijlen',
                  'Chris Roos',
                  'Geoffrey Grosenbach',
                  'Kakutani Shintaro',
                  'Erik Hanson and Matt Scilipoti',
                  'Greg Weber',
                  'Stephan Zalewski']
  spec.email = 'matijs@matijs.net'
  spec.homepage = 'http://wiki.github.com/mvz/memory_test_fix'

  spec.license = 'MIT'

  spec.summary = 'Use SQLite3 in-memory database for Rails tests.'
  spec.description = <<-TEXT
    Makes use of SQLite3 in-memory database possible for your
    Rails tests by preloading the schema.
  TEXT
  spec.required_ruby_version = '>= 2.2.0'

  spec.files = Dir['{lib,test,spec,fixtures}/**/*',
                   '*.md',
                   '*.gemspec',
                   'Rakefile',
                   'Gemfile'] & `git ls-files -z`.split("\0")

  spec.rdoc_options = ['--main', 'README.md']
  spec.extra_rdoc_files = ['README.md']

  spec.add_runtime_dependency('activerecord', '~> 5.0')
  spec.add_runtime_dependency('railties', '~> 5.0')
  spec.add_development_dependency('minitest', '~> 5.2')
  spec.add_development_dependency('rake', '~> 12.0')
  spec.add_development_dependency('rspec', '~> 3.1')
end

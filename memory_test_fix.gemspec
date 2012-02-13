Gem::Specification.new do |s|
  s.name = "memory_test_fix"
  s.version = "0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Chris Roos", "Geoffrey Grosenbach", "Kakutani Shintaro",
    "Erik Hanson and Matt Scilipoti", "Matijs van Zuijlen", "Greg Weber", 'Stephan Zalewski']
  s.email = "matijs@matijs.net"
  s.summary = "Makes SQLite3 memory tests possible by preloading the schema."
  s.homepage = "http://wiki.github.com/mvz/memory_test_fix"
  s.require_paths = ["lib"]
  s.files = ["lib/memory_test_fix.rb",  "lib/memory_test_fix/railtie.rb", "lib/memory_test_fix/schema_loader.rb", "README.md", "memory_test_fix.gemspec"]
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.md']
  s.rubygems_version = %q{1.2.0}
  s.add_runtime_dependency('railties', '>= 3.0.0')
end

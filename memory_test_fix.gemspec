Gem::Specification.new do |s|
  s.name = "memory_test_fix"
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Chris Roos", "Geoffrey Grosenbach", "Kakutani Shintaro",
    "Erik Hanson and Matt Scilipoti", "Matijs van Zuijlen"]
  s.email = "matijs@matijs.net"
  s.summary = "Makes SQLite3 memory tests possible by preloading the schema."
  s.homepage = "http://wiki.github.com/mvz/memory_test_fix"
  s.require_paths = ["lib"]
  s.files = ["init.rb", "rails/init.rb", "lib/memory_test_fix.rb", "README", "memory_test_fix.gemspec"]
  s.has_rdoc = true
  s.extra_rdoc_files = ['README']
  s.rubygems_version = %q{1.2.0}
end

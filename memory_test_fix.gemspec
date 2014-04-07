Gem::Specification.new do |s|
  s.name = "memory_test_fix"
  s.version = "0.2.2"

  if s.respond_to? :required_rubygems_version=
    s.required_rubygems_version = Gem::Requirement.new(">= 0")
  end

  s.authors = [ "Matijs van Zuijlen",
                "Chris Roos",
                "Geoffrey Grosenbach",
                "Kakutani Shintaro",
                "Erik Hanson and Matt Scilipoti",
                "Greg Weber",
                "Stephan Zalewski" ]
  s.email = "matijs@matijs.net"

  s.summary = "Use SQLite3 in-memory database for Rails tests."
  s.description = "Makes use of SQLite3 in-memory database possible for your Rails tests by preloading the schema."

  s.homepage = "http://wiki.github.com/mvz/memory_test_fix"
  s.require_paths = ["lib"]
  s.files = ["init.rb",
             "rails/init.rb",
             "lib/memory_test_fix.rb",
             "README.md",
             "memory_test_fix.gemspec"]
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.md']
  s.rubygems_version = %q{1.2.0}

  s.add_development_dependency('rake')
  s.add_development_dependency('minitest', '~> 5.2')
end

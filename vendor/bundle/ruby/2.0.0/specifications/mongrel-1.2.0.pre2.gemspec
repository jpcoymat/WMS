# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "mongrel"
  s.version = "1.2.0.pre2"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.authors = ["Zed A. Shaw"]
  s.date = "2010-03-17"
  s.description = "Mongrel is a small library that provides a very fast HTTP 1.1 server for Ruby web applications.  It is not particular to any framework, and is intended to be just enough to get a web application running behind a more complete and robust web server.\n\nWhat makes Mongrel so fast is the careful use of an Ragel extension to provide fast, accurate HTTP 1.1 protocol parsing. This makes the server scream without too many portability issues.\n\nSee http://mongrel.rubyforge.org for more information."
  s.email = ["mongrel-users@rubyforge.org"]
  s.executables = ["mongrel_rails"]
  s.extensions = ["ext/http11/extconf.rb"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt", "LICENSE"]
  s.files = ["bin/mongrel_rails", "History.txt", "Manifest.txt", "README.txt", "LICENSE", "ext/http11/extconf.rb"]
  s.homepage = "http://mongrel.rubyforge.org/"
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib", "ext"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.6")
  s.rubyforge_project = "mongrel"
  s.rubygems_version = "2.0.6"
  s.summary = "Mongrel is a small library that provides a very fast HTTP 1.1 server for Ruby web applications"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<gem_plugin>, ["~> 0.2.3"])
      s.add_runtime_dependency(%q<daemons>, ["~> 1.0.10"])
      s.add_development_dependency(%q<rubyforge>, [">= 2.0.3"])
      s.add_development_dependency(%q<gemcutter>, [">= 0.3.0"])
      s.add_development_dependency(%q<rake-compiler>, ["~> 0.7.0"])
      s.add_development_dependency(%q<hoe>, [">= 2.5.0"])
    else
      s.add_dependency(%q<gem_plugin>, ["~> 0.2.3"])
      s.add_dependency(%q<daemons>, ["~> 1.0.10"])
      s.add_dependency(%q<rubyforge>, [">= 2.0.3"])
      s.add_dependency(%q<gemcutter>, [">= 0.3.0"])
      s.add_dependency(%q<rake-compiler>, ["~> 0.7.0"])
      s.add_dependency(%q<hoe>, [">= 2.5.0"])
    end
  else
    s.add_dependency(%q<gem_plugin>, ["~> 0.2.3"])
    s.add_dependency(%q<daemons>, ["~> 1.0.10"])
    s.add_dependency(%q<rubyforge>, [">= 2.0.3"])
    s.add_dependency(%q<gemcutter>, [">= 0.3.0"])
    s.add_dependency(%q<rake-compiler>, ["~> 0.7.0"])
    s.add_dependency(%q<hoe>, [">= 2.5.0"])
  end
end

# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "aasm"
  s.version = "3.0.24"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Scott Barron", "Scott Petersen", "Travis Tilley", "Thorsten Boettger"]
  s.date = "2013-11-20"
  s.description = "AASM is a continuation of the acts as state machine rails plugin, built for plain Ruby objects."
  s.email = "scott@elitists.net, ttilley@gmail.com, aasm@mt7.de"
  s.homepage = "https://github.com/aasm/aasm"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.6"
  s.summary = "State machine mixin for Ruby objects"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<activerecord>, ["= 3.2.15"])
      s.add_development_dependency(%q<mongoid>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<sdoc>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.14"])
      s.add_development_dependency(%q<rr>, [">= 0"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
      s.add_development_dependency(%q<ruby-debug-completion>, [">= 0"])
      s.add_development_dependency(%q<mime-types>, ["~> 1.25"])
      s.add_development_dependency(%q<coveralls>, [">= 0"])
    else
      s.add_dependency(%q<activerecord>, ["= 3.2.15"])
      s.add_dependency(%q<mongoid>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<sdoc>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.14"])
      s.add_dependency(%q<rr>, [">= 0"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
      s.add_dependency(%q<minitest>, [">= 0"])
      s.add_dependency(%q<ruby-debug-completion>, [">= 0"])
      s.add_dependency(%q<mime-types>, ["~> 1.25"])
      s.add_dependency(%q<coveralls>, [">= 0"])
    end
  else
    s.add_dependency(%q<activerecord>, ["= 3.2.15"])
    s.add_dependency(%q<mongoid>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<sdoc>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.14"])
    s.add_dependency(%q<rr>, [">= 0"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
    s.add_dependency(%q<minitest>, [">= 0"])
    s.add_dependency(%q<ruby-debug-completion>, [">= 0"])
    s.add_dependency(%q<mime-types>, ["~> 1.25"])
    s.add_dependency(%q<coveralls>, [">= 0"])
  end
end

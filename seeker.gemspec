# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "seeker"
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Joel Holder"]
  s.date = "2012-02-06"
  s.description = "Rapid lookup of bulk list content using network content and services"
  s.email = "jclosure@gmail.com"
  s.extra_rdoc_files = ["CHANGELOG", "README.rdoc", "lib/domain_name.rb", "lib/retryable.rb", "lib/seeker.rb"]
  s.files = ["CHANGELOG", "Gemfile", "README.rdoc", "Rakefile", "init.rb", "lib/domain_name.rb", "lib/retryable.rb", "lib/seeker.rb", "seeker.gemspec", "spec/factories.rb", "spec/seeker_spec.rb", "spec/spec_helper.rb", "spec/testfile.out.txt", "spec/testfile.txt", "Manifest"]
  s.homepage = "http://github.com/jclosure/seeker"
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Seeker", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "seeker"
  s.rubygems_version = "1.8.15"
  s.summary = "Rapid lookup of bulk list content using network content and services"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<whois>, [">= 0"])
      s.add_runtime_dependency(%q<activerecord>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<echoe>, [">= 0"])
    else
      s.add_dependency(%q<whois>, [">= 0"])
      s.add_dependency(%q<activerecord>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<echoe>, [">= 0"])
    end
  else
    s.add_dependency(%q<whois>, [">= 0"])
    s.add_dependency(%q<activerecord>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<echoe>, [">= 0"])
  end
end

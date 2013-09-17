# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "guard/jasmine_node/version"

Gem::Specification.new do |s|
  s.name        = "guard-jasmine-node"
  s.version     = Guard::JasmineNodeVersion::VERSION
  s.authors     = ["dave@kapoq.com"]
  s.email       = ["dave@kapoq.com"]
  s.homepage    = "https://github.com/kapoq/guard-jasmine-node"
  s.summary     = %q{Guard::JasmineNode automatically runs your Jasmine Node specs when files are modified}
  s.description = %q{}
  s.license     = "MIT"

  s.rubyforge_project = "guard-jasmine-node"

  s.add_dependency "guard", ">= 0.4"
  
  s.add_development_dependency "rspec"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "rake"
  if RUBY_PLATFORM =~ /linux/
    s.add_development_dependency "rb-inotify"
    s.add_development_dependency "libnotify"
  end
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end

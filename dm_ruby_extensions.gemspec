# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dm_ruby_extensions/version'

Gem::Specification.new do |gem|
  gem.name          = "dm_ruby_extensions"
  gem.version       = DmRubyExtensions::VERSION
  gem.authors       = ["Brett Walker"]
  gem.email         = ["github@digitalmoksha.com"]
  gem.description   = %q{Simple Ruby base class extensions}
  gem.summary       = %q{Simple Ruby base class extensions}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  
end

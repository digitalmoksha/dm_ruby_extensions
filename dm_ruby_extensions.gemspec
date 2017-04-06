# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dm_ruby_extensions/version'

Gem::Specification.new do |gem|
  gem.name          = "dm_ruby_extensions"
  gem.version       = DmRubyExtensions::VERSION
  gem.authors       = ["Brett Walker"]
  gem.email         = ["github@digitalmoksha.com"]
  gem.description   = %q{Ruby base class extensions}
  gem.summary       = %q{Simple Ruby base class extensions}
  gem.homepage      = "https://github.com/digitalmoksha/dm_ruby_extensions"
  gem.licenses      = ['MIT']

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_dependency 'activesupport', '>= 4.0'
end

# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dm_ruby_extensions/version'

Gem::Specification.new do |gem|
  gem.name          = 'dm_ruby_extensions'
  gem.version       = DmRubyExtensions::VERSION
  gem.authors       = ['Brett Walker']
  gem.email         = ['github@digitalmoksha.com']
  gem.description   = 'Ruby base class extensions'
  gem.summary       = 'Simple Ruby base class extensions'
  gem.homepage      = 'https://github.com/digitalmoksha/dm_ruby_extensions'
  gem.licenses      = ['MIT']

  gem.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.required_ruby_version = '~> 3.0'

  gem.add_dependency 'activesupport', '>= 6.0'
end

# frozen_string_literal: true

require_relative 'lib/dm_ruby_extensions/version'

Gem::Specification.new do |gem|
  gem.name          = 'dm_ruby_extensions'
  gem.version       = DmRubyExtensions::VERSION
  gem.authors       = ['Brett Walker']
  gem.email         = ['github@digitalmoksha.com']
  gem.description   = 'Ruby base class extensions'
  gem.summary       = 'Simple Ruby base class extensions'
  gem.homepage      = 'https://github.com/digitalmoksha/dm_ruby_extensions'
  gem.licenses      = ['MIT']

  gem.metadata = {
    'source_code_uri' => gem.homepage,
    'changelog_uri' => "#{gem.homepage}/blob/master/CHANGELOG.md",
    'bug_tracker_uri' => "#{gem.homepage}/issues",
    'rubygems_mfa_required' => 'true'
  }

  gem.files         = Dir['lib/**/*.rb', 'README.md', 'CHANGELOG.md', 'LICENSE']
  gem.require_paths = ['lib']

  gem.required_ruby_version = '>= 3.2'

  gem.add_dependency 'activesupport', '>= 6.0', '< 9'
end

# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'bemer/version'

Gem::Specification.new do |spec| # rubocop:disable Metrics/BlockLength
  spec.name             = 'bemer'
  spec.version          = Bemer::VERSION
  spec.author           = 'Alexander Grigorev'
  spec.email            = 'vill@rubyinventory.org'
  # rubocop:disable Metrics/LineLength
  spec.summary          = 'Build reusable UI components for Rails applications with the ability to use the BEM methodology.'
  spec.description      = 'Build reusable UI components for Rails applications with the ability to use the BEM methodology.'
  # rubocop:enable Metrics/LineLength
  spec.license          = 'MIT'
  spec.require_paths    = ['lib']
  spec.files            = Dir['lib/**/*.rb', 'LICENSE-RU.txt', 'LICENSE.txt']
  spec.test_files       = Dir['spec/**/*']
  spec.extra_rdoc_files = Dir['README.md', 'docs/*.md']

  spec.metadata = {
    'bug_tracker_uri'   => 'https://github.com/vill/bemer/issues',
    'documentation_uri' => 'https://github.com/vill/bemer/tree/master/docs',
    'homepage_uri'      => 'https://github.com/vill/bemer',
    'source_code_uri'   => 'https://github.com/vill/bemer'
  }

  spec.required_ruby_version     = '>= 2.2.0'
  spec.required_rubygems_version = '>= 2.2.0'

  spec.add_development_dependency 'appraisal',           '~> 2.2.0' # rubocop:disable Layout/ExtraSpacing, Metrics/LineLength
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'bundler-audit',       '~> 0.6.1'
  spec.add_development_dependency 'fasterer',            '~> 0.7.1'
  spec.add_development_dependency 'fuubar',              '~> 2.5.0'
  spec.add_development_dependency 'overcommit',          '~> 0.47.0'
  spec.add_development_dependency 'rake',                '~> 12.3.3'
  spec.add_development_dependency 'rspec',               '~> 3.9.0'
  spec.add_development_dependency 'rspec-html-matchers', '~> 0.9.2'
  spec.add_development_dependency 'rspec-rails',         '~> 3.9.0'
  spec.add_development_dependency 'rubocop',             '~> 0.68.1'
  spec.add_development_dependency 'rubocop-rspec',       '~> 1.32.0'
  spec.add_development_dependency 'wwtd',                '~> 1.4.0'

  spec.add_runtime_dependency 'railties', '>= 3.2.22'
end

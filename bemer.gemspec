# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'bemer/version'

Gem::Specification.new do |spec| # rubocop:disable Metrics/BlockLength
  spec.name          = 'bemer'
  spec.version       = Bemer::VERSION
  spec.author        = 'Alexander Grigorev'
  spec.email         = 'vill@rubyinventory.org'
  # rubocop:disable Metrics/LineLength
  spec.summary       = 'Build reusable UI components for Rails applications using the BEM methodology.'
  spec.description   = 'Build reusable UI components for Rails applications using the BEM methodology.'
  # rubocop:enable Metrics/LineLength
  spec.homepage      = 'https://github.com/vill/bemer'
  spec.license       = 'MIT'
  spec.require_paths = ['lib']
  spec.test_files    = `git ls-files -z -- spec/*`.split("\x0")
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^spec/|^docs/|^Gemfile.lock$})
  end

  spec.required_ruby_version     = '>= 2.2.0'
  spec.required_rubygems_version = '>= 2.2.0'

  spec.add_development_dependency 'appraisal',     '~> 2.2.0'
  spec.add_development_dependency 'bundler',       '~> 1.16.2'
  spec.add_development_dependency 'bundler-audit', '~> 0.6.0'
  spec.add_development_dependency 'fasterer',      '~> 0.4.1'
  spec.add_development_dependency 'overcommit',    '~> 0.46.0'
  spec.add_development_dependency 'rake',          '~> 12.3.0'
  spec.add_development_dependency 'rspec',         '~> 3.7.0'
  spec.add_development_dependency 'rspec-rails',   '~> 3.7.2'
  spec.add_development_dependency 'rubocop',       '~> 0.59.1'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.29.1'
  spec.add_development_dependency 'wwtd',          '~> 1.3'

  spec.add_runtime_dependency 'railties', '>= 3.2.22', '<= 5.2'
end

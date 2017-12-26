# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'bemer/version'

Gem::Specification.new do |spec|
  spec.name          = 'bemer'
  spec.version       = Bemer::VERSION
  spec.author        = 'Alexander Grigorev'
  spec.email         = 'vill@rubyinventory.org'
  # rubocop:disable Metrics/LineLength
  spec.summary       = 'Build reusable UI components for Rails applications using the BEM methodology.'
  spec.description   = 'Build reusable UI components for Rails applications using the BEM methodology.'
  # rubocop:enable Metrics/LineLength
  spec.license       = 'MIT'
  spec.require_paths = ['lib']
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/|^Gemfile.lock$})
  end

  spec.required_ruby_version     = '>= 2.0.0'
  spec.required_rubygems_version = '>= 2.2.0'

  spec.add_development_dependency 'bundler',          '~> 1.15'
  spec.add_development_dependency 'rails',            '~> 5.1.4'
  spec.add_development_dependency 'rake',             '~> 12.3.0'
  spec.add_development_dependency 'require_reloader', '~> 0.2.1'
  spec.add_development_dependency 'rubocop',          '~> 0.51.0'
  spec.add_development_dependency 'sqlite3',          '~> 1.3.13'

  spec.add_runtime_dependency 'railties', '>= 3.2', '<= 5.2'
end

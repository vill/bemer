# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in bemer.gemspec
gemspec

unless ENV['CI'] || ENV['APPRAISAL']
  gem 'actionmailer',    '~> 6.0.2'
  gem 'bundler',         '~> 2.1.4'
  gem 'railties',        '~> 6.0.2'
  gem 'sprockets-rails', '~> 3.2.1'
end

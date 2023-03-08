# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in bemer.gemspec
gemspec

gem 'fuubar',              '~> 2.5.0'
gem 'rake',                '~> 12.3.3'
gem 'rspec',               '~> 3.9.0'
gem 'rspec-html-matchers', '~> 0.9.2'
gem 'rspec-rails',         '~> 3.9.0'
gem 'wwtd',                '~> 1.4.0'

unless ENV['CI'] || ENV['APPRAISAL']
  gem 'actionmailer',        '~> 7.0.4.2'
  gem 'appraisal',           '~> 2.4.1'
  gem 'bundler',             '~> 2.1.4'
  gem 'bundler-audit',       '~> 0.9.1'
  gem 'fasterer',            '~> 0.7.1'
  gem 'overcommit',          '~> 0.47.0'
  gem 'railties',            '~> 7.0.4.2'
  gem 'rubocop',             '~> 0.68.1'
  gem 'rubocop-performance', '~> 1.3.0'
  gem 'rubocop-rspec',       '~> 1.38.1'
  gem 'sprockets-rails',     '~> 3.2.1'
end

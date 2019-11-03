# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in bemer.gemspec
gemspec

gem 'actionmailer',    '~> 4.2.11'
gem 'railties',        '~> 4.2.11'
gem 'sprockets-rails', '~> 2.0.0' unless ENV['WITHOUT_SPROCKETS_RAILS_FROM_GEMFILE']

# Fix Loofah XSS Vulnerability. See: https://github.com/flavorjones/loofah/issues/171
gem 'loofah', '~> 2.3.1'

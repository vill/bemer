# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in bemer.gemspec
gemspec

gem 'rails-html-sanitizer', '~> 1.0.4'

gem 'nokogiri', '~> 1.8', '>= 1.8.2'

group :development do
  # Auto-reload require files or local gems without restarting server during Rails development.
  gem 'require_reloader', '~> 0.2.1', git: 'https://github.com/vill/require_reloader.git',
                                      branch: 'bugfix/delete-watchable-gems'
end

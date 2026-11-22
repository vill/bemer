# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in bemer.gemspec
gemspec

# The instafailing RSpec progress bar formatter
gem 'fuubar', '~> 2.5.0'

# Rake is a Make-like program implemented in Ruby
gem 'rake', '~> 12.3.3'

# BDD for Ruby
gem 'rspec', '~> 3.9.0'

# RSpec matchers for testing your html
gem 'rspec-html-matchers', '~> 0.9.2'

# RSpec for Rails
gem 'rspec-rails', '~> 3.9.0'

# Travis simulator so you do not need to wait for the build
gem 'wwtd', '~> 1.4.0'

unless ENV['CI'] || ENV['APPRAISAL']
  # Email on Rails. Compose, deliver, and test emails using the familiar controller/view pattern.
  gem 'actionmailer', '~> 7.0.4.2'

  # Appraisal integrates with bundler and rake to test your library against different versions of dependencies in repeatable scenarios called "appraisals."
  gem 'appraisal', '~> 2.4.1'

  # Rails internals: application bootup, plugins, generators, and rake tasks.
  gem 'railties', '~> 7.0.4.2'

  # Sprockets Rails integration
  gem 'sprockets-rails', '~> 3.2.1'
end

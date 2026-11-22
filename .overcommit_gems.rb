# frozen_string_literal: true

source 'https://rubygems.org'

# bundler-audit provides patch-level verification for Bundled apps.
gem 'bundler-audit', '~> 0.9.1'

# Use Fasterer to check various places in your code that could be faster.
gem 'fasterer', '~> 0.7.1'

# Utility to install, configure, and extend Git hooks
gem 'overcommit', '~> 0.47.0'

# RuboCop is a Ruby code style checking and code formatting tool. It aims to enforce the community-driven Ruby Style Guide.
gem 'rubocop', '~> 0.68.1'

# A collection of RuboCop cops to check for performance optimizations in Ruby code.
gem 'rubocop-performance', '~> 1.3.0'

# Code style checking for RSpec files. A plugin for the RuboCop code style enforcing & linting tool.
gem 'rubocop-rspec', '~> 1.38.1'

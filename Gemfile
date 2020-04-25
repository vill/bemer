# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in bemer.gemspec
gemspec

gem 'actionmailer', '~> 4.2.11'
gem 'railties',     '~> 4.2.11'

unless ENV['APPRAISAL']
  gem 'sprockets-rails', '~> 3.2.1'

  # Fix Loofah XSS Vulnerability. See: https://github.com/flavorjones/loofah/issues/171
  gem 'loofah', '~> 2.3.1'

  # Fix Possible Information Leak / Session Hijack Vulnerability. See: https://github.com/rack/rack/security/advisories/GHSA-hrqr-hxpp-chr3
  gem 'rack', '>= 1.6.12'

  # Fix CVE-2020-7595. See: https://github.com/sparklemotion/nokogiri/issues/1992
  gem 'nokogiri', '~> 1.10.9'
end

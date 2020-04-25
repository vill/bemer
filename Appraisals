# frozen_string_literal: true

ENV['APPRAISAL'] = 'true'

SUPPORTED_RAILS_VERSIONS           = %w[3.2.0 4.0.0 4.1.0 4.2.0 5.0.0 5.1.0 5.2.0 6.0.0].freeze
SUPPORTED_SPROCKETS_RAILS_VERSIONS = %w[2.0.0 2.1.0 2.2.0 2.3.0 3.0.0 3.1.0 3.2.0].freeze

def build_appraise(name, rails_version, sprockets_rails_version = nil)
  appraise name do
    gem 'railties',        "~> #{rails_version}"
    gem 'actionmailer',    "~> #{rails_version}"
    gem 'sprockets-rails', "~> #{sprockets_rails_version}" unless sprockets_rails_version.nil?

    next if rails_version[0].to_i > 3

    gem 'tzinfo'
    gem 'test-unit'
  end
end

SUPPORTED_RAILS_VERSIONS.each do |rails_version|
  build_appraise "rails#{rails_version[0..2]}.x", rails_version

  next if rails_version.eql?('3.2.0')

  SUPPORTED_SPROCKETS_RAILS_VERSIONS.each do |sprockets_rails_version|
    next if sprockets_rails_version[0].to_i.eql?(2) && !rails_version[0].to_i.eql?(4)

    name = "rails#{rails_version[0..2]}.x_sprockets_rails#{sprockets_rails_version[0..2]}.x"

    build_appraise name, rails_version, sprockets_rails_version
  end
end

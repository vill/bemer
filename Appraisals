# frozen_string_literal: true

ENV['APPRAISAL'] = 'true'

SUPPORTED_VERSIONS = {
  '3.2.0' => [],
  '4.0.0' => %w[2.0.0 2.1.0 2.2.0 2.3.0 3.0.0 3.1.0 3.2.0],
  '4.1.0' => %w[2.0.0 2.1.0 2.2.0 2.3.0 3.0.0 3.1.0 3.2.0],
  '4.2.0' => %w[2.0.0 2.1.0 2.2.0 2.3.0 3.0.0 3.1.0 3.2.0],
  '5.0.0' => %w[3.0.0 3.1.0 3.2.0],
  '5.1.0' => %w[3.0.0 3.1.0 3.2.0],
  '5.2.0' => %w[3.0.0 3.1.0 3.2.0 3.3.0 3.4.0],
  '6.0.0' => %w[3.0.0 3.1.0 3.2.0 3.3.0 3.4.0],
  '6.1.0' => %w[3.0.0 3.1.0 3.2.0 3.3.0 3.4.0],
  '7.0.0' => %w[3.0.0 3.1.0 3.2.0 3.3.0 3.4.0]
}

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

SUPPORTED_VERSIONS.each do |rails_version, sprockets_rails_versions|
  build_appraise "rails#{rails_version[0..2]}.x", rails_version

  sprockets_rails_versions.each do |sprockets_rails_version|
    name = "rails#{rails_version[0..2]}.x_sprockets_rails#{sprockets_rails_version[0..2]}.x"

    build_appraise name, rails_version, sprockets_rails_version
  end
end

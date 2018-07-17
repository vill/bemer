# frozen_string_literal: true

require_relative 'boot'

require 'action_controller/railtie'
require 'action_view/railtie'
# require 'action_mailer/railtie'

Bundler.require(*Rails.groups)

require 'bemer'

module Dummy
  class Application < ::Rails::Application
    config.cache_classes = true

    # Do not eager load code on boot. This avoids loading your whole application
    # just for the purpose of running a single test. If you are using a tool that
    # preloads Rails for running tests, you may have to set it to true.
    config.eager_load = false

    # Show full error reports and disable caching.
    config.consider_all_requests_local       = true
    config.action_controller.perform_caching = false

    # Raise exceptions instead of rendering exception templates.
    config.action_dispatch.show_exceptions = false

    # Disable request forgery protection in test environment.
    config.action_controller.allow_forgery_protection = false

    # Print deprecation notices to the stderr.
    config.active_support.deprecation = :stderr

    unless ENV['RAILS_ENABLE_TEST_LOG']
      config.logger    = Logger.new(nil)
      config.log_level = :fatal
    end
  end
end

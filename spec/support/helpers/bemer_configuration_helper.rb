# frozen_string_literal: true

module Helpers
  module BemerConfigurationHelper
    def reset_bemer_configuration(reload_initializer = true)
      Singleton.send(:__init__, Bemer::Configuration)

      return unless reload_initializer

      load Rails.root.join('config', 'initializers', 'bemer.rb')
    end

    def reset_bemer_configuration_and_execute(reload_initializer = true)
      return unless block_given?

      reset_bemer_configuration(reload_initializer)

      yield Bemer.config

      reset_bemer_configuration(reload_initializer)
    end
  end
end

# frozen_string_literal: true

module Bemer
  module Test
    module ConfigurationHelpers
      def reset_bemer_configuration(initializer_name = :bemer)
        Singleton.send(:__init__, Bemer::Configuration)

        return unless initializer_name

        begin
          load Rails.root.join('config', 'initializers', "#{initializer_name}.rb")
        rescue LoadError # rubocop:disable Lint/HandleExceptions
        end
      end

      def reset_bemer_configuration_and_execute(initializer_name = :bemer)
        return unless block_given?

        reset_bemer_configuration(initializer_name)

        yield Bemer.config

        reset_bemer_configuration(initializer_name)
      end
    end
  end
end

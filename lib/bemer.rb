# frozen_string_literal: true

require 'forwardable'
require 'active_support/dependencies/autoload'
require 'active_support/core_ext/object/blank'

module Bemer
  extend ActiveSupport::Autoload

  autoload :Component
  autoload :Configuration
  autoload :Helpers

  class << self
    extend Forwardable

    # rubocop:disable Layout/AlignParameters
    def_delegators :config, :bem,
                            :default_block_tag,
                            :default_context,
                            :default_element_tag,
                            :element_name_separator,
                            :modifier_name_separator,
                            :modifier_value_separator,
                            :path,
                            :transform_string_values
    # rubocop:enable Layout/AlignParameters

    def config
      Configuration.instance
    end

    def setup
      yield config
    end

    def eager_load!
      super

      Bemer::Tags.eager_load!
      Bemer::Builders.eager_load!
    end
  end
end

require 'bemer/version'
require 'bemer/railtie' if defined?(::Rails::Railtie)

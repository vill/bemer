# frozen_string_literal: true

require 'forwardable'
require 'active_support/dependencies/autoload'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/inflections'

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

    def can_use_new_matcher?
      @can_use_new_matcher ||= RUBY_VERSION >= '2.4.0'
    end

    def can_use_dig?
      @can_use_new_matcher ||= RUBY_VERSION >= '2.3.0'
    end

    def eager_load!
      super

      Bemer::Tags.eager_load!
      Bemer::Builders.eager_load!
    end

    def bem_class(block_name, element_name = nil, modifier = nil)
      modifier_name, modifier_value = *[*modifier, true].flatten
      modifier_css_class            = modifier_css_class(block_name, element_name,
                                                         modifier_name, modifier_value)

      modifier_css_class.blank? ? entity_css_class(block_name, element_name) : modifier_css_class
    end

    def modifier_css_class(block_name, element_name, modifier_name, modifier_value = true)
      entity_css_class = entity_css_class(block_name, element_name)
      modifier_name    = nil if modifier_value.blank?

      return '' if entity_css_class.blank? || modifier_name.blank?

      modifier_value = nil if modifier_value.instance_of?(TrueClass)
      modifier       = css_class(modifier_name, modifier_value,
                                 separator: modifier_value_separator)

      [entity_css_class, modifier].join(modifier_name_separator)
    end

    def entity_css_class(block_name, element_name = nil)
      return '' if block_name.blank?

      [css_class(block_name), css_class(element_name)].reject(&:blank?)
                                                      .join(element_name_separator)
    end

    def css_class(*parts, separator: '-')
      parts.flatten.reject(&:blank?).map do |part|
        part_without_whitespace = part.to_s.tr(' ', '')

        next part_without_whitespace if !transform_string_values && part.instance_of?(String)

        part_without_whitespace.underscore.dasherize
      end.join(separator)
    end
  end
end

require 'bemer/version'
require 'bemer/railtie' if defined?(::Rails::Railtie)

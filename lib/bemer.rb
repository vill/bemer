# frozen_string_literal: true

require 'forwardable'
require 'active_support/dependencies/autoload'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/inflections'

module Bemer
  extend ActiveSupport::Autoload

  autoload :Component
  autoload :Configuration
  autoload :Context
  autoload :Entity
  autoload :EntityBuilder
  autoload :Helpers
  autoload :MixinList
  autoload :ModifierList
  autoload :Pipeline
  autoload :Renderer
  autoload :Tag
  autoload :Template
  autoload :Tree

  autoload_under 'context_extentions' do
    autoload :Structure
  end

  autoload_under 'pipeline' do
    autoload :Handler
  end

  autoload_under 'tree' do
    autoload :Node
    autoload :TextNode
  end

  class << self
    extend Forwardable

    # rubocop:disable Layout/AlignParameters
    def_delegators :config, :bem,
                            :can_use_dig?,
                            :can_use_new_matcher?,
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

      Bemer::Builders.eager_load!
    end

    def bem_class(block, element = nil, modifier = nil)
      modifier_name, modifier_value = *[*modifier, true].flatten
      modifier_css_class            = modifier_css_class(block, element,
                                                         modifier_name, modifier_value)

      modifier_css_class.blank? ? entity_css_class(block, element) : modifier_css_class
    end

    def modifier_css_class(block, element, modifier_name, modifier_value = true)
      entity_css_class = entity_css_class(block, element)
      modifier_name    = nil if modifier_value.blank?

      return '' if entity_css_class.blank? || modifier_name.blank?

      modifier_value = nil if modifier_value.instance_of?(TrueClass)
      modifier       = compound_css_class(modifier_name, modifier_value,
                                          separator: modifier_value_separator)

      [entity_css_class, modifier].join(modifier_name_separator)
    end

    def entity_css_class(block, element = nil)
      return '' if block.blank?

      [css_class(block), css_class(element)].reject(&:blank?).join(element_name_separator)
    end

    def entity_name(block, element = nil)
      names = [block]

      names << element unless element.nil?

      names.map { |name| css_class(name) }.join(element_name_separator)
    end

    def compound_css_class(*parts, separator: '-')
      parts.flatten.reject(&:blank?).map { |part| css_class(part) }.join(separator)
    end

    def css_class(name)
      name_without_whitespace = name.to_s.delete(' ')

      return name_without_whitespace if !transform_string_values && name.instance_of?(String)

      name_without_whitespace.underscore.dasherize
    end
  end
end

require 'bemer/version'
require 'bemer/railtie' if defined?(::Rails::Railtie)

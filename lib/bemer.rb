# frozen_string_literal: true

require 'forwardable'
require 'active_support'
require 'active_support/dependencies/autoload'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/inflections'

module Bemer
  extend ActiveSupport::Autoload

  autoload :Builders
  autoload :Component
  autoload :ComponentPack
  autoload :Configuration
  autoload :Context
  autoload :ContextExtentions
  autoload :DefaultTemplateList
  autoload :Entity
  autoload :EntityBuilder
  autoload :MixinList
  autoload :ModifierList
  autoload :Pipeline
  autoload :Predicate
  autoload :Renderer
  autoload :Tag
  autoload :Template
  autoload :TemplateList
  autoload :Tree

  eager_autoload do
    autoload :Helpers
    autoload :TemplateCatalog
  end

  class << self
    extend Forwardable

    attr_accessor :loose_app_assets

    # rubocop:disable Layout/AlignParameters
    def_delegators :config, :bem,
                            :can_use_dig?,
                            :can_use_new_matcher?,
                            :default_block_tag,
                            :default_element_tag,
                            :default_path_prefix,
                            :element_name_separator,
                            :modifier_name_separator,
                            :modifier_value_separator,
                            :path,
                            :precompile,
                            :prepend_assets_path,
                            :transform_string_values
    # rubocop:enable Layout/AlignParameters

    alias prepend_assets_path? prepend_assets_path

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

    def modifier_css_class(block, element, modifier_name, modifier_value = true)
      bem_class     = bem_class(block, element)
      modifier_name = nil if modifier_value.blank?

      return '' if bem_class.blank? || modifier_name.blank?

      modifier_value = nil if modifier_value.instance_of?(TrueClass)
      modifier       = compound_css_class(modifier_name, modifier_value,
                                          separator: modifier_value_separator)

      [bem_class, modifier].join(modifier_name_separator)
    end

    def bem_class(block, element = nil)
      return '' if block.blank? || (!element.nil? && element.blank?)

      entity_name(block, element)
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

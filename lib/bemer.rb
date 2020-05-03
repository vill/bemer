# frozen_string_literal: true

require 'forwardable'
require 'active_support'
require 'active_support/dependencies/autoload'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/inflections'

module Bemer
  extend ActiveSupport::Autoload

  autoload :AssetMatcher
  autoload :Builders
  autoload :CommonTemplate
  autoload :Component
  autoload :ComponentPack
  autoload :Configuration
  autoload :Context
  autoload :ContextExtentions
  autoload :DefaultTemplateList
  autoload :Entity
  autoload :EntityBuilder
  autoload :MixinList
  autoload :Mixes
  autoload :ModifierList
  autoload :PathResolver
  autoload :Pipeline
  autoload :Predicate
  autoload :Renderer
  autoload :Tag
  autoload :TagBuilder
  autoload :Template
  autoload :TemplateList
  autoload :Tree

  module Test
    autoload :ConfigurationHelpers, 'bemer/test/configuration_helpers'
  end

  eager_autoload do
    autoload :Helpers
    autoload :TemplateCatalog
  end

  class << self
    extend Forwardable

    # rubocop:disable Layout/AlignArguments
    def_delegators :config, :asset_paths,
                            :bem,
                            :can_use_new_matcher?,
                            :default_block_tag,
                            :default_element_tag,
                            :default_path_prefix,
                            :element_name_separator,
                            :modifier_name_separator,
                            :modifier_value_separator,
                            :path,
                            :paths,
                            :prepend_asset_paths
    # rubocop:enable Layout/AlignArguments

    alias prepend_asset_paths? prepend_asset_paths

    def config
      Bemer::Configuration.instance
    end

    def setup
      yield config
    end

    def eager_load!
      super

      Bemer::Builders.eager_load!
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

    def css_class(name)
      name_without_whitespace = name.to_s.delete(' ')

      return name_without_whitespace if name.instance_of?(String)

      name_without_whitespace.dasherize
    end
  end
end

require 'bemer/version'
require 'bemer/railtie' if defined?(::Rails::Railtie)

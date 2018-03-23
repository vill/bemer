# frozen_string_literal: true

require 'singleton'

module Bemer
  class Configuration
    include Singleton

    attr_accessor :bem, :default_block_tag, :default_element_tag, :default_path_prefix,
                  :element_name_separator, :modifier_name_separator, :modifier_value_separator,
                  :precompile, :prepend_assets_path
    attr_reader   :can_use_new_matcher
    attr_writer   :path

    alias can_use_new_matcher? can_use_new_matcher

    def initialize # rubocop:disable Metrics/MethodLength
      @bem                      = false
      @can_use_new_matcher      = RUBY_VERSION >= '2.4.0'
      @default_block_tag        = :div
      @default_element_tag      = :div
      @default_path_prefix      = nil
      @element_name_separator   = '__'
      @modifier_name_separator  = '_'
      @modifier_value_separator = '_'
      @path                     = 'app/bemer_components'
      @prepend_assets_path      = true
    end

    def path
      Rails.root.join(@path)
    end
  end
end

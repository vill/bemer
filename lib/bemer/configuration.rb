# frozen_string_literal: true

require 'singleton'
require 'rails'

module Bemer
  class Configuration
    include Singleton

    attr_accessor :bem, :default_block_tag, :default_element_tag, :default_path_prefix,
                  :element_name_separator, :modifier_name_separator, :modifier_value_separator,
                  :prepend_asset_paths, :paths, :asset_paths
    attr_reader   :can_use_new_matcher
    attr_writer   :path

    alias can_use_new_matcher? can_use_new_matcher

    def initialize # rubocop:disable Metrics/MethodLength
      @asset_paths              = []
      @bem                      = false
      @can_use_new_matcher      = RUBY_VERSION >= '2.4.0'
      @default_block_tag        = :div
      @default_element_tag      = :div
      @default_path_prefix      = nil
      @element_name_separator   = '__'
      @modifier_name_separator  = '_'
      @modifier_value_separator = '_'
      @path                     = 'app/bemer_components'
      @paths                    = []
      @prepend_asset_paths      = true
    end

    def path
      Rails.root ? Rails.root.join(@path) : @path
    end
  end
end

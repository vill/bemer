# frozen_string_literal: true

require 'singleton'

module Bemer
  class Configuration
    include Singleton

    attr_accessor :bem, :default_block_tag, :default_element_tag,
                  :default_path_prefix, :element_name_separator, :modifier_name_separator,
                  :modifier_value_separator, :transform_string_values
    attr_reader   :can_use_dig, :can_use_new_matcher
    attr_writer   :path

    alias can_use_dig? can_use_dig
    alias can_use_new_matcher? can_use_new_matcher

    def initialize # rubocop:disable Metrics/MethodLength
      @bem                      = false
      @can_use_dig              = RUBY_VERSION >= '2.3.0'
      @can_use_new_matcher      = RUBY_VERSION >= '2.4.0'
      @default_block_tag        = :div
      @default_element_tag      = :div
      @default_path_prefix      = nil
      @element_name_separator   = element_file_separator
      @modifier_name_separator  = modifier_file_separator
      @modifier_value_separator = modifier_value_file_separator
      @path                     = 'app/bem_components'
      @transform_string_values  = false
    end

    def element_file_separator
      '__'
    end

    def modifier_file_separator
      '_'
    end

    def modifier_value_file_separator
      modifier_file_separator
    end

    def path
      Rails.root.join(@path)
    end
  end
end

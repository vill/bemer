# frozen_string_literal: true

require 'singleton'

module Bemer
  class Configuration
    include Singleton

    attr_writer :path

    attr_accessor :bem, :default_block_tag, :default_element_tag,
                  :default_context, :element_separator, :modifier_name_separator,
                  :modifier_value_separator, :transform_string_values

    def initialize
      @bem                      = true
      @default_block_tag        = :div
      @default_context          = nil
      @default_element_tag      = :div
      @element_separator        = element_file_separator
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

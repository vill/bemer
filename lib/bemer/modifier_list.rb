# frozen_string_literal: true

require 'active_support/core_ext/object/blank'

module Bemer
  class ModifierList
    def initialize(block, element, mods)
      @block     = block
      @element   = element
      @modifiers = build_modifiers(mods)
    end

    def to_a
      modifiers
    end

    def to_s
      @css_classes ||= modifiers.join(' ')
    end

    protected

    attr_reader :block, :element, :modifiers

    def build_modifiers(mods)
      return [] if mods.blank?

      Array(mods).flat_map { |attrs| build_modifier(attrs) }.reject(&:blank?).uniq
    end

    def build_modifier(mods)
      return mods.flat_map { |attrs| build_modifier(attrs) } if mods.instance_of?(Hash)

      name, values = *mods, true

      Array(values).map { |value| Bemer.modifier_css_class(block, element, name, value) }
    end
  end
end

# frozen_string_literal: true

require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/hash/indifferent_access'

module Bemer
  class ModifierList
    def initialize(block, element, mods)
      @bem_class = Bemer.bem_class(block, element)
      @modifiers = nil
      @mods      = mods
    end

    def to_a
      @to_a ||= to_h.map { |name, value| build_css_class(name, value) }
    end

    def to_s
      @to_s ||= to_a.join(' ')
    end

    def to_h
      modifiers.nil? ? build_modifiers : modifiers
    end

    protected

    attr_reader :modifiers

    def build_modifiers
      @modifiers = ActiveSupport::HashWithIndifferentAccess.new

      return modifiers if @mods.blank? || @bem_class.blank?

      Array(@mods).each do |mods|
        next if mods.blank?

        mods.is_a?(Hash) ? mods.each { |attrs| add_modifier(attrs) } : add_modifier(mods)
      end

      modifiers
    end

    def add_modifier(attrs)
      name, value = normalize(attrs)

      return if name.blank? || value.blank?

      modifiers[name] = value
    end

    def normalize(attrs)
      name, value = *attrs, true

      value = Bemer.css_class(value) unless [TrueClass, FalseClass, NilClass].include?(value.class)

      [Bemer.css_class(name), value]
    end

    def build_css_class(name, value)
      # rubocop:disable Metrics/LineLength
      modifier = value.instance_of?(TrueClass) ? name : [name, value].join(Bemer.modifier_value_separator)
      # rubocop:enable Metrics/LineLength

      [@bem_class, modifier].join(Bemer.modifier_name_separator)
    end
  end
end

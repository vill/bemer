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
      @mods_as_array ||= begin
        to_h.flat_map do |name, value|
          Array(value).map { |val| build_css_class(name, val) }
        end
      end
    end

    def to_s
      @mods_as_string ||= to_a.join(' ')
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
      name, value = normalize(*attrs)

      return if name.blank? || value.blank?

      modifiers[name] = modifiers.key?(name) ? [*modifiers[name], *value].uniq : value
    end

    def normalize(name, value = true)
      value = case value
              when String, Symbol
                Bemer.css_class(value)
              when Array
                return normalize(name, *value) if value.length.eql?(1)

                value.map { |val| Bemer.css_class(val) }
              else
                value
              end

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

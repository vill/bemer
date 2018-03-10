# frozen_string_literal: true

module Bemer
  class Predicate
    def initialize(**options)
      @block     = options[:block]
      @condition = options[:condition].nil? ? true : options[:condition]
      @element   = options[:elem]
      @mask      = build_mask(options[:block], options[:elem])
      @mixins    = MixinList.new(options[:mix])
      @modifiers = ModifierList.new(:block, :elem, options[:mods])
      @wildcard  = nil
    end

    def match?(template, node)
      condition?(template, node) && mix?(node.mix) && mods?(node.mods)
    end

    def name_match?(name)
      Bemer.can_use_new_matcher? ? mask.match?(name) : mask =~ name
    end

    def wildcard?
      return wildcard unless wildcard.nil?

      @wildcard = name.include?('*')
    end

    protected

    attr_reader :block, :element, :condition, :mask, :mixins, :name, :wildcard

    def condition?(template, node)
      return condition unless condition.respond_to?(:call)

      condition.call Context.new(template, node)
    end

    def mix?(mix)
      (mixins.to_a - mix).empty?
    end

    def mods?(mods)
      return false if modifiers.keys.length > mods.keys.length

      modifiers.all? do |name, value|
        val = mods[name]

        val.nil? ? false : (Array(value) - Array(val)).empty?
      end
    end

    def modifiers
      @modifiers.to_h
    end

    def build_mask(block, element)
      @name = Bemer.entity_name(block, element)

      return /^((?!#{Bemer.element_name_separator}).)*$/ if name.eql?('*')

      pattern = name.delete('*')
      mask    = name.sub(pattern, "(#{pattern})").gsub('*', '.*')

      /^#{mask}$/
    end
  end
end

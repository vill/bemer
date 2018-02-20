# frozen_string_literal: true

module Bemer
  class Predicate # rubocop:disable Style/Documentation
    attr_reader :name

    def initialize(**options)
      @block     = options[:block]
      @element   = options[:elem]
      @condition = options[:condition].nil? ? true : options[:condition]
      @mixins    = MixinList.new(options[:mix]).to_a
      @modifiers = options[:mods]
      @name      = Bemer.entity_name(block, element)
      @mask      = build_mask
    end

    def match?(context)
      condition?(context) && mix?(context) && mods?(context)
    end

    def name_match?(name)
      Bemer.can_use_new_matcher? ? mask.match?(name) : mask =~ name
    end

    protected

    attr_reader :block, :element, :condition, :mask, :mixins, :modifiers

    def condition?(context)
      return condition unless condition.respond_to?(:call)

      condition.call(context)
    end

    def mix?(context)
      (mixins - context.mix).empty?
    end

    def mods?(context)
      (ModifierList.new(context.block, context.elem, modifiers).to_a - context.mods).empty?
    end

    def build_mask
      return /^((?!#{Bemer.element_name_separator}).)*$/ if name.eql?('*')

      pattern = name.delete('*')
      mask    = name.sub(pattern, "(#{pattern})").gsub('*', '.*')

      /^#{mask}$/
    end
  end
end

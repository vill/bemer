# frozen_string_literal: true

require 'active_support/core_ext/object/blank'

module Bemer
  class Entity
    attr_accessor :bem_cascade
    attr_reader   :attrs, :bem, :bem_class, :block, :content, :elem, :js, :name

    alias element elem

    def initialize(block = '', element = nil, **options, &content)
      @bem_class = Bemer.bem_class(block, element)
      @block     = block
      @content   = extract_content(options.delete(:content), &content)
      @elem      = element
      @name      = Bemer.entity_name(block, element)

      extract_options!(options)
    end

    def block?
      !element?
    end

    def cls
      @cls ||= build_css_classes(css_classes)
    end

    def elem?
      !elem.nil?
    end

    alias element? elem?

    def mix
      @mix ||= mixins.to_a
    end

    def mods
      @mods ||= modifiers.to_h
    end

    def tag
      @tag ||= build_tag(html_tag)
    end

    protected

    attr_reader :css_classes, :html_tag, :mixins, :modifiers

    def extract_content(plain_text, &content)
      block_given? ? content : plain_text
    end

    def extract_options!(options)
      @bem         = options.delete(:bem)
      @bem_cascade = options.delete(:bem_cascade)
      @css_classes = [options.delete(:class), options.delete(:cls)]
      @html_tag    = options.delete(:tag)
      @js          = options.delete(:js)
      @mixins      = MixinList.new(options.delete(:mix))
      @modifiers   = ModifierList.new(block, element, options.delete(:mods))
      @attrs       = options
    end

    def build_css_classes(*classes)
      classes.flatten.map do |css_class|
        next [] if css_class.blank?

        css_class.instance_of?(String) ? css_class.split : Bemer.css_class(css_class)
      end.flatten.uniq
    end

    def build_tag(new_tag)
      new_tag.instance_of?(String) ? new_tag.to_sym : new_tag
    end
  end
end

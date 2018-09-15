# frozen_string_literal: true

require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/hash/keys'

module Bemer
  class Entity
    attr_accessor :bem_cascade
    attr_reader   :bem, :bem_class, :block, :content, :elem, :js, :name, :tag

    alias element elem

    def initialize(block = '', element = nil, **options, &content)
      @bem_class = Bemer.bem_class(block, element)
      @block     = block
      @content   = extract_content(options.delete(:content), &content)
      @elem      = element
      @name      = Bemer.entity_name(block, element)

      extract_options!(options)
    end

    def attrs
      @attrs ||= build_attrs(html_attrs)
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

    protected

    attr_reader :css_classes, :html_attrs, :mixins, :modifiers

    def extract_content(plain_content, &block)
      block_given? ? block : plain_content.to_s
    end

    def extract_options!(options) # rubocop:disable Metrics/AbcSize
      @bem         = options.delete(:bem)
      @bem_cascade = options.delete(:bem_cascade)
      @css_classes = [options.delete(:class), options.delete(:cls)]
      @js          = options.delete(:js)
      @mixins      = MixinList.new(options.delete(:mix))
      @modifiers   = ModifierList.new(block, element, options.delete(:mods))
      @tag         = build_tag(options.delete(:tag))
      @html_attrs  = options
    end

    def build_css_classes(*classes)
      classes.map do |css_class|
        next [] if css_class.blank?

        case css_class
        when String then css_class.split
        when Array  then css_class.map { |css_cls| build_css_classes(css_cls) }
        else Bemer.css_class(css_class)
        end
      end.flatten.uniq
    end

    def build_tag(new_tag)
      return new_tag if new_tag.nil? || new_tag.instance_of?(Symbol)

      new_tag.blank? ? '' : new_tag.to_sym
    end

    def build_attrs(new_attrs)
      case new_attrs
      when Array then new_attrs.to_h.symbolize_keys
      when Hash  then new_attrs.symbolize_keys
      else {}
      end
    end
  end
end

# frozen_string_literal: true

require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/inflections'

module Bemer
  class Entity # rubocop:disable Style/Documentation
    attr_accessor :attrs, :bem, :bem_cascade, :block, :content, :elem, :js, :tag
    attr_reader   :bem_class, :cls, :mix, :mods, :name

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

    def elem?
      !elem.nil?
    end

    alias element? elem?

    def mods=(new_mods)
      @mods = ModifierList.new(block, element, new_mods).to_a
    end

    def mix=(new_mix)
      @mix = MixinList.new(new_mix).to_a
    end

    def cls=(classes)
      @cls = build_css_classes(classes)
    end

    protected

    def extract_content(plain_text, &content)
      block_given? ? content : plain_text
    end

    def extract_options!(options) # rubocop:disable Metrics/AbcSize
      @bem         = options.delete(:bem)
      @bem_cascade = options.delete(:bem_cascade)
      @cls         = build_css_classes(options.delete(:class), options.delete(:cls))
      @js          = options.delete(:js)
      @mix         = MixinList.new(options.delete(:mix)).to_a
      @mods        = ModifierList.new(block, element, options.delete(:mods)).to_a
      @tag         = options.delete(:tag)
      @attrs       = options
    end

    def build_css_classes(*classes)
      classes.flatten.map do |css_class|
        next [] if css_class.blank?

        css_class.instance_of?(String) ? css_class.split : css_class.to_s.underscore.dasherize
      end.flatten
    end
  end
end

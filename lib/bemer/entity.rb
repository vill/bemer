# frozen_string_literal: true

require 'active_support/core_ext/object/blank'

module Bemer
  class Entity # rubocop:disable Style/Documentation
    METHOD_NAMES = %i[attrs bem bem_cascade bem_class block
                      cls content elem js mix mods name tag].freeze

    attr_reader(*METHOD_NAMES)

    alias element elem

    def initialize(block = '', element = nil, **options, &content)
      @bem_class = Bemer.entity_css_class(block, element)
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

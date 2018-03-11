# frozen_string_literal: true

require 'active_support/core_ext/object/blank'

module Bemer
  class EntityBuilder < Entity
    attr_writer :attrs, :bem, :content, :js

    def attrs
      bem? ? { **super, **js } : super
    end

    def add_attrs=(new_attrs)
      @attrs.merge!(new_attrs)
    end

    def bem
      bem_via_option? ? super : true
    end

    def bem?
      bem_enabled_via_option? || bem_cascade_enabled_via_option? || bem_enabled_fully?
    end

    def bem_cascade
      bem_cascade_via_option? ? super : true
    end

    def cls
      return super unless bem?

      js_class = 'i-bem' if @js.present?

      [bem_class, mods, mix, super, js_class].reject(&:blank?)
    end

    def cls=(new_cls)
      @cls = build_css_classes(*new_cls)
    end

    def js
      return {} if @js.blank?

      attrs = @js.instance_of?(TrueClass) ? {} : super

      { data: { bem: { name => attrs } } }
    end

    def add_js=(new_js)
      return @js.merge!(new_js) if @js.instance_of?(Hash)

      @js = new_js
    end

    def add_mix=(new_mix)
      @mix = MixinList.new(*mix, *new_mix).to_a
    end

    def mix=(new_mix)
      @mix = MixinList.new(*new_mix).to_a
    end

    def mods
      modifiers.to_a
    end

    def add_mods=(new_mods)
      @modifiers = ModifierList.new(block, element, [modifiers.to_h, *new_mods])

      modifiers.to_h
    end

    def mods=(new_mods)
      @modifiers = ModifierList.new(block, element, new_mods)

      modifiers.to_h
    end

    def tag
      super.nil? ? default_tag : @tag
    end

    def tag=(new_tag)
      @tag = build_tag(new_tag)
    end

    protected

    def bem_via_option?
      !@bem.nil?
    end

    def bem_cascade_via_option?
      !@bem_cascade.nil?
    end

    def bem_enabled_via_option?
      bem_via_option? && bem
    end

    def bem_cascade_enabled_via_option?
      bem_cascade_via_option? && bem_cascade && bem
    end

    def bem_enabled_fully?
      Bemer.bem && bem_cascade && bem
    end

    def default_tag
      block? ? Bemer.default_block_tag : Bemer.default_element_tag
    end
  end
end

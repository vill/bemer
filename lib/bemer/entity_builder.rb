# frozen_string_literal: true

require 'active_support/core_ext/object/blank'

module Bemer
  class EntityBuilder < Entity
    def attrs
      bem? ? { **super, **js } : super
    end

    def attrs=(new_attrs, save = true)
      new_attrs = build_attrs(new_attrs)

      return new_attrs unless save

      @attrs = new_attrs
    end

    def bem
      bem_via_option? ? super : true
    end

    def bem=(new_bem, save = true)
      return new_bem unless save

      @bem = new_bem
    end

    def bem?
      bem_enabled_via_option? || bem_cascade_enabled_via_option? || bem_enabled_fully?
    end

    def bem_cascade
      bem_cascade_via_option? ? super : true
    end

    def bem_cascade=(new_bem_cascade, save = true)
      return new_bem_cascade unless save

      @bem_cascade = new_bem_cascade
    end

    def cls
      return super unless bem?

      js_class = 'i-bem' if @js.present?

      [bem_class, mods, mix, super, js_class].reject(&:blank?)
    end

    def cls=(new_cls, save = true)
      new_cls = build_css_classes(*new_cls)

      return new_cls unless save

      @cls = new_cls
    end

    def content=(new_content, save = true)
      return new_content unless save

      @content = new_content
    end

    def js
      return {} if @js.blank?

      attrs = @js.instance_of?(TrueClass) ? {} : super

      { data: { bem: { name => attrs } } }
    end

    def js=(new_js, save = true)
      return new_js unless save

      @js = new_js
    end

    def mix=(new_mix, save = true)
      new_mix = MixinList.new(*new_mix).to_a

      return new_mix unless save

      @mix = new_mix
    end

    def mods
      modifiers.to_a
    end

    def mods=(new_mods, save = true)
      modifiers = ModifierList.new(block, element, new_mods)

      return modifiers.to_h unless save

      @modifiers = modifiers

      modifiers.to_h
    end

    def tag
      super.nil? ? default_tag : @tag
    end

    def tag=(new_tag, save = true)
      new_tag = build_tag(new_tag)

      return new_tag unless save

      @tag = new_tag
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

# frozen_string_literal: true

require 'active_support/core_ext/object/blank'

module Bemer
  class EntityBuilder < Entity # rubocop:disable Style/Documentation
    attr_accessor :content, :js, :attrs
    attr_writer   :tag, :bem, :bem_cascade

    def mods=(new_mods)
      @mods = ModifierList.new(block, element, new_mods).to_a
    end

    def add_mods=(new_mods)
      @mods.push(*ModifierList.new(block, element, new_mods).to_a)
    end

    def mix=(new_mix)
      @mix = MixinList.new(new_mix).to_a
    end

    def add_mix=(new_mix)
      @mix.push(*MixinList.new(new_mix).to_a)
    end

    def add_attrs=(new_attrs)
      @attrs = attrs.instance_of?(Hash) ? { **attrs, **new_attrs } : new_attrs
    end

    def add_js=(new_js)
      @js = js.instance_of?(Hash) ? { **js, **new_js } : new_js
    end

    def cls=(classes)
      @cls = build_css_classes(classes)
    end

    def add_cls=(classes)
      @cls.push(*build_css_classes(classes))
    end

    def js_class
      js.blank? ? '' : 'i-bem'
    end

    def js_attrs
      return {} if js.blank?

      js_attrs = { data: { bem: { name => {} } } }

      js_attrs[:data][:bem][name] = js unless js.instance_of?(TrueClass)

      js_attrs
    end

    def tag
      @tag.nil? ? default_tag : @tag
    end

    def bem?
      bem_enabled_via_option? || bem_cascade_enabled_via_option? || bem_enabled_fully?
    end

    def bem
      bem_via_option? ? @bem : true
    end

    def bem_cascade
      bem_cascade_via_option? ? @bem_cascade : true
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
      element.nil? ? Bemer.default_block_tag : Bemer.default_element_tag
    end
  end
end

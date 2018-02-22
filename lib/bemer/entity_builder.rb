# frozen_string_literal: true

require 'active_support/core_ext/object/blank'

module Bemer
  class EntityBuilder < Entity # rubocop:disable Style/Documentation
    def cls
      return @cls unless bem?

      js_class = 'i-bem' if @js.present?

      [bem_class, mix, mods, js_class, @cls].reject(&:blank?)
    end

    def attrs
      bem? ? { **@attrs, **js } : @attrs
    end

    def add_mods=(new_mods)
      @mods.push(*ModifierList.new(block, element, new_mods).to_a)
    end

    def add_mix=(new_mix)
      @mix.push(*MixinList.new(new_mix).to_a)
    end

    def add_attrs=(new_attrs)
      @attrs = @attrs.instance_of?(Hash) ? { **@attrs, **new_attrs } : new_attrs
    end

    def add_js=(new_js)
      @js = @js.instance_of?(Hash) ? { **@js, **new_js } : new_js
    end

    def add_cls=(classes)
      @cls.push(*build_css_classes(classes))
    end

    def js
      return {} if @js.blank?

      js_attrs = { data: { bem: { name => {} } } }

      js_attrs[:data][:bem][name] = @js unless @js.instance_of?(TrueClass)

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
      block? ? Bemer.default_block_tag : Bemer.default_element_tag
    end
  end
end

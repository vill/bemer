# frozen_string_literal: true

require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/filters'

module Bemer
  class EntityBuilder < Entity # rubocop:disable Metrics/ClassLength
    DATA_BEM_KEY = :'data-bem'

    def attrs
      attributes         = Hash[super]
      attributes[:class] = cls if cls.present?

      return attributes unless bem?

      data_bem = js

      data_bem[DATA_BEM_KEY] = data_bem[DATA_BEM_KEY].to_json if data_bem.key?(DATA_BEM_KEY)

      attributes.merge!(data_bem)
    end

    def attrs=(new_attrs, save = true)
      new_attrs = build_attrs(new_attrs)

      save ? @attrs = new_attrs : new_attrs
    end

    def bem
      bem_via_option? ? super : true
    end

    def bem=(new_bem, save = true)
      save ? @bem = new_bem : new_bem
    end

    def bem?
      bem_enabled_via_option? || bem_cascade_enabled_via_option? || bem_enabled_fully?
    end

    def bem_cascade
      bem_cascade_via_option? ? super : true
    end

    def cls
      return super unless bem?

      i_bem = 'i-bem' if need_data_bem? || need_mixed_data_bem?

      [bem_class, mods, mix, super, i_bem].flatten.reject(&:blank?).uniq.join(' ')
    end

    def cls=(new_cls, save = true)
      new_cls = build_css_classes(new_cls)

      save ? @cls = new_cls : new_cls
    end

    def content=(new_content, save = true)
      save ? @content = new_content : new_content
    end

    def js
      need_data_bem       = need_data_bem?
      need_mixed_data_bem = need_mixed_data_bem?

      return {} unless need_data_bem || need_mixed_data_bem

      if !need_data_bem && need_mixed_data_bem
        mixed_data_bem
      else
        js_attrs = @js.instance_of?(TrueClass) ? {} : super

        { DATA_BEM_KEY => { name => js_attrs }.merge!(mixed_data_bem[DATA_BEM_KEY]) }
      end
    end

    def js=(new_js, save = true)
      save ? @js = new_js : new_js
    end

    def mix=(new_mix, save = true)
      new_mixes = Mixes.new(new_mix)
      new_mix   = new_mixes.to_a

      if save
        @mixins = new_mixes
        @mix    = new_mix
      else
        new_mix
      end
    end

    def mods
      modifiers.to_a
    end

    def mods=(new_mods, save = true)
      modifiers  = ModifierList.new(block, element, new_mods)
      @modifiers = modifiers if save

      modifiers.to_h
    end

    def tag
      super.nil? ? default_tag : @tag
    end

    def tag=(new_tag, save = true)
      new_tag = build_tag(new_tag)

      save ? @tag = new_tag : new_tag
    end

    def need_data_bem?
      bem? && @js.present? && bem_class.present?
    end

    def need_mixed_data_bem?
      bem? && mixins.entities.any?(&:need_data_bem?)
    end

    protected

    def mixed_data_bem
      mixins.entities.each_with_object(DATA_BEM_KEY => {}) do |entity, data_bem|
        # next if entity.name.eql?(name) || !entity.need_data_bem?
        next unless entity.need_data_bem?

        data_bem[DATA_BEM_KEY][entity.name] = entity.js[DATA_BEM_KEY][entity.name]
      end
    end

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

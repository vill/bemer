# frozen_string_literal: true

module Bemer
  module Helpers
    def block_tag(name = '', **options, &content)
      Bemer::Tag.new(name, options, &content).render
    end

    def elem_tag(block = '', element = '', **options, &content)
      Bemer::Tag.new(block, element, options, &content).render
    end

    def bem_mix(*mix)
      Bemer::MixinList.new(*mix).to_s
    end

    def bem_mods(block, element, mods)
      Bemer::ModifierList.new(block, element, mods).to_s
    end

    def render_component(level_and_name, **options, &block)
      Bemer::Component.new(level_and_name, self, options).render(&block)
    end

    alias render_block render_component
  end
end

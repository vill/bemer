# frozen_string_literal: true

module Bemer
  module Helpers
    def block_tag(name = '', **options, &content)
      Bemer::Tag.new(name, **options, &content).render
    end

    def elem_tag(block = '', element = '', **options, &content)
      Bemer::Tag.new(block, element, **options, &content).render
    end

    def bem_mix(*mix)
      Bemer::Mixes.new(mix).to_s
    end

    def bem_mods(*block_and_element, mods)
      block, element = *block_and_element

      Bemer::ModifierList.new(block, element, mods).to_s
    end

    def render_component(path, **options, &block)
      Bemer::TemplateList.new(self, path, **options).compile(&block)
    end

    alias refine_component render_component

    def define_templates(cached: true, &block)
      Bemer::DefaultTemplateList.new(self, cached).compile(&block)
    end

    def define_component(**options, &block)
      Bemer::Component.new(self).render(**options, &block)
    end

    def component_pack(&block)
      Bemer::ComponentPack.new(self).render(&block)
    end

    def component_asset_path(name)
      Bemer::PathResolver.new(self).resolve(name)
    end

    def component_partial_path(name)
      Bemer::PathResolver.new(self).resolve(name, true)
    end

    def bem_attrs_for(block = '', element = nil, **options)
      js = options[:js].nil? ? true : options.delete(:js)

      Bemer::EntityBuilder.new(block, element, **options.merge(bem: true, js: js)).attrs
    end
  end
end

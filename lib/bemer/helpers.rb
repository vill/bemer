# frozen_string_literal: true

module Bemer
  module Helpers
    def block(name = nil, content: nil, **options, &block)
      name ||= File.basename(@virtual_path).to_s[/[^_]\S+/]

      Bemer::Builders::Block.new(name, self, options).render(content, &block)
    end

    def render_component(name, context = nil, **options, &block)
      Bemer::Component.new(name, self, context, options).render(&block)
    end

    alias render_block render_component
  end
end

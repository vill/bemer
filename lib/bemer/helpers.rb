# frozen_string_literal: true

module Bemer
  module Helpers
    def block(name = nil, content: nil, **options, &block)
      name ||= File.basename(@virtual_path).to_s[/[^_]\S+/]

      Bemer::Builders::Block.new(name, self, options).render(content, &block)
    end

    def render_component(level_and_name, **options, &block)
      Bemer::Component.new(level_and_name, self, options).render(&block)
    end

    alias render_block render_component
  end
end

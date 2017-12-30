# frozen_string_literal: true

module Bemer
  module Builders
    class Block < Base
      def render(content = nil, &block)
        Tags::Block.new(name, template, self, options).render(content, &block)
      end

      def element(name, content: nil, **options, &block)
        Builders::Element.new(name, template, self, options).render(content, &block)
      end
    end
  end
end

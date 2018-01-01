# frozen_string_literal: true

module Bemer
  module Builders
    class Element < Base
      attr_reader :block

      def initialize(name, view, block, **options)
        super(name, view, options)

        @block = block
      end

      def render(content = nil, &callback)
        Tags::Element.new(block.name, name, view, self, options).render(content, &callback)
      end
    end
  end
end

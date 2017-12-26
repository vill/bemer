# frozen_string_literal: true

module Bemer
  module Builders
    class Element < Base
      attr_reader :block

      def initialize(name, template, block, **options)
        super(name, template, options)

        @block = block
      end

      def render(&callback)
        Tags::Element.new(block.name, name, template, self, options).render(&callback)
      end
    end
  end
end

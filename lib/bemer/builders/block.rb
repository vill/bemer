# frozen_string_literal: true

module Bemer
  module Builders
    class Block < Base
      def render(&block)
        Tags::Block.new(name, template, self, options).render(&block)
      end

      def element(name, **options, &block)
        Builders::Element.new(name, template, self, options).render(&block)
      end
    end
  end
end

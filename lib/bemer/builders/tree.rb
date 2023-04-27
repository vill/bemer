# frozen_string_literal: true

module Bemer
  module Builders
    class Tree
      def initialize(tree)
        @tree = tree
      end

      def block(name = '', **options, &content)
        tree.add_node(name, **options, &content)
      end

      def elem(block = '', name = '', **options, &content)
        tree.add_node(block, name, **options, &content)
      end

      def text(content = nil, &callback)
        tree.add_text_node(content, &callback)
      end

      protected

      attr_reader :tree
    end
  end
end

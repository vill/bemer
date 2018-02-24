# frozen_string_literal: true

module Bemer
  module Builders
    class Tree # rubocop:disable Style/Documentation
      def initialize(tree)
        @tree = tree
      end

      def block(name = '', **options, &content)
        tree.add_node(name, options, &content)
      end

      def elem(block = '', name = '', **options, &content)
        tree.add_node(block, name, options, &content)
      end

      def text(content = nil, **options, &callback)
        tree.add_text_node(content, **options, &callback)
      end

      protected

      attr_reader :tree
    end
  end
end

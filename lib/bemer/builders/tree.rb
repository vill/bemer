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

      protected

      attr_reader :tree
    end
  end
end

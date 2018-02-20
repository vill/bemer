# frozen_string_literal: true

module Bemer
  module Builders
    class NodeReplacer # rubocop:disable Style/Documentation
      def initialize(node)
        @node = node
      end

      def block(name = '', **options, &content)
        node.replace_with(name, options, &content)
      end

      def elem(block = '', name = '', **options, &content)
        node.replace_with(block, name, options, &content)
      end

      protected

      attr_reader :node
    end
  end
end

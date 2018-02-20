# frozen_string_literal: true

module Bemer
  module Builders
    class NodeReplacerElement # rubocop:disable Style/Documentation
      def initialize(node)
        @node = node
      end

      def elem(name = '', **options, &content)
        node.replace_with(node.block, name, options, &content)
      end

      protected

      attr_reader :node
    end
  end
end

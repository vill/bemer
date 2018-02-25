# frozen_string_literal: true

module Bemer
  module Builders
    class Tree
      class Element # rubocop:disable Style/Documentation
        def initialize(tree, block)
          @tree  = tree
          @block = block
        end

        def elem(name = '', **options, &content)
          tree.add_node(block, name, options, &content)
        end

        protected

        attr_reader :tree, :block
      end
    end
  end
end

# frozen_string_literal: true

module Bemer
  module ContextExtentions
    module Structure
      def content(**options)
        node.child_params = options

        node.add_child_nodes
      end

      def ctx(**options)
        duplicate = node.dup

        duplicate.params.merge!(options)

        bem_cascade                          = node.tree.parent_node.bem_cascade
        duplicate.entity.bem_cascade         = bem_cascade
        duplicate.entity_builder.bem_cascade = bem_cascade

        node.tree.add(duplicate)

        nil
      end
    end
  end
end

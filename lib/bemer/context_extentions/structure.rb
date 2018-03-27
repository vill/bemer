# frozen_string_literal: true

module Bemer
  module ContextExtentions
    module Structure
      def content(**options)
        old_params = Hash[node.params]

        node.params.merge!(options)

        output      = node.add_child_nodes
        node.params = old_params

        output
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

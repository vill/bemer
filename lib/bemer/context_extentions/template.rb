# frozen_string_literal: true

module Bemer
  module ContextExtentions
    module Template
      def apply_next(**options)
        node.apply_next(template, options)
      end

      def apply(mode, **options)
        node.apply(mode, template, options)
      end
    end
  end
end

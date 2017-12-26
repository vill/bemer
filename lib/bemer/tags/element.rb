# frozen_string_literal: true

module Bemer
  module Tags
    class Element < Base
      attr_reader :element_name

      def initialize(block_name, element_name, template, builder, **options)
        options = options.merge(bem_recursive: builder.block.options[:bem_recursive])

        super(block_name, template, builder, options)

        @element_name = element_name
      end

      def bem_class
        bem_class_for(block_name, element: element_name)
      end

      def default_tag
        Bemer.default_element_tag
      end
    end
  end
end

# frozen_string_literal: true

require 'active_support/dependencies/autoload'

module Bemer
  module Builders
    class Tree
      extend ActiveSupport::Autoload

      eager_autoload do
        autoload :Element
      end

      def initialize(tree)
        @tree = tree
      end

      def block(name = '', **options, &content)
        tree.add_node(name, options, &content)
      end

      def elem(block = '', name = '', **options, &content)
        tree.add_node(block, name, options, &content)
      end

      def text(content = nil, bem_cascade: nil, &callback)
        tree.add_text_node(content, bem_cascade: bem_cascade, &callback)
      end

      protected

      attr_reader :tree
    end
  end
end

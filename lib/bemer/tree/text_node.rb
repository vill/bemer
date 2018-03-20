# frozen_string_literal: true

module Bemer
  class Tree
    class TextNode < Node
      def initialize(tree, content: nil, bem_cascade: nil, &callback)
        super(tree, bem_cascade: bem_cascade, tag: false, content: content, &callback)
      end
    end
  end
end

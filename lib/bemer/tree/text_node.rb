# frozen_string_literal: true

module Bemer
  class Tree
    class TextNode < Node
      def initialize(tree, content = nil, &callback)
        super(tree, tag: false, content: content, &callback)
      end
    end
  end
end

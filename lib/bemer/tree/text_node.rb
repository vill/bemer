# frozen_string_literal: true

module Bemer
  class Tree
    class TextNode < Node
      def initialize(tree, content = nil, **options, &callback)
        super(tree, **options, tag: false, content: content, &callback)
      end
    end
  end
end

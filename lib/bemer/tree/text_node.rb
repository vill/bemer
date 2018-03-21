# frozen_string_literal: true

module Bemer
  class Tree
    class TextNode < Node
      def initialize(tree, content = nil, &callback)
        super(tree, tag: false, content: content, &callback)
      end

      protected

      def capture_content
        return content unless content.respond_to?(:call)

        content.binding.receiver.capture(&content)
      end
    end
  end
end

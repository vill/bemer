# frozen_string_literal: true

module Bemer
  module Tags
    class Block < Base
      def bem_class
        bem_class_for(block_name)
      end

      def default_tag
        Bemer.default_block_tag
      end
    end
  end
end

# frozen_string_literal: true

module Bemer
  class Tree
    class TextNode < Node # rubocop:disable Style/Documentation
      def initialize(tree, content = nil, **options, &callback)
        super(tree, **options, tag: false, content: content, &callback)

        Pipeline::MODES.each { |mode| applied_modes[mode] = true }

        @all_modes_applied = true
      end
    end
  end
end

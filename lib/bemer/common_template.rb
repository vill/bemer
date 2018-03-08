# frozen_string_literal: true

module Bemer
  class CommonTemplate
    attr_reader :mode

    def initialize(mode)
      @mode = mode
    end

    def apply!(node)
      case mode
      when Pipeline::REPLACE_MODE
        node.need_replace = true

        node.replacers << node.dup

        nil
      when Pipeline::CONTENT_MODE then node.add_child_nodes
      else
        node.public_send mode.to_s.sub('add_', '')
      end
    end
  end
end

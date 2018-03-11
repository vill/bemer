# frozen_string_literal: true

module Bemer
  class CommonTemplate
    attr_reader :mode

    def initialize(mode)
      @mode = mode.to_s.sub('add_', '').to_sym
    end

    def apply!(node)
      case mode
      when Pipeline::REPLACE_MODE then replace!(node)
      when Pipeline::CONTENT_MODE then node.add_child_nodes
      else node.public_send(mode)
      end
    end

    protected

    def replace!(node)
      node.need_replace = true

      node.replacers << node.dup

      nil
    end
  end
end

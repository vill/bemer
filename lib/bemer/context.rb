# frozen_string_literal: true

require 'forwardable'

module Bemer
  class Context
    extend Forwardable

    def_delegators :node, :attrs, :bem, :bem_cascade, :block, :cls, :elem,
                   :first?, :js, :last?, :mix, :mods, :params, :position, :tag

    def initialize(template, node)
      @node     = node
      @template = template

      include_extention!(template.mode)
    end

    def apply_next(**params)
      node.apply_next(template, params)
    end

    def apply(mode, **params)
      node.apply(mode, template, params)
    end

    protected

    def include_extention!(mode)
      return unless Pipeline::STRUCTURE_RELATED_MODES.include?(mode)

      self.class.public_send :include, ContextExtentions::Structure
    end

    attr_reader :template, :node
  end
end

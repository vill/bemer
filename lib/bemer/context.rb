# frozen_string_literal: true

require 'forwardable'

module Bemer
  class Context
    extend Forwardable

    def_delegators :node, :attrs, :bem, :bem_cascade, :block, :cls, :elem,
                   :first?, :js, :last?, :mix, :mods, :name, :params, :position, :tag

    def initialize(template, node)
      @node     = node
      @template = template
    end

    def apply_next(**params)
      node.apply_next(template, params)
    end

    def apply(mode, **params)
      node.apply(mode, template, params)
    end

    protected

    attr_reader :template, :node
  end
end

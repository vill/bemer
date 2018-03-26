# frozen_string_literal: true

require 'forwardable'

module Bemer
  class Context
    extend Forwardable

    def_delegators :node, :attrs, :bem, :bem_cascade, :block, :cls, :elem,
                   :first?, :js, :last?, :mix, :mods, :name, :position, :tag

    def initialize(node, template = nil)
      @node     = node
      @template = template
    end

    def params
      node.params
    end

    protected

    attr_reader :template, :node
  end
end

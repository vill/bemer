# frozen_string_literal: true

require 'forwardable'

module Bemer
  class Context
    extend Forwardable

    def_delegators :node, :attrs, :bem, :bem_cascade, :block, :cls, :elem,
                   :first?, :js, :last?, :mix, :mods, :name, :params, :position, :tag

    def initialize(node, template = nil)
      @node     = node
      @template = template
    end

    protected

    attr_reader :template, :node
  end
end

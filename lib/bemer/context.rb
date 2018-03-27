# frozen_string_literal: true

require 'forwardable'

module Bemer
  class Context
    extend Forwardable

    def_delegators :node, :bem, :bem_cascade, :block, :elem, :first?, :last?, :name, :position, :tag

    def initialize(node, template = nil)
      @node     = node
      @template = template
    end

    def params
      @params ||= Hash[node.params]
    end

    def attrs
      @attrs ||= Hash[node.attrs]
    end

    def cls
      @cls ||= node.cls.dup
    end

    def js
      @js ||= node.js.dup
    end

    def mix
      @mix ||= node.mix.dup
    end

    def mods
      @mods ||= ActiveSupport::HashWithIndifferentAccess[node.mods]
    end

    protected

    attr_reader :template, :node
  end
end

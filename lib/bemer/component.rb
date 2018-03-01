# frozen_string_literal: true

module Bemer
  class Component
    def initialize(view)
      @template_catalog = view.instance_variable_get(:@bemer_template_catalog)
    end

    def render(**options, &block)
      return if !block_given? || template_catalog.nil?

      Tree.new(template_catalog, options).render(&block)
    end

    protected

    attr_reader :template_catalog
  end
end

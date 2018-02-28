# frozen_string_literal: true

module Bemer
  class Component
    def initialize(view)
      # rubocop:disable Metrics/LineLength
      @template_catalog = view.instance_variable_get(:@bemer_template_catalog) || TemplateCatalog.new
      # rubocop:enable Metrics/LineLength
    end

    def render(**options, &block)
      return unless block_given?

      Tree.new(template_catalog, options).render(&block)
    end

    protected

    attr_reader :template_catalog
  end
end

# frozen_string_literal: true

module Bemer
  class DefaultTemplateList # rubocop:disable Style/Documentation
    def initialize(view)
      @path = ''
      @view = view
    end

    def compile(&block)
      template_catalog.add(path, &block)
    end

    protected

    attr_reader :path, :view

    def template_catalog
      template_catalog = view.instance_variable_get(:@bemer_template_catalog)

      return template_catalog unless template_catalog.nil?

      build_template_catalog!
    end

    def build_template_catalog!
      template_catalog = TemplateCatalog.new

      view.assign(bemer_template_catalog: template_catalog)

      template_catalog
    end
  end
end

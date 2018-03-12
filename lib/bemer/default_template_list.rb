# frozen_string_literal: true

module Bemer
  class DefaultTemplateList
    def initialize(view, cached = true)
      @path   = ''
      @view   = view
      @cached = cached
    end

    def compile(&block)
      template_catalog.add(path, cached, &block)
    end

    protected

    attr_reader :cached, :path, :view

    def template_catalog
      template_catalog = view.instance_variable_get(:@bemer_template_catalog)

      return template_catalog unless template_catalog.nil?

      build_template_catalog!
    end

    def build_template_catalog!
      template_catalog = TemplateCatalog.new(object_id)

      view.assign(bemer_template_catalog: template_catalog)

      template_catalog
    end
  end
end

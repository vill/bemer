# frozen_string_literal: true

module Bemer
  class ComponentPack
    def initialize(view, collection = [])
      @collection = collection
      @view       = view
    end

    def render
      return unless block_given? && collection.is_a?(Enumerable)

      create_template_catalog!

      collection.each { |item| yield item }

      remove_template_catalog!

      nil
    end

    protected

    attr_reader :collection, :view

    def create_template_catalog!
      return unless view.instance_variable_get(:@bemer_template_catalog).nil?

      view.assign(bemer_template_catalog: TemplateCatalog.new(object_id))
    end

    def remove_template_catalog!
      template_catalog = view.instance_variable_get(:@bemer_template_catalog)

      return if template_catalog.nil? || !template_catalog.owner.eql?(object_id)

      view.remove_instance_variable(:@bemer_template_catalog)
    end
  end
end

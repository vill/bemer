# frozen_string_literal: true

module Bemer
  class TemplateCatalog
    attr_reader :owner

    def initialize(owner)
      @drawers        = {}
      @owner          = owner
      @template_queue = []
    end

    def compiled_templates
      template_queue  = @template_queue
      @template_queue = []

      template_queue.flat_map { |id| drawers[id].compiled_templates }
    end

    def add(path, cached = false, &block)
      return unless block_given?

      id = [block.source_location, path].join(':')

      @template_queue << id

      drawers[id] = Drawer.new(cached, &block) unless drawers.key?(id) && drawers[id].cached?
    end

    protected

    attr_reader :drawers
  end
end

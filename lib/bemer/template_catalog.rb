# frozen_string_literal: true

module Bemer
  class TemplateCatalog
    def initialize
      @drawers        = {}
      @template_queue = []
    end

    def compiled_templates
      template_queue  = @template_queue
      @template_queue = []

      template_queue.flat_map { |id| drawers[id].compiled_templates }
    end

    def add(path, &block)
      return unless block_given?

      id = [block.source_location, path].join(':')

      @template_queue << id

      drawers[id] = Drawer.new(&block) unless drawers.key?(id)
    end

    protected

    attr_reader :drawers
  end
end

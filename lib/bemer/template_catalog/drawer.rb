# frozen_string_literal: true

module Bemer
  class TemplateCatalog
    class Drawer
      attr_reader :cached

      alias cached? cached

      def initialize(cached = false, &block)
        @cached    = cached
        @templates = [block]
      end

      def compiled_templates
        @compiled_templates ||= compile_templates
      end

      protected

      attr_reader :templates

      def compile_templates
        templates.flat_map do |block|
          new_templates = []
          builder       = Builders::TemplateList.new(new_templates)

          block.binding.receiver.capture(builder, &block)

          new_templates
        end
      end
    end
  end
end
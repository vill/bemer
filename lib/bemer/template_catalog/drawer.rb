# frozen_string_literal: true

module Bemer
  class TemplateCatalog
    class Drawer
      attr_reader :cached

      alias cached? cached

      def initialize(cached = false, &block)
        @block  = block
        @cached = cached
      end

      def compiled_templates
        @compiled_templates ||= begin
          new_templates = []
          builder       = Builders::TemplateList.new(new_templates)

          block.binding.receiver.capture(builder, &block)

          new_templates
        end
      end

      protected

      attr_reader :block
    end
  end
end

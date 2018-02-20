# frozen_string_literal: true

module Bemer
  module Builders
    class Template # rubocop:disable Style/Documentation
      def initialize(templates, **options)
        @options   = options
        @predicate = Bemer::Predicate.new(options)
        @templates = templates
      end

      (Pipeline::MODES - Pipeline::STRUCTURE_RELATED_MODES).each do |mode|
        define_method(mode) do |body|
          templates.unshift Bemer::Template.new(mode, body, predicate)
        end
      end

      Pipeline::STRUCTURE_RELATED_MODES.each do |mode|
        define_method(mode) do |body = nil, &block|
          body = block.respond_to?(:call) ? block : body

          templates.unshift Bemer::Template.new(mode, body, predicate)
        end
      end

      def specify(**new_options)
        builder = Builders::Template.new(templates, new_options.deep_merge(options))

        block_given? ? yield(builder) : builder
      end

      protected

      attr_reader :templates, :predicate, :options
    end
  end
end

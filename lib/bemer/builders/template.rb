# frozen_string_literal: true

module Bemer
  module Builders
    class Template
      ALL_METHODS            = [*Pipeline::MODES, *Pipeline::ADD_MODES].freeze
      MULTI_ARGUMENT_METHODS = [Pipeline::ADD_CLS_MODE, Pipeline::ADD_MIX_MODE,
                                Pipeline::CLS_MODE, Pipeline::MIX_MODE].freeze

      private_constant :ALL_METHODS, :MULTI_ARGUMENT_METHODS

      def initialize(templates, **options)
        @options   = options
        @predicate = Bemer::Predicate.new(options)
        @templates = templates
      end

      (ALL_METHODS - MULTI_ARGUMENT_METHODS - Pipeline::STRUCTURE_RELATED_MODES).each do |mode|
        define_method(mode) do |body|
          templates.unshift Bemer::Template.new(mode, body, predicate)
        end
      end

      MULTI_ARGUMENT_METHODS.each do |mode|
        define_method(mode) do |*body|
          body, = *body if body[0].respond_to?(:call)

          templates.unshift Bemer::Template.new(mode, body, predicate)
        end
      end

      Pipeline::STRUCTURE_RELATED_MODES.each do |mode|
        define_method(mode) do |body = nil, &block|
          body = block if block.respond_to?(:call)

          templates.unshift Bemer::Template.new(mode, body, predicate)
        end
      end

      def specify(condition = options[:condition], **new_options)
        params  = { **options, condition: condition }
        builder = Builders::Template.new(templates, new_options.deep_merge(params))

        block_given? ? yield(builder) : builder
      end

      protected

      attr_reader :templates, :predicate, :options
    end
  end
end

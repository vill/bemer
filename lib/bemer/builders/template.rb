# frozen_string_literal: true

module Bemer
  module Builders
    class Template
      ALL_METHODS            = [*Pipeline::MODES, *Pipeline::ADD_MODES].freeze
      MULTI_ARGUMENT_METHODS = [Pipeline::ADD_CLS_MODE, Pipeline::ADD_MIX_MODE,
                                Pipeline::CLS_MODE, Pipeline::MIX_MODE].freeze

      private_constant :ALL_METHODS, :MULTI_ARGUMENT_METHODS

      def initialize(templates, block: '*', elem: nil, condition: true, **options)
        @block     = block
        @element   = elem
        @condition = condition
        @options   = options
        @predicate = Bemer::Predicate.new(block: block, elem: elem, condition: condition, **options)
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

      def specify(condition = @condition, block: @block, elem: @element, **new_options)
        block   = @block.eql?('*') ? block : @block
        elem    = @element.nil? || @element.eql?('*') ? elem : @element
        params  = { **new_options, **options, condition: condition, block: block, elem: elem }
        builder = Builders::Template.new(templates, **params)

        block_given? ? yield(builder) : builder
      end

      protected

      attr_reader :templates, :predicate, :options
    end
  end
end

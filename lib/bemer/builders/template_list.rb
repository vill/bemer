# frozen_string_literal: true

module Bemer
  module Builders
    class TemplateList
      def initialize(templates)
        @templates = templates
      end

      def block(name = '*', condition = true, **options)
        params = { **options, condition: condition, block: name, elem: nil }

        builder = Builders::Template.new(templates, params)

        block_given? ? yield(builder) : builder
      end

      def elem(name = '*', condition = true, block: '*', **options)
        params = { **options, condition: condition, block: block || '*', elem: name }

        builder = Builders::Template.new(templates, params)

        block_given? ? yield(builder) : builder
      end

      def match(condition = true, block: '*', elem: '*', **options)
        entities = []

        entities << { block: block } if need_block?(block, elem)
        entities << { block: block || '*', elem: elem } if need_element?(elem)

        builders = entities.map do |entity|
          Builders::Template.new(templates, **options, condition: condition, **entity)
        end

        return yield(builders[0], builders[1]) if block_given?

        builders.length.odd? ? builders[0] : builders
      end

      protected

      attr_reader :templates

      def need_block?(block, element)
        return true if block.eql?('*') && element.eql?('*')

        !block.nil? && !block.instance_of?(FalseClass) && !need_element?(element)
      end

      def need_element?(element)
        !element.nil? && !element.instance_of?(FalseClass)
      end
    end
  end
end

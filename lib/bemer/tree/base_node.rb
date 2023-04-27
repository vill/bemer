# frozen_string_literal: true

require 'forwardable'

module Bemer
  class Tree
    class BaseNode
      extend Forwardable

      attr_reader :entity, :entity_builder, :tree

      def_delegators :entity, :attrs, :bem, :bem_cascade, :block, :block?, :cls,
                     :content, :elem, :elem?, :element?, :js, :mix, :mods, :name, :tag

      def initialize(tree, block = '', element = nil, **options, &content)
        @entity         = Entity.new(block, element, **options, &content)
        @entity_builder = EntityBuilder.new(block, element, **options, &content)
        @renderer       = Renderer.new
        @tree           = tree
      end

      def render
        entity_builder.content = capture_content

        renderer.render(entity_builder)
      end

      def print(level = 0)
        prefix = '   ' * level

        puts [prefix, name, "(#{object_id})"].join
      end

      def need_replace?
        false
      end

      protected

      attr_reader :renderer

      def capture_content
        return content unless content.respond_to?(:call)

        content.binding.receiver.capture(&content)
      end
    end
  end
end

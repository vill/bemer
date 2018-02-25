# frozen_string_literal: true

require 'forwardable'

module Bemer
  class Tree
    class Node # rubocop:disable Style/Documentation
      extend Forwardable

      attr_accessor :content_replaced, :need_replace, :params
      attr_reader   :applied_modes, :children, :entity, :entity_builder, :replacers, :tree

      alias content_replaced? content_replaced
      alias need_replace? need_replace

      def_delegators :entity, :attrs, :bem, :bem_cascade, :block, :block?, :cls,
                     :content, :elem, :elem?, :element?, :js, :mix, :mods, :name, :tag

      def initialize(tree, block = '', element = nil, **options, &content)
        @applied_modes     = Pipeline::MODES.map { |mode| [mode, false] }.to_h
        @children          = []
        @content_replaced  = false
        @entity            = Entity.new(block, element, options, &content)
        @entity_builder    = EntityBuilder.new(block, element, options, &content)
        @need_replace      = false
        @params            = {}
        @renderer          = Renderer.new
        @replacers         = []
        @tree              = tree
      end

      def render
        entity_builder.content = capture_content

        renderer.render(entity_builder)
      end

      def last?
        tree.node_metadata[object_id][:last]
      end

      def first?
        position.eql?(1)
      end

      def position
        tree.node_metadata[object_id][:position]
      end

      def add_child_nodes
        return content unless content.respond_to?(:call)

        builder = Builders::TreeElement.new(tree, block) if block?

        content.binding.receiver.capture(builder, &content)
      end

      def replace_parent_and_execute
        return unless block_given?

        old_parent_node  = tree.parent_node
        tree.parent_node = self

        output = yield

        tree.parent_node = old_parent_node

        output
      end

      def print(level = 0)
        prefix = '   ' * level

        puts [prefix, name, "(#{object_id})"].join

        children.each do |node|
          node.print(level + 1)
        end
      end

      protected

      attr_reader :renderer

      def capture_content
        output     = ActiveSupport::SafeBuffer.new
        plain_text = replace_parent_and_execute { add_child_nodes } if need_add_child_nodes?

        output << entity_builder.content if need_include_builder_content?
        output << plain_text
        output << render_child_nodes
      end

      def need_include_builder_content?
        !entity_builder.content.respond_to?(:call) && !need_replace?
      end

      def need_add_child_nodes?
        content.respond_to?(:call) && children.empty? && !content_replaced
      end

      def render_child_nodes # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
        return if children.empty?

        position = 0
        output   = ActiveSupport::SafeBuffer.new

        replace_parent_and_execute do
          while position < children.count
            node = children[position]

            tree.pipeline.run!(node)

            next tree.replace(node) if node.need_replace?

            position += 1

            output << node.render
          end
        end

        output
      end

      def initialize_copy(original)
        @applied_modes          = Hash[original.applied_modes]
        @children               = []
        @content_replaced       = false
        @entity                 = original.entity.dup
        @entity_builder         = original.entity_builder.dup
        @need_replace           = false
        @replacers              = []
      end
    end
  end
end

# frozen_string_literal: true

require 'action_view/buffers'
require 'active_support/dependencies/autoload'

module Bemer
  class Tree
    extend ActiveSupport::Autoload

    eager_autoload do
      autoload :BaseNode
      autoload :Node
      autoload :TextNode
    end

    attr_accessor :parent_node
    attr_reader   :node_metadata, :pipeline

    def initialize(template_catalog, **params)
      @node_metadata = {}
      @params        = params
      @parent_node   = nil
      @pipeline      = Pipeline.new(template_catalog)
      @root_nodes    = []
    end

    def render(&block)
      return unless block_given?

      builder = Builders::Tree.new(self)
      output  = ::ActionView::OutputBuffer.new

      output << block.binding.receiver.capture(builder, &block)
      output << render_root_nodes
    end

    def replace(node) # rubocop:disable Metrics/AbcSize
      siblings = parent_node.nil? ? root_nodes : parent_node.children
      metadata = node_metadata.delete(node.object_id)
      position = metadata[:position]
      offset   = position + node.replacers.length

      insert_metadata(position, metadata[:last], node.replacers)
      update_metadata(offset, siblings[position..-1])

      siblings[position - 1...position] = node.replacers
    end

    def print
      root_nodes.each(&:print)
    end

    def add(node)
      if need_replace_parent_node?
        parent_node.replacers << node
      else
        add_metadata(node.object_id)

        parent_node.nil? ? root_nodes << node : parent_node.children << node
      end

      nil
    end

    def add_node(block = '', element = nil, bem_cascade: nil, **options, &content)
      bem_cascade = inherited_bem_cascade if bem_cascade.nil?
      new_options = { **params, bem_cascade: bem_cascade, **options }

      add Node.new(self, block, element, **new_options, &content)
    end

    def add_text_node(content = nil, &callback)
      add TextNode.new(self, content, &callback)
    end

    protected

    attr_reader :root_nodes, :params

    def inherited_bem_cascade
      parent_node.nil? ? params[:bem_cascade] : parent_node.bem_cascade
    end

    def need_replace_parent_node?
      !parent_node.nil? && parent_node.need_replace?
    end

    def render_root_nodes
      output   = ::ActionView::OutputBuffer.new
      position = 0

      while position < root_nodes.length
        root_node = root_nodes[position]

        pipeline.run!(root_node)

        next replace(root_node) if root_node.need_replace?

        position += 1

        output << root_node.render
      end

      output
    end

    def add_metadata(node_id)
      siblings     = parent_node.nil? ? root_nodes : parent_node.children
      last_sibling = siblings.last

      node_metadata[last_sibling.object_id][:last] = false if last_sibling

      node_metadata[node_id] = { position: siblings.length + 1, last: true }
    end

    def insert_metadata(position, last, replacers)
      index         = 0
      length        = replacers.length
      last_position = length - 1

      while index < length
        data = { position: position + index, last: last && last_position.eql?(index) }

        node_metadata[replacers[index].object_id] = data

        index += 1
      end
    end

    def update_metadata(offset, siblings)
      index  = 0
      length = siblings.length

      while index < length
        sibling = siblings[index]

        node_metadata[sibling.object_id][:position] = offset + index

        index += 1
      end
    end
  end
end

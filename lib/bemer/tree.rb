# frozen_string_literal: true

module Bemer
  class Tree # rubocop:disable Style/Documentation
    attr_accessor :parent_node
    attr_reader   :node_metadata, :pipeline

    def initialize(**params, &callback)
      @callback      = callback
      @node_metadata = {}
      @params        = params
      @parent_node   = nil
      @pipeline      = Pipeline.new(&callback)
      @root_nodes    = []
    end

    def render
      return unless callback

      builder = Builders::Tree.new(self)
      output  = ActiveSupport::SafeBuffer.new

      output << callback.binding.receiver.capture(builder, &callback)
      output << render_root_nodes
    end

    def replace(node) # rubocop:disable Metrics/AbcSize
      nodes    = parent_node.nil? ? root_nodes : parent_node.children
      metadata = node_metadata.delete(node.object_id)
      position = metadata[:position]
      offset   = position + node.replacers.count

      insert_metadata(position, metadata[:last], node.replacers)
      update_metadata(offset, nodes[position..-1])

      nodes[position - 1...position] = node.replacers
    end

    def print
      root_nodes.each(&:print)
    end

    def add(node)
      return parent_node.replacers << node if need_replace_parent_node?

      add_metadata(node.object_id)

      parent_node.nil? ? root_nodes << node : parent_node.children << node
    end

    def add_node(block = '', element = nil, **options, &content)
      bem_cascade = parent_node.nil? ? params[:bem_cascade] : parent_node.bem_cascade
      new_options = { **params, bem_cascade: bem_cascade, **options }

      add Node.new(self, block, element, new_options, &content)

      nil
    end

    protected

    attr_reader :callback, :root_nodes, :params

    def need_replace_parent_node?
      !parent_node.nil? && parent_node.need_replace?
    end

    def render_root_nodes
      output   = ActiveSupport::SafeBuffer.new
      position = 0

      while position < root_nodes.count
        root_node = root_nodes[position]

        pipeline.run!(root_node) unless root_node.all_modes_applied?

        next replace(root_node) if root_node.need_replace?

        position += 1

        output << root_node.render
      end

      output
    end

    def add_metadata(node_id)
      nodes     = parent_node.nil? ? root_nodes : parent_node.children
      last_node = nodes.last

      node_metadata[last_node.object_id][:last] = false if last_node

      node_metadata[node_id] = { position: nodes.count + 1, last: true }
    end

    def insert_metadata(position, last, nodes)
      last_position = nodes.count - 1
      index         = 0

      while index < nodes.count
        data  = { position: position + index, last: last && last_position.eql?(index) }
        node  = nodes[index]
        index += 1

        node_metadata[node.object_id] = data
      end
    end

    def update_metadata(offset, nodes)
      index = 0

      while index < nodes.count
        node = nodes[index]

        node_metadata[node.object_id][:position] = offset + index

        index += 1
      end
    end
  end
end

# frozen_string_literal: true

require 'forwardable'

module Bemer
  class Template < CommonTemplate
    extend Forwardable

    def_delegators :predicate, :wildcard?, :match?, :name_match?

    def initialize(mode, body, predicate)
      super(mode)

      @add_mode  = !@mode.eql?(mode)
      @body      = body
      @method    = [@mode, '='].join.to_sym
      @predicate = predicate
    end

    def apply(node)
      case mode
      when Pipeline::REPLACE_MODE then replace(node)
      when Pipeline::CONTENT_MODE then capture_content(node)
      else node.entity_builder.public_send(method, capture_body(node), false)
      end
    end

    def apply!(node)
      return replace!(node) if Pipeline::REPLACE_MODE.eql?(mode)

      content = Pipeline::CONTENT_MODE.eql?(mode) ? capture_content!(node) : capture_body(node)

      node.entity_builder.public_send(method, content)
    end

    protected

    attr_reader :add_mode, :body, :method, :predicate

    alias add_mode? add_mode

    def capture_content(node)
      return body unless body.respond_to?(:call)

      builder = Builders::Tree.new(node.tree)

      body.binding.receiver.capture(build_context(node), builder, &body)
    end

    def capture_body(node)
      output = body.respond_to?(:call) ? body.call(build_context(node)) : body

      return output unless add_mode?

      normalized_output = node.entity_builder.public_send(method, output, false)

      [*node.apply(mode, self), *normalized_output]
    end

    def replace(node)
      output = capture_content(node)

      return if output.blank?

      node.replacers.unshift Tree::TextNode.new(node.tree, output)

      nil
    end

    def replace!(node)
      node.need_replace = true

      node.replace_parent_and_execute { replace(node) }
    end

    def capture_content!(node)
      node.content_replaced = true

      node.replace_parent_and_execute { capture_content(node) }
    end

    def build_context(node)
      context = Context.new(node, self)

      context.class.public_send(:include, ContextExtentions::Template)

      return context unless Pipeline::STRUCTURE_RELATED_MODES.include?(mode)

      context.class.public_send(:include, ContextExtentions::Structure)

      context
    end
  end
end

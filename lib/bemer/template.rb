# frozen_string_literal: true

module Bemer
  class Template
    attr_reader :mode, :wildcard

    alias wildcard? wildcard

    def initialize(mode, body, predicate)
      @body      = body
      @mode      = mode
      @predicate = predicate
      @wildcard  = predicate.name.include?('*')
    end

    def match?(node)
      predicate.match? build_context(node)
    end

    def name_match?(name)
      predicate.name_match?(name)
    end

    def apply(node)
      case mode
      when Pipeline::REPLACE_MODE then perform_replacement_mode(node)
      when Pipeline::CONTENT_MODE then capture(node)
      else
        body.respond_to?(:call) ? body.call(build_context(node)) : body
      end
    end

    def apply!(node) # rubocop:disable Metrics/AbcSize
      return perform_replacement_mode!(node) if Pipeline::REPLACE_MODE.eql?(mode)

      content =
        if Pipeline::CONTENT_MODE.eql?(mode)
          perform_content_mode!(node)
        else
          body.respond_to?(:call) ? body.call(build_context(node)) : body
        end

      node.entity_builder.public_send("#{mode}=", content)
    end

    protected

    attr_reader :body, :predicate

    def capture(node)
      return body unless body.respond_to?(:call)

      builder = Builders::Tree.new(node.tree)

      body.binding.receiver.capture(build_context(node), builder, &body)
    end

    def perform_replacement_mode(node)
      output = capture(node)

      return if output.blank?

      node.replacers.unshift Tree::TextNode.new(node.tree, output)
    end

    def perform_replacement_mode!(node)
      node.need_replace = true

      node.replace_parent_and_execute { perform_replacement_mode(node) }
    end

    def perform_content_mode!(node)
      node.content_replaced = true

      node.replace_parent_and_execute { capture(node) }
    end

    def build_context(node)
      Context.new(self, node)
    end
  end
end

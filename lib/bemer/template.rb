# frozen_string_literal: true

module Bemer
  class Template < CommonTemplate
    attr_reader :wildcard

    alias wildcard? wildcard

    def initialize(mode, body, predicate)
      super(mode)

      @body      = body
      @method    = "#{mode}="
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
      when Pipeline::REPLACE_MODE then replace(node)
      when Pipeline::CONTENT_MODE then capture_content(node)
      else
        duplicate = node.dup

        duplicate.entity_builder.public_send(method, capture_body(duplicate))
      end
    end

    def apply!(node)
      return replace!(node) if Pipeline::REPLACE_MODE.eql?(mode)

      content = Pipeline::CONTENT_MODE.eql?(mode) ? capture_content!(node) : capture_body(node)

      node.entity_builder.public_send(method, content)
    end

    protected

    attr_reader :body, :method, :predicate

    def capture_content(node)
      return body unless body.respond_to?(:call)

      builder = Builders::Tree.new(node.tree)

      body.binding.receiver.capture(build_context(node), builder, &body)
    end

    def capture_body(node)
      body.respond_to?(:call) ? body.call(build_context(node)) : body
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
      Context.new(self, node)
    end
  end
end

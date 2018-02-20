# frozen_string_literal: true

module Bemer
  class Template # rubocop:disable Style/Documentation
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

    def name?(name)
      predicate.name?(name)
    end

    def apply!(node) # rubocop:disable Metrics/AbcSize
      return perform_replacement_mode(node) if Pipeline::REPLACE_MODE.eql?(mode)

      content =
        if Pipeline::CONTENT_MODE.eql?(mode)
          perform_content_mode(node)
        else
          body.respond_to?(:call) ? body.call(build_context(node)) : body
        end

      node.entity_builder.public_send("#{mode}=", content)
    end

    protected

    attr_reader :body, :predicate

    def capture(node, builder)
      return body unless body.respond_to?(:call)

      body.binding.receiver.capture(build_context(node), builder, &body)
    end

    def perform_replacement_mode(node)
      builder       = Builders::NodeReplacer.new(node)
      output        = capture(node, builder)
      node.replaced = true

      return if output.blank?

      node.prepend_text_replacer(output)
    end

    def perform_content_mode(node)
      node.content_replaced = true
      builder               = Builders::Tree.new(node.tree)

      node.replace_parent_and_execute { capture(node, builder) }
    end

    def build_context(node)
      Context.new(self, node)
    end
  end
end

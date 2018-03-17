# frozen_string_literal: true

require 'forwardable'

module Bemer
  class Tag
    extend Forwardable

    def initialize(block = '', element = nil, **options, &content)
      @bem_cascade = options[:bem_cascade]
      @tag_builder = TagBuilder.new(block, element, options, &content)
      @renderer    = Renderer.new
    end

    def render
      tag_builder.content = capture_content

      renderer.render(tag_builder)
    end

    protected

    attr_reader :bem_cascade, :renderer, :tag_builder

    def_delegators :tag_builder, :block, :block?, :content

    def capture_content
      return content unless content.respond_to?(:call)

      builder = Builders::Tag::Element.new(block, bem_cascade) if block?

      content.binding.receiver.capture(builder, &content)
    end
  end
end

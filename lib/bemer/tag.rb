# frozen_string_literal: true

require 'forwardable'

module Bemer
  class Tag
    extend Forwardable

    def initialize(block = '', element = nil, bem_cascade: nil, **options, &content)
      @bem_cascade    = bem_cascade
      @entity_builder = EntityBuilder.new(block, element, options, &content)
      @renderer       = Renderer.new
    end

    def render
      entity_builder.content = capture_content

      renderer.render(entity_builder)
    end

    protected

    attr_reader :bem_cascade, :entity_builder, :renderer

    def_delegators :entity_builder, :block, :block?, :content

    def capture_content
      return content unless content.respond_to?(:call)

      builder = Builders::Tag::Element.new(block, bem_cascade) if block?

      content.binding.receiver.capture(builder, &content)
    end
  end
end
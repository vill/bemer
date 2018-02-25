# frozen_string_literal: true

module Bemer
  module Builders
    module Tag
      class Element # rubocop:disable Style/Documentation
        def initialize(block, bem_cascade)
          @bem_cascade = bem_cascade
          @block       = block
        end

        def elem(name = '', **options, &content)
          Bemer::Tag.new(block, name, bem_cascade: bem_cascade, **options, &content).render
        end

        protected

        attr_reader :block, :bem_cascade
      end
    end
  end
end

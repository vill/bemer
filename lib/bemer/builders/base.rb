# frozen_string_literal: true

module Bemer
  module Builders
    class Base
      attr_reader :name, :view, :options

      def initialize(name, view, **options)
        @name    = name.to_s.underscore.dasherize
        @options = options
        @view    = view
      end

      def render
        raise NotImplementedError
      end
    end
  end
end

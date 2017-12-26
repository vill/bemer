# frozen_string_literal: true

module Bemer
  module Builders
    class Base
      attr_reader :name, :template, :options

      def initialize(name, template, **options)
        @name     = name.to_s.underscore.dasherize
        @options  = options
        @template = template
      end

      def render
        raise NotImplementedError
      end
    end
  end
end

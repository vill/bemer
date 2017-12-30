# frozen_string_literal: true

require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/object/blank'

module Bemer
  class Component
    attr_reader :name, :options, :partial, :template

    def initialize(name, template, context = nil, **options)
      context ||= default_context(template)

      name         = name.to_s.underscore
      partial_name = name.dasherize

      @name     = name
      @options  = options
      @partial  = [context, partial_name, partial_name].reject(&:blank?).join('/')
      @template = template
    end

    def render(&block)
      prepend_view_path_and_render do
        next template.render(as: name, **options, partial: partial) if options.key?(:collection)

        callback = block_given? ? block : proc {}

        template.render(partial, options, &callback)
      end
    end

    protected

    def prepend_view_path_and_render
      path       = Bemer.path.to_s
      paths      = template.view_paths.map { |view_path| view_path.instance_variable_get(:@path) }
      view_paths = template.view_paths.dup

      template.controller.prepend_view_path(path) unless paths.include?(path)

      output = yield

      template.view_paths = view_paths

      output
    end

    def default_context(template)
      return Bemer.default_context.to_s unless Bemer.default_context.respond_to?(:call)

      Bemer.default_context.call(template)
    end
  end
end

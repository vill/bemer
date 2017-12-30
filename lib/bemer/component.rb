# frozen_string_literal: true

require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/object/blank'

module Bemer
  class Component
    attr_reader :name, :options, :partial, :view

    def initialize(name, view, context = nil, **options)
      context ||= default_context_from(view)

      name         = name.to_s.underscore
      partial_name = name.dasherize

      @name    = name
      @options = options
      @partial = [context, partial_name, partial_name].reject(&:blank?).join('/')
      @view    = view
    end

    def render(&block)
      prepend_view_path_and_render do
        next view.render(as: name, **options, partial: partial) if options.key?(:collection)

        callback = block_given? ? block : proc {}

        view.render(partial, options, &callback)
      end
    end

    protected

    def prepend_view_path_and_render
      path       = Bemer.path.to_s
      paths      = view.view_paths.map { |view_path| view_path.instance_variable_get(:@path) }
      view_paths = view.view_paths.dup

      view.controller.prepend_view_path(path) unless paths.include?(path)

      output = yield

      view.view_paths = view_paths

      output
    end

    def default_context_from(view)
      return Bemer.default_context.to_s unless Bemer.default_context.respond_to?(:call)

      Bemer.default_context.call(view)
    end
  end
end

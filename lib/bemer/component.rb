# frozen_string_literal: true

require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/object/blank'

module Bemer
  class Component
    attr_reader :local_name, :options, :partial, :view

    def initialize(level_and_name, view, context: true, **options)
      *level, name = level_and_name.to_s.split('/')
      local_name   = name.underscore
      partial_name = local_name.dasherize
      partial_dir  = partial_name
      context      = build_context(context, view)

      @local_name = local_name
      @options    = options
      @partial    = [context, *level, partial_dir, partial_name].reject(&:blank?).join('/')
      @view       = view
    end

    def render(&block)
      prepend_view_path_and_render do
        next view.render(as: local_name, **options, partial: partial) if options.key?(:collection)

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

    def build_context(context, view)
      return context if context.instance_of?(String) || context.instance_of?(Symbol)

      default_context(view) if context
    end

    def default_context(view)
      return Bemer.default_context.to_s unless Bemer.default_context.respond_to?(:call)

      Bemer.default_context.call(view)
    end
  end
end

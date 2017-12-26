# frozen_string_literal: true

module Bemer
  class Component
    attr_reader :partial, :template, :options

    def initialize(name, template, context = nil, **options)
      context ||= Bemer.default_context.call(template).to_s
      name      = name.to_s.underscore

      @partial  = [context, name, name].reject(&:blank?).join('/')
      @options  = options
      @template = template
    end

    def render(&block)
      prepend_view_path_and_render do
        next template.render(options.merge(partial: partial)) if options.key?(:collection)

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
  end
end

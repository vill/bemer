# frozen_string_literal: true

module Bemer
  class TemplateList < DefaultTemplateList # rubocop:disable Style/Documentation
    def initialize(view, path, path_prefix: true, **options)
      super(view)

      @options = options
      @path    = build_full_path(path_prefix, path)
    end

    def compile
      super

      add_default_templates

      view.render(template: template, locals: { **options })
    end

    protected

    attr_reader :options, :path

    def add_default_templates
      default_template = template('index.bemhtml')

      return unless view.lookup_context.exists?(default_template)

      view.render(template: default_template)
    end

    def template(name = 'index')
      [path, name].join('/')
    end

    def build_full_path(path_prefix, path)
      return path if !path_prefix.nil? && path_prefix.blank?

      path_prefix = default_path_prefix(path) if need_default_path_prefix?(path_prefix)

      [path_prefix, path].reject(&:blank?).join('/')
    end

    def default_path_prefix(path)
      return Bemer.default_path_prefix.to_s unless Bemer.default_path_prefix.respond_to?(:call)

      Bemer.default_path_prefix.call(path, view)
    end

    def need_default_path_prefix?(path_prefix)
      ![String, Symbol, FalseClass].include?(path_prefix.class)
    end
  end
end

# frozen_string_literal: true

require 'active_support/core_ext/object/blank'

module Bemer
  class TemplateList < DefaultTemplateList
    def initialize(view, path, cached: false, prefix: true, **options)
      super(view, cached)

      @options = options
      @path    = build_full_path(prefix, path)
    end

    def compile
      super

      add_default_templates

      output = view.render(template: template, locals: { **options })

      remove_template_catalog!

      output
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

    def build_full_path(prefix, path)
      return path if prefix.blank?

      path_prefix = prefix.instance_of?(TrueClass) ? default_path_prefix(path) : prefix

      [path_prefix, path].reject(&:blank?).join('/')
    end

    def default_path_prefix(path)
      return Bemer.default_path_prefix.to_s unless Bemer.default_path_prefix.respond_to?(:call)

      Bemer.default_path_prefix.call(path, view)
    end

    def remove_template_catalog!
      return unless template_catalog.owner.eql?(object_id)

      view.remove_instance_variable(:@bemer_template_catalog)
    end
  end
end

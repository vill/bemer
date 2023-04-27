# frozen_string_literal: true

module Bemer
  class PathResolver
    def initialize(view)
      @view = view
    end

    def resolve(name, partial = false) # rubocop:disable Metrics/AbcSize
      name         = name.to_s
      virtual_dir  = File.dirname(view.instance_variable_get(:@virtual_path))
      dirs         = [virtual_dir, File.dirname(name).delete('.')].reject(&:blank?)
      prefixes     = [File.join(*dirs).to_s]
      format       = File.extname(name).delete('.') unless partial
      basename     = File.basename(name, '.*')
      options      = { formats: [format.to_sym] } if format

      return name unless view.lookup_context.exists?(basename, prefixes, partial, **options.to_h)

      File.join(virtual_dir, name).to_s
    end

    protected

    attr_reader :view
  end
end

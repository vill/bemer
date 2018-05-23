# frozen_string_literal: true

module Bemer
  class PathResolver
    def initialize(view)
      @view = view
    end

    def resolve(name, partial = false)
      virtual_path = view.instance_variable_get(:@virtual_path)
      directory    = [File.dirname(virtual_path)]
      file_name    = name.to_s

      return file_name unless view.lookup_context.exists?(file_name, directory, partial)

      File.join(directory, file_name).to_s
    end

    protected

    attr_reader :view
  end
end

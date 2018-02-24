# frozen_string_literal: true

require 'active_support/dependencies/autoload'

module Bemer
  module Builders
    extend ActiveSupport::Autoload

    eager_autoload do
      autoload :Template
      autoload :TemplateList
      autoload :Tree
      autoload :TreeElement
    end
  end
end

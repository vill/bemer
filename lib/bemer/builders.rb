# frozen_string_literal: true

module Bemer
  module Builders
    extend ActiveSupport::Autoload

    eager_autoload do
      autoload :NodeReplacer
      autoload :NodeReplacerElement
      autoload :Tree
      autoload :TreeElement
    end
  end
end

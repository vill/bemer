# frozen_string_literal: true

module Bemer
  module Builders
    extend ActiveSupport::Autoload

    eager_autoload do
      autoload :Base
      autoload :Block
      autoload :Element
    end
  end
end

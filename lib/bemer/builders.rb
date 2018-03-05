# frozen_string_literal: true

require 'active_support/dependencies/autoload'

module Bemer
  module Builders
    extend ActiveSupport::Autoload

    eager_autoload do
      autoload :Template
      autoload :TemplateList
      autoload :Tree
    end

    module Tag
      extend ActiveSupport::Autoload

      eager_autoload do
        autoload :Element
      end
    end
  end
end

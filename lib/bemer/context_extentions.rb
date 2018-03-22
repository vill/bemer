# frozen_string_literal: true

require 'active_support/dependencies/autoload'

module Bemer
  module ContextExtentions
    extend ActiveSupport::Autoload

    autoload :Structure
    autoload :Template
  end
end

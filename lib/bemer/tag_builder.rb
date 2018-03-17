# frozen_string_literal: true

module Bemer
  class TagBuilder < EntityBuilder
    protected

    def bem_enabled_fully?
      bem_cascade && bem
    end
  end
end

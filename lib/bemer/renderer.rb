# frozen_string_literal: true

require 'action_view'

module Bemer
  class Renderer
    include ::ActionView::Helpers::TagHelper

    def render(builder)
      return builder.content if builder.tag.blank?

      content_tag(builder.tag, builder.content, builder.attrs)
    end
  end
end

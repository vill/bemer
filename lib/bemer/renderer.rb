# frozen_string_literal: true

require 'forwardable'
require 'action_view/helpers/tag_helper'
require 'active_support/core_ext/object/blank'

module Bemer
  class Renderer # rubocop:disable Style/Documentation
    extend  Forwardable
    include ::ActionView::Helpers::TagHelper

    def render(builder)
      @builder = builder

      return content if tag.blank?

      content_tag(tag, content, class: css_classes, **html_options)
    end

    protected

    METHOD_NAMES = %i[attrs bem? bem_class cls content js_attrs js_class mix mods tag].freeze

    def_instance_delegators :@builder, *METHOD_NAMES

    def html_options
      bem? ? { **attrs, **js_attrs } : attrs
    end

    def css_classes
      return cls unless bem?

      [bem_class, mix, mods, js_class, cls].reject(&:blank?)
    end
  end
end

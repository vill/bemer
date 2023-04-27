# frozen_string_literal: true

require 'active_support/dependencies/autoload'

module Bemer
  class Pipeline
    extend ActiveSupport::Autoload

    eager_autoload do
      autoload :Handler
    end

    ADD_ATTRS_MODE = :add_attrs
    ADD_CLS_MODE   = :add_cls
    ADD_MIX_MODE   = :add_mix
    ADD_MODS_MODE  = :add_mods
    ATTRS_MODE     = :attrs
    BEM_MODE       = :bem
    CLS_MODE       = :cls
    CONTENT_MODE   = :content
    JS_MODE        = :js
    MIX_MODE       = :mix
    MODS_MODE      = :mods
    REPLACE_MODE   = :replace
    TAG_MODE       = :tag

    ADD_MODES               = [ADD_ATTRS_MODE, ADD_CLS_MODE, ADD_MIX_MODE, ADD_MODS_MODE].freeze
    STRUCTURE_RELATED_MODES = [REPLACE_MODE, CONTENT_MODE].freeze
    BEM_RELATED_MODES       = [MODS_MODE, MIX_MODE, JS_MODE].freeze
    TAG_RELATED_MODES       = [CLS_MODE, ATTRS_MODE, BEM_MODE, *BEM_RELATED_MODES].freeze
    MODES                   = [REPLACE_MODE, CONTENT_MODE, TAG_MODE, *TAG_RELATED_MODES].freeze

    def initialize(template_catalog)
      @handlers         = {}
      @template_catalog = template_catalog
    end

    def run!(node)
      return node if node.instance_of?(Tree::TextNode)

      MODES.each do |mode|
        handler_by(node.name).apply!(mode, node)

        break if processing_completed?(mode, node)
      end

      node
    end

    def apply_next(template, node, **params)
      handler_by(node.name).apply_next(template, node, **params)
    end

    def apply(mode, template, node, **params)
      handler_by(node.name).apply(mode, template, node, **params)
    end

    protected

    attr_reader :handlers, :template_catalog

    def processing_completed?(mode, node)
      return true if JS_MODE.eql?(mode)

      case mode
      when REPLACE_MODE then node.need_replace?
      when TAG_MODE then node.entity_builder.tag.blank?
      when BEM_MODE then !node.entity_builder.bem?
      else false
      end
    end

    def handler_by(name)
      return handlers[name] if handlers.key?(name)

      templates = compiled_templates.select { |template| template.name_match?(name) }

      handlers[name] = Handler.new(templates)
    end

    def compiled_templates
      @compiled_templates ||= template_catalog.compiled_templates
    end
  end
end

# frozen_string_literal: true

module Bemer
  class Pipeline # rubocop:disable Style/Documentation
    ADD_ATTRS_MODE = :add_attrs
    ADD_CLS_MODE   = :add_cls
    ADD_JS_MODE    = :add_js
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

    STRUCTURE_RELATED_MODES = [REPLACE_MODE, CONTENT_MODE].freeze

    BEM_RELATED_MODES = [JS_MODE, ADD_JS_MODE, MIX_MODE,
                         ADD_MIX_MODE, MODS_MODE, ADD_MODS_MODE].freeze

    TAG_RELATED_MODES = [BEM_MODE, *BEM_RELATED_MODES, CLS_MODE,
                         ADD_CLS_MODE, ATTRS_MODE, ADD_ATTRS_MODE].freeze

    MODES = [REPLACE_MODE, TAG_MODE, *TAG_RELATED_MODES, CONTENT_MODE].freeze

    def initialize(&block)
      @compiled_templates = compile_templates(&block)
      @handlers           = {}
    end

    def run!(node)
      return node if node.all_modes_applied?

      MODES.each do |mode|
        next if node.applied_modes[mode].present?

        handler_by(node.name).apply!(mode, node)

        return node if REPLACE_MODE.eql?(mode) && node.need_replace?
      end

      node
    end

    def apply_next(template, node, **params)
      handler_by(node.name).apply_next(template, node, params)
    end

    def apply(mode, template, node, **params)
      handler_by(node.name).apply(mode, template, node, params)
    end

    protected

    attr_reader :compiled_templates, :handlers

    def compile_templates(&block)
      templates     = block.binding.receiver.instance_variable_get(:@bemer_templates) if block_given? # rubocop:disable Metrics/LineLength
      template_list = templates.last if templates.instance_of?(Array)

      return [] if template_list.frozen?

      templates = template_list.compiled_templates

      template_list.freeze

      templates
    end

    def handler_by(name)
      return handlers[name] if handlers.key?(name)

      templates = compiled_templates.select { |template| template.name_match?(name) }

      handlers[name] = Handler.new(templates)
    end
  end
end

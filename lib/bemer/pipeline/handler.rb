# frozen_string_literal: true

require 'active_support/core_ext/object/blank'

module Bemer
  class Pipeline
    class Handler # rubocop:disable Style/Documentation
      def initialize(templates)
        @priorities = Pipeline::MODES.map { |mode| [mode, {}] }.to_h
        @container  = Pipeline::MODES.map { |mode| [mode, []] }.to_h

        prioritize(templates)
      end

      def apply!(mode, node)
        return if node.applied_modes[mode].present?

        template = find_template(mode, node)

        apply_template!(template, mode, node)
      end

      protected

      attr_reader :priorities, :container

      def apply_template!(template, mode, node)
        node.applied_modes[mode] = true

        output = template ? template.apply!(node) : nil

        return output unless [Pipeline::TAG_MODE, Pipeline::BEM_MODE].include?(mode)

        disable_related_modes!(mode, node)

        output
      end

      def disable_related_modes!(mode, node)
        return disable_tag_related_modes!(node) if Pipeline::TAG_MODE.eql?(mode)

        disable_bem_related_modes!(node)
      end

      def disable_tag_related_modes!(node)
        return if node.entity_builder.tag.nil? || node.entity_builder.tag.present?

        Pipeline::TAG_RELATED_MODES.each { |mode| node.applied_modes[mode] = true }
      end

      def disable_bem_related_modes!(node)
        return if node.entity_builder.bem?

        Pipeline::BEM_RELATED_MODES.each { |mode| node.applied_modes[mode] = true }
      end

      def prioritize(templates) # rubocop:disable Metrics/AbcSize
        wildcard_container = Pipeline::MODES.map { |mode| [mode, []] }.to_h

        templates.each do |template|
          next wildcard_container[template.mode].push(template) if template.wildcard?

          priorities[template.mode][template.object_id] = container[template.mode].count

          container[template.mode].push(template)
        end

        wildcard_container.each do |mode, wildcard_templates|
          prepend_wildcard_templates(mode, wildcard_templates)
        end
      end

      def prepend_wildcard_templates(mode, templates)
        return if templates.empty?

        templates.reverse_each do |template|
          priorities[mode].each { |id, priority| priorities[mode][id] = priority + 1 }

          priorities[mode][template.object_id] = 0

          container[mode].unshift(template)
        end
      end

      def find_template(mode, node, start = 0)
        templates = container[mode][start..-1]

        return if templates.empty?

        templates.detect { |template| template.match?(node) }
      end
    end
  end
end

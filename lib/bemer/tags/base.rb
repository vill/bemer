# frozen_string_literal: true

module Bemer
  module Tags
    class Base # rubocop:disable Metrics/ClassLength
      attr_reader :block_name, :template, :builder, :html_options

      def initialize(block_name, template, builder, **options)
        @block_name    = block_name
        @builder       = builder
        @template      = template
        @bem           = options.delete(:bem)
        @bem_recursive = options.delete(:bem_recursive)
        @css_classes   = options.delete(:class)
        @mix           = options.delete(:mix)
        @mods          = options.delete(:mods)
        @tag           = options.delete(:tag)
        @html_options  = options
      end

      def render(content = nil, &block)
        output = content.nil? && block_given? ? template.capture(builder, &block) : content

        template.content_tag(tag, output, class: css_classes, **html_options)
      end

      def css_classes
        [bem_class, mixins, modifiers, @css_classes].flatten.reject(&:blank?)
      end

      def tag
        @tag.blank? ? default_tag : @tag
      end

      def mixins
        return [] if !bem? || @mix.blank?

        @mixins ||= begin
          mixins = @mix.instance_of?(Array) ? @mix : [@mix]

          mixins.map { |mixin| build_mixin(mixin) }
        end
      end

      def modifiers
        return [] if !bem? || @mods.blank?

        @modifiers ||= [*@mods].map { |mods| build_modifier(mods) }.flatten
      end

      def bem?
        bem_enabled_via_option? || bem_enabled_recursively_via_option? || bem_enabled_fully?
      end

      def bem
        bem_via_option? ? @bem : true
      end

      def bem_enabled_via_option?
        bem_via_option? && bem
      end

      def bem_via_option?
        !@bem.nil?
      end

      def bem_enabled_recursively_via_option?
        bem_recursively_via_option? && bem_recursive && bem
      end

      def bem_recursively_via_option?
        !@bem_recursive.nil?
      end

      def bem_enabled_fully?
        Bemer.bem && bem_recursive && bem
      end

      def bem_recursive
        bem_recursively_via_option? ? @bem_recursive : true
      end

      def default_tag
        raise NotImplementedError
      end

      def bem_class
        raise NotImplementedError
      end

      protected

      def build_mixin(attrs) # rubocop:disable Metrics/MethodLength
        case attrs
        when Hash
          bem_class_for(attrs[:block], element: attrs[:elem])
        when Array
          block, element = *attrs

          bem_class_for(block, element: element)
        when Symbol
          bem_class_for(attrs)
        when String
          return attrs unless Bemer.transform_string_values

          attrs.split(' ').reject(&:blank?).map do |mixin|
            build_mixin mixin.split(Bemer.element_name_separator)
          end.join(' ')
        end
      end

      def build_modifier(attrs)
        return attrs.map { |mods| build_modifier(mods) } if attrs.instance_of?(Hash)

        modifier_class_from(attrs)
      end

      def modifier_class_from(attrs)
        bem_class_for(block_name, modifier: attrs)
      end

      def bem_class_for(block, element: nil, modifier: nil)
        return if !bem? || block.blank?

        base_class = [css_class(block), css_class(element)].reject(&:blank?)
                                                           .join(Bemer.element_name_separator)

        return base_class if modifier.blank?

        modifier_class = css_class(modifier, separator: Bemer.modifier_value_separator)

        [base_class, modifier_class].join(Bemer.modifier_name_separator)
      end

      def css_class(*parts, separator: '-')
        parts.flatten.map do |part|
          next part if !Bemer.transform_string_values && part.instance_of?(String)

          part.to_s.underscore.dasherize
        end.join(separator)
      end
    end
  end
end

# frozen_string_literal: true

require 'active_support/core_ext/object/blank'

module Bemer
  class MixinList # rubocop:disable Style/Documentation
    def initialize(*mix)
      @mixins = build_mixins(mix)
    end

    def to_a
      mixins
    end

    def to_s
      @css_classes ||= mixins.join(' ')
    end

    protected

    attr_reader :mixins

    def build_mixins(mix)
      mix.map { |mixin| build_mixin(mixin) }.flatten.reject(&:blank?).uniq
    end

    def build_mixin(mixin)
      return mixin if mixin.instance_of?(String)

      case mixin
      when Hash
        mixin.map do |block, element|
          next Bemer.bem_class(block, element) unless element.instance_of?(Array)

          element.map { |elem| Bemer.bem_class(block, elem) }
        end
      when Symbol
        Bemer.bem_class(mixin)
      end
    end
  end
end

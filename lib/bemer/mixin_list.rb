# frozen_string_literal: true

require 'active_support/core_ext/object/blank'

module Bemer
  class MixinList
    def initialize(*mix)
      @mix    = mix
      @mixins = nil
    end

    def to_a
      build_mixins
    end

    def to_s
      @mix_as_string ||= to_a.join(' ')
    end

    protected

    attr_reader :mixins

    def build_mixins
      return mixins unless mixins.nil?

      @mixins = @mix.map { |mixin| build_mixin(mixin) }.flatten.reject(&:blank?).uniq
    end

    def build_mixin(mixin)
      return mixin if mixin.instance_of?(String)

      case mixin
      when Hash
        mixin.map do |block, element|
          next Bemer.bem_class(block, element) unless element.instance_of?(Array)

          element.map { |elem| Bemer.bem_class(block, elem) }
        end
      when Symbol then Bemer.bem_class(mixin)
      when Array then mixin.map { |mix| build_mixin(mix) }
      end
    end
  end
end

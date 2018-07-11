# frozen_string_literal: true

require 'active_support/core_ext/object/blank'

module Bemer
  class MixinList
    def initialize(mix)
      @mix    = mix
      @mixins = nil
    end

    def to_a
      build_mixins
    end

    def to_s
      @to_s ||= to_a.join(' ')
    end

    protected

    attr_reader :mixins

    def build_mixins
      return mixins unless mixins.nil?

      mix = @mix.instance_of?(Hash) ? build_mixins_from_hash : build_mixins_from_array

      @mixins = mix.flatten.reject(&:blank?).uniq
    end

    def build_mixin(mixin)
      return mixin.split if mixin.instance_of?(String)

      case mixin
      when Symbol then Bemer.bem_class(mixin)
      when Array  then build_mixin_from_array(mixin)
      when Hash   then build_mixin_from_hash(mixin)
      end
    end

    def build_mixin_from_hash(mixin)
      mixin.map do |block, element|
        next Bemer.bem_class(block, element) unless element.instance_of?(Array)

        element.map { |elem| Bemer.bem_class(block, elem) }
      end
    end

    def build_mixin_from_array(mixin)
      block, element = *mixin

      return Bemer.bem_class(block, element) unless element.instance_of?(Array)

      element.map { |elem| Bemer.bem_class(block, elem) }
    end

    def build_mixins_from_hash
      @mix.map do |mixin|
        next if mixin.blank?

        build_mixin(mixin)
      end
    end

    def build_mixins_from_array
      Array(@mix).map do |mixin|
        next if mixin.blank?

        mixin.instance_of?(Array) ? mixin.map { |mix| build_mixin(mix) } : build_mixin(mixin)
      end
    end
  end
end

# frozen_string_literal: true

require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/array/wrap'
require 'active_support/core_ext/hash/slice'

module Bemer
  class Mixes
    def initialize(*mixes)
      @bem   = bem
      @mixes = Array.wrap(mixes).flatten
    end

    def to_a
      @to_a ||= entities.map { |e| [e.bem_class, e.mods] }.flatten.reject(&:blank?).uniq
    end

    def to_s
      @to_s ||= to_a.join(' ')
    end

    def entities # rubocop:disable Metrics/MethodLength
      @entities ||= mixes.flat_map do |mix|
        if mix.is_a?(Hash)
          options = mix.extract!(:js, :mods)

          mix.flat_map do |block, elems|
            if elems.nil?
              EntityBuilder.new(block, **options, bem: true)
            else
              Array(elems).map { |elem| EntityBuilder.new(block, elem, **options, bem: true) }
            end
          end
        else
          Array(mix).flat_map { |block| EntityBuilder.new(block) }
        end
      end
    end

    protected

    attr_reader :mixes, :bem
  end
end

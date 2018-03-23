# frozen_string_literal: true

module Bemer
  class AssetMatcher
    def initialize(loose_app_assets)
      @loose_app_assets = loose_app_assets
    end

    def call(logical_path, filename = nil)
      filename = Rails.application.assets.resolve(logical_path).to_s if filename.nil?

      return if [Bemer.path, *Bemer.asset_paths].detect { |path| filename.start_with?(path.to_s) }

      loose_app_assets.call(logical_path, filename) if loose_app_assets.respond_to?(:call)
    end

    protected

    attr_reader :loose_app_assets
  end
end

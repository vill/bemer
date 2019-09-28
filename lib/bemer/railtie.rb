# frozen_string_literal: true

require 'rails/railtie'
require 'rails/version'
require 'active_support/lazy_load_hooks'
require 'action_controller/railtie'

module Bemer
  class Railtie < ::Rails::Railtie
    class << self
      def assets_path_initializer
        case ::Rails::VERSION::MAJOR
        when 5..6 then :append_assets_path
        when 3..4 then :load_config_initializers
        end
      end
    end

    config.eager_load_namespaces << Bemer if config.respond_to?(:eager_load_namespaces)

    config.after_initialize do
      paths = [Bemer.path, *Bemer.paths]

      ActionController::Base.prepend_view_path(paths)

      next unless defined?(ActionMailer::Base)

      ActionMailer::Base.prepend_view_path(paths)
    end

    initializer 'bemer.helpers' do
      ActiveSupport.on_load(:action_view) { include Bemer::Helpers }
    end

    initializer 'bemer.prepend_asset_paths', group: :all, after: assets_path_initializer do |app|
      next unless defined?(::Sprockets) && Bemer.prepend_asset_paths?

      app.config.assets.paths.unshift(Bemer.path.to_s, *Bemer.asset_paths)
    end

    initializer 'bemer.assets_precompile', group: :all, after: :load_config_initializers do |app|
      next if ::Rails::VERSION::MAJOR > 3 || !defined?(::Sprockets)

      asset_matcher = Bemer::AssetMatcher.new(app.config.assets.precompile.shift)

      app.config.assets.precompile.unshift(asset_matcher)
    end
  end
end

# frozen_string_literal: true

module Bemer
  class Railtie < ::Rails::Railtie
    config.eager_load_namespaces << Bemer if config.respond_to?(:eager_load_namespaces)

    initializer 'bemer.helpers' do
      ActiveSupport.on_load(:action_view) { include Bemer::Helpers }
    end

    initializer 'bemer.prepend_assets_path', group: :all, after: :load_config_initializers do |app|
      next unless defined?(::Sprockets) && Bemer.prepend_assets_path?

      app.config.assets.paths.unshift(Bemer.path)
    end

    initializer 'bemer.prepend_view_path', group: :all, after: :load_config_initializers do
      ActionController::Base.prepend_view_path(Bemer.path)
    end
  end
end

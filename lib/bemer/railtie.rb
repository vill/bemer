# frozen_string_literal: true

module Bemer
  class Railtie < ::Rails::Railtie
    config.eager_load_namespaces << Bemer if config.respond_to?(:eager_load_namespaces)

    config.after_initialize do
      ActionController::Base.prepend_view_path(Bemer.path)
      ActionMailer::Base.prepend_view_path(Bemer.path)
    end

    initializer 'bemer.helpers' do
      ActiveSupport.on_load(:action_view) { include Bemer::Helpers }
    end

    initializer_name =
      case Rails::VERSION::MAJOR
      when 5    then :append_assets_path
      when 3..4 then :load_config_initializers
      end

    initializer 'bemer.prepend_assets_path', group: :all, after: initializer_name do |app|
      next unless defined?(::Sprockets) && Bemer.prepend_assets_path?

      app.config.assets.paths.unshift(Bemer.path.to_s)
    end

    initializer 'bemer.assets_precompile', group: :all, after: :load_config_initializers do |app|
      next unless defined?(::Sprockets)

      Bemer.loose_app_assets = app.config.assets.precompile.shift

      matcher = proc do |logical_path, filename|
        filename = app.assets.resolve(logical_path).to_s if filename.nil?

        next if filename.start_with?(Bemer.path.to_s)

        loose_app_assets = Bemer.loose_app_assets

        loose_app_assets.call(logical_path, filename) if loose_app_assets.respond_to?(:call)
      end

      app.config.assets.precompile.unshift(matcher)
      app.config.assets.precompile << Bemer.precompile
    end
  end
end

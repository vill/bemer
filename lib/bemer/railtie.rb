# frozen_string_literal: true

module Bemer
  class Railtie < ::Rails::Railtie
    config.eager_load_namespaces << Bemer

    initializer 'bemer.helpers' do
      ActiveSupport.on_load :action_view do
        include Bemer::Helpers
      end
    end
  end
end

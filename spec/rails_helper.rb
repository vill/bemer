# frozen_string_literal: true

ENV['RAILS_ENV'] = 'test'

require_relative 'dummy/config/environment'

require 'rspec/rails'
require 'spec_helper'
require 'fuubar'

RSpec.configure do |config|
  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  config.fuubar_progress_bar_options = { format: "Rails: #{::Rails::VERSION::STRING}  %c/%C |%w>%i| %e " }

  config.define_derived_metadata(file_path: %r{/spec/action_view/}) do |metadata|
    metadata[:type] = :view
  end

  config.include Bemer::Test::ConfigurationHelpers
end

# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'wwtd/tasks'

begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = '--format progress'
  end

  task default: :spec
rescue LoadError # rubocop:disable Lint/HandleExceptions
end

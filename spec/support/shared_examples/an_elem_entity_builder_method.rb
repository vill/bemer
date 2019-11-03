# frozen_string_literal: true

RSpec.shared_examples 'an elem entity builder method' do |html, *params|
  include_examples 'an entity builder method', html, *params
end

# frozen_string_literal: true

RSpec.shared_examples 'an entity builder method' do |html, *params|
  it 'creates an HTML structure' do
    options = params.extract_options!
    options = { content: content, **options } if defined?(content)
    name,   = *params

    expect(html).to eq entity_builder_method.call(name, options)
  end
end

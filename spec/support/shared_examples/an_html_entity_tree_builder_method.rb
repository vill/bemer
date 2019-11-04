# frozen_string_literal: true

RSpec.shared_examples 'an HTML entity tree builder method' do |*params|
  it 'creates an HTML tree' do # rubocop:disable RSpec/ExampleLength
    pretty_html     = params.pop if params[-1].is_a?(String)
    pretty_html     = html if pretty_html.nil? && defined?(html)
    compressed_html = pretty_html.to_s.strip.gsub(/>\s+/, '>')

    html_tree =
      if defined?(html_entity_tree)
        html_entity_tree
      else
        options           = params.extract_options!
        options[:content] = content if defined?(content) && !options.key?(:content)

        html_entity_tree_builder_method.call(*params, options)
      end

    expect(html_tree).to eq compressed_html
  end
end

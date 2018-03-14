# frozen_string_literal: true

RSpec.describe Bemer do
  let(:empty_arguments)           { [nil, false, '', ' '] }
  let(:empty_class)               { '' }
  let(:block_name)                { 'Block_Name' }
  let(:element_name)              { 'Element_Name' }
  let(:modifier_name)             { 'Has_Tail' }
  let(:modifier_value)            { 'Yes' }

  shared_context 'when transform_string_values is set to true' do
    before do
      described_class.config.transform_string_values = true
    end

    let(:block_class)               { 'block-name' }
    let(:element_class)             { 'block-name__element-name' }
    let(:modifier_class)            { 'block-name__element-name_has-tail' }
    let(:modifier_class_with_value) { 'block-name__element-name_has-tail_yes' }
  end

  shared_context 'when transform_string_values is set to false' do
    before do
      described_class.config.transform_string_values = false
    end

    let(:block_class)               { 'Block_Name' }
    let(:element_class)             { 'Block_Name__Element_Name' }
    let(:modifier_class)            { 'Block_Name__Element_Name_Has_Tail' }
    let(:modifier_class_with_value) { 'Block_Name__Element_Name_Has_Tail_Yes' }
  end

  shared_examples 'bem_class' do
    it 'creates a block class' do
      expect(bem_class.call(block_name)).to eq block_class
    end

    it 'creates an element class' do
      expect(bem_class.call(block_name, element_name)).to eq element_class
    end
  end

  describe '.config' do
    it 'returns instance of the Configuration class' do
      expect(described_class.config).to be Bemer::Configuration.instance
    end
  end

  describe '.bem_class' do
    subject(:bem_class) { described_class.method(:bem_class) }

    it 'creates an empty class from empty arguments', :aggregate_failures do
      empty_arguments.combination(2).each do |block, element|
        expect(bem_class.call(block, element_name)).to eq empty_class
        expect(bem_class.call(block, element)).to eq empty_class
      end
    end

    context 'when transform_string_values is set to true' do
      include_context  'when transform_string_values is set to true'
      include_examples 'bem_class'
    end

    context 'when transform_string_values is set to false' do
      include_context 'when transform_string_values is set to false'
      include_examples 'bem_class'
    end
  end
end

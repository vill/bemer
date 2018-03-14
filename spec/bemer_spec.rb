# frozen_string_literal: true

RSpec.describe Bemer do
  describe '.config' do
    it 'returns instance of the Configuration class' do
      expect(described_class.config).to be Bemer::Configuration.instance
    end
  end

  describe '.bem_class' do
    subject(:bem_class) { described_class.method(:bem_class) }

    let(:empty_arguments)           { [nil, false, '', ' '] }
    let(:block_name)                { 'Block_Name' }
    let(:element_name)              { 'Element_Name' }
    let(:block_class)               { 'Block_Name' }
    let(:element_class)             { 'Block_Name__Element_Name' }
    let(:modifier_class)            { 'Block_Name__Element_Name_Has_Tail' }
    let(:modifier_class_with_value) { 'Block_Name__Element_Name_Has_Tail_Yes' }

    it 'creates an empty class from empty arguments', :aggregate_failures do
      empty_arguments.combination(2).each do |block, element|
        expect(bem_class.call(block, element_name)).to be_empty
        expect(bem_class.call(block, element)).to be_empty
      end
    end

    it 'creates a block class' do
      expect(bem_class.call(block_name)).to eq block_class
    end

    it 'creates an element class' do
      expect(bem_class.call(block_name, element_name)).to eq element_class
    end
  end
end

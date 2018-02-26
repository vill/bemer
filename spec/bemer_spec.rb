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

    it 'creates an element class', :aggregate_failures do # rubocop:disable RSpec/ExampleLength
      empty_arguments.each do |arg|
        expect(bem_class.call(block_name, element_name, arg)).to eq element_class
        expect(bem_class.call(block_name, element_name, arg => true)).to eq element_class
        expect(bem_class.call(block_name, element_name, modifier_name => arg)).to eq element_class
        expect(bem_class.call(block_name, element_name, [modifier_name, arg])).to eq element_class
        expect(bem_class.call(block_name, element_name, [arg, true])).to eq element_class
      end
    end

    it 'creates a modifier class with only name', :aggregate_failures do
      expect(bem_class.call(block_name, element_name, modifier_name)).to eq modifier_class
      expect(bem_class.call(block_name, element_name, modifier_name => true)).to eq modifier_class
      expect(bem_class.call(block_name, element_name, [modifier_name, true])).to eq modifier_class
      expect(bem_class.call(block_name, element_name, [modifier_name])).to eq modifier_class
    end

    it 'creates a modifier class with name and value', :aggregate_failures do
      expect(bem_class.call(block_name, element_name, [modifier_name, modifier_value])).to eq modifier_class_with_value
      expect(bem_class.call(block_name, element_name, modifier_name => modifier_value)).to eq modifier_class_with_value
    end
  end

  shared_examples 'entity_css_class' do
    it 'creates a block class' do
      expect(entity_css_class.call(block_name)).to eq block_class
    end

    it 'creates an element class' do
      expect(entity_css_class.call(block_name, element_name)).to eq element_class
    end
  end

  shared_examples 'modifier_css_class' do
    it 'creates a modifier class with only name', :aggregate_failures do
      expect(modifier_css_class.call(block_name, element_name, modifier_name)).to eq modifier_class
      expect(modifier_css_class.call(block_name, element_name, modifier_name, true)).to eq modifier_class
    end

    it 'creates a modifier class with name and value' do
      expect(modifier_css_class.call(block_name, element_name, modifier_name, modifier_value)).to eq modifier_class_with_value
    end
  end

  describe '.config' do
    it 'returns instance of the Configuration class' do
      expect(described_class.config).to be Bemer::Configuration.instance
    end
  end

  describe '.compound_css_class' do
    subject(:compound_css_class) { described_class.method(:compound_css_class) }

    it 'creates an empty class from empty arguments', :aggregate_failures do
      expect(compound_css_class.call).to eq empty_class
      expect(compound_css_class.call(*empty_arguments)).to eq empty_class
      expect(compound_css_class.call(*empty_arguments, [*empty_arguments])).to eq empty_class
    end

    it 'creates a class from arguments with whitespaces' do
      expect(compound_css_class.call('  removes  ', :' all ', ' white  spaces ')).to eq 'removes-all-whitespaces'
    end

    context 'when transform_string_values is set to true' do
      before do
        described_class.config.transform_string_values = true
      end

      it 'creates a class from strings and symbols' do
        expect(compound_css_class.call(:some, :Awesome, 'CSS', 'Class')).to eq 'some-awesome-css-class'
      end

      it 'creates a class from strings and symbols with custom separator' do
        expect(compound_css_class.call(:some, :Awesome, 'CSS', 'Class', separator: '_')).to eq 'some_awesome_css_class'
      end

      it 'creates a class from nested strings and symbols' do
        expect(compound_css_class.call(:Some, ['Awesome', [:CSS]], ['Class'])).to eq 'some-awesome-css-class'
      end
    end

    context 'when transform_string_values is set to false' do
      before do
        described_class.config.transform_string_values = false
      end

      it 'creates a class from strings and symbols' do
        expect(compound_css_class.call(:some, :Awesome, 'CSS', 'Class')).to eq 'some-awesome-CSS-Class'
      end

      it 'creates a class from strings and symbols with custom separator' do
        expect(compound_css_class.call(:some, :Awesome, 'CSS', 'Class', separator: '_')).to eq 'some_awesome_CSS_Class'
      end

      it 'creates a class from nested strings and symbols' do
        expect(compound_css_class.call(:Some, ['Awesome', [:CSS]], ['Class'])).to eq 'some-Awesome-css-Class'
      end
    end
  end

  describe '.entity_css_class' do
    subject(:entity_css_class) { described_class.method(:entity_css_class) }

    it 'creates an empty class from empty arguments', :aggregate_failures do
      empty_arguments.combination(2).each do |block, element|
        expect(entity_css_class.call(block, element_name)).to eq empty_class
        expect(entity_css_class.call(block, element)).to eq empty_class
      end
    end

    context 'when transform_string_values is set to true' do
      include_context  'when transform_string_values is set to true'
      include_examples 'entity_css_class'
    end

    context 'when transform_string_values is set to false' do
      include_context 'when transform_string_values is set to false'
      include_examples 'entity_css_class'
    end
  end

  describe '.modifier_css_class' do
    subject(:modifier_css_class) { described_class.method(:modifier_css_class) }

    it 'creates an empty class from empty arguments', :aggregate_failures do
      empty_arguments.combination(3).each do |block, element, modifier|
        expect(modifier_css_class.call(block, element, modifier)).to eq empty_class
        expect(modifier_css_class.call(block, element, modifier_name)).to eq empty_class
        expect(modifier_css_class.call(block_name, element_name, modifier_name, modifier)).to eq empty_class
      end
    end

    context 'when transform_string_values is set to true' do
      include_context  'when transform_string_values is set to true'
      include_examples 'modifier_css_class'
    end

    context 'when transform_string_values is set to false' do
      include_context  'when transform_string_values is set to false'
      include_examples 'modifier_css_class'
    end
  end
end

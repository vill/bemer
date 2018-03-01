# frozen_string_literal: true

RSpec.describe Bemer::ModifierList do
  let(:empty_modifier_list)      { described_class.new(:block, :elem, '') }
  let(:modifier_list_from_array) { described_class.new(:block, :elem, [:hidden, { size: %i[m l], theme: :green_islands, visible: false, disabled: true }, 'has_tail']) }
  let(:modifier_list_from_hash)  { described_class.new(:block, :elem, hidden: true, size: %i[m l], theme: :green_islands, visible: false, disabled: true, 'has_tail' => true) }
  let(:modifiers_as_string)      { modifiers_as_array.join(' ') }

  shared_examples 'modifier_list' do
    describe '#to_a' do
      it { expect(empty_modifier_list.to_a).to be_empty }
      it { expect(modifier_list_from_array.to_a).to match_array(modifiers_as_array) }
      it { expect(modifier_list_from_hash.to_a).to match_array(modifiers_as_array) }
    end

    describe '#to_s' do
      it { expect(empty_modifier_list.to_s).to be_empty }
      it { expect(modifier_list_from_array.to_s).to eq modifiers_as_string }
      it { expect(modifier_list_from_hash.to_s).to eq modifiers_as_string }
    end
  end

  context 'when transform_string_values is set to false' do
    let(:modifiers_as_array) { %w[block__elem_hidden block__elem_size_m block__elem_size_l block__elem_theme_green-islands block__elem_disabled block__elem_has_tail] }

    before do
      Bemer.config.transform_string_values = false
    end

    include_examples 'modifier_list'
  end

  context 'when transform_string_values is set to true' do
    let(:modifiers_as_array) { %w[block__elem_hidden block__elem_size_m block__elem_size_l block__elem_theme_green-islands block__elem_disabled block__elem_has-tail] }

    before do
      Bemer.config.transform_string_values = true
    end

    include_examples 'modifier_list'
  end
end

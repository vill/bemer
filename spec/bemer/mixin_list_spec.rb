# frozen_string_literal: true

RSpec.describe Bemer::MixinList, focus: true do
  let(:empty_mixin_list) { described_class.new('') }
  let(:mixin_list)       { described_class.new(:block, { block_1: :elem_1, block: ['elem_1', :elem_2] }, 'block1', 'block__elem1') }
  let(:mixins_as_sring)  { mixins_as_array.join(' ') }

  shared_examples 'mixin_list' do
    describe '#to_a' do
      it { expect(empty_mixin_list.to_a).to be_empty }
      it { expect(mixin_list.to_a).to match_array(mixins_as_array) }
    end

    describe '#to_s' do
      it { expect(empty_mixin_list.to_s).to be_empty }
      it { expect(mixin_list.to_s).to eq mixins_as_sring }
    end
  end

  context 'when transform_string_values is set to false' do
    let(:mixins_as_array) { %w[block block-1__elem-1 block__elem_1 block__elem-2 block1 block__elem1] }

    before do
      Bemer.config.transform_string_values = false
    end

    include_examples 'mixin_list'
  end

  context 'when transform_string_values is set to true' do
    let(:mixins_as_array) { %w[block block-1__elem-1 block__elem-1 block__elem-2 block1 block__elem1] }

    before do
      Bemer.config.transform_string_values = true
    end

    include_examples 'mixin_list'
  end
end

# frozen_string_literal: true

RSpec.describe Bemer::MixinList, focus: true do
  shared_examples 'mixin_list' do
    describe 'mixins from an empty params' do
      subject(:mixin_list) { described_class.new([nil, '', {}]) }

      it 'returns an empty string' do
        expect(mixin_list.to_s).to be_empty
      end

      it 'returns an empty array' do
        expect(mixin_list.to_a).to be_empty
      end
    end

    describe 'mixins from an empty array' do
      subject(:mixin_list) { described_class.new([]) }

      it 'returns an empty string' do
        expect(mixin_list.to_s).to be_empty
      end

      it 'returns an empty array' do
        expect(mixin_list.to_a).to be_empty
      end
    end

    describe 'mixins from an empty hash' do
      subject(:mixin_list) { described_class.new({}) }

      it 'returns an empty string' do
        expect(mixin_list.to_s).to be_empty
      end

      it 'returns an empty array' do
        expect(mixin_list.to_a).to be_empty
      end
    end

    describe 'mixins from an array' do
      subject(:mixin_list) { described_class.new([:block_name, { block_name: %i[elem_name1 elem_name2] }, block: :elem]) }

      it 'returns mixins as a string' do
        expect(mixin_list.to_s).to eq 'block-name block-name__elem-name1 block-name__elem-name2 block__elem'
      end

      it 'returns mixins as an array' do
        expect(mixin_list.to_a).to match_array %w[block-name block-name__elem-name1 block-name__elem-name2 block__elem]
      end
    end

    describe 'mixins from a hash' do
      subject(:mixin_list) { described_class.new(block_name: [nil, :elem_name1, :elem_name2], block: :elem) }

      it 'returns mixins as a string' do
        expect(mixin_list.to_s).to eq 'block-name block-name__elem-name1 block-name__elem-name2 block__elem'
      end

      it 'returns mixins as an array' do
        expect(mixin_list.to_a).to match_array %w[block-name block-name__elem-name1 block-name__elem-name2 block__elem]
      end
    end

    describe 'mixins from a symbol' do
      subject(:mixin_list) { described_class.new(:block_name) }

      it 'returns mixins as a string' do
        expect(mixin_list.to_s).to eq 'block-name'
      end

      it 'returns mixins as an array' do
        expect(mixin_list.to_a).to match_array %w[block-name]
      end
    end

    describe 'mixins from a string' do
      subject(:mixin_list) { described_class.new('block_name block__elem') }

      it 'returns mixins as a string' do
        expect(mixin_list.to_s).to eq 'block_name block__elem'
      end

      it 'returns mixins as an array' do
        expect(mixin_list.to_a).to match_array %w[block_name block__elem]
      end
    end
  end

  context 'when transform_string_values is set to false' do
    before do
      Bemer.config.transform_string_values = false
    end

    include_examples 'mixin_list'

    describe 'mixins from a hash with string values' do
      subject(:mixin_list) { described_class.new('block_name' => [nil, 'elem_name1', :elem_name2], 'block' => 'elem_name') }

      it 'returns mixins as a string' do
        expect(mixin_list.to_s).to eq 'block_name block_name__elem_name1 block_name__elem-name2 block__elem_name'
      end

      it 'returns mixins as an array' do
        expect(mixin_list.to_a).to match_array %w[block_name block_name__elem_name1 block_name__elem-name2 block__elem_name]
      end
    end
  end

  context 'when transform_string_values is set to true' do
    before do
      Bemer.config.transform_string_values = true
    end

    include_examples 'mixin_list'

    describe 'mixins from a hash with string values' do
      subject(:mixin_list) { described_class.new('block_name' => [nil, 'elem_name1', :elem_name2], 'block' => 'elem_name') }

      it 'returns mixins as a string' do
        expect(mixin_list.to_s).to eq 'block-name block-name__elem-name1 block-name__elem-name2 block__elem-name'
      end

      it 'returns mixins as an array' do
        expect(mixin_list.to_a).to match_array %w[block-name block-name__elem-name1 block-name__elem-name2 block__elem-name]
      end
    end
  end
end

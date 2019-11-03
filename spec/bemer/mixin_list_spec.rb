# frozen_string_literal: true

RSpec.describe Bemer::MixinList do
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

  describe 'mixins from a hash with string values' do
    subject(:mixin_list) { described_class.new('BlockName' => [nil, 'ElemName', :elem_name], 'Block' => 'ElemName') }

    it 'returns mixins as a string' do
      expect(mixin_list.to_s).to eq 'BlockName BlockName__ElemName BlockName__elem-name Block__ElemName'
    end

    it 'returns mixins as an array' do
      expect(mixin_list.to_a).to match_array %w[BlockName BlockName__ElemName BlockName__elem-name Block__ElemName]
    end
  end
end

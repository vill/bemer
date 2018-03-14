# frozen_string_literal: true

RSpec.describe Bemer::ModifierList do
  describe 'modifiers from an empty params' do
    subject(:modifier_list) { described_class.new(:block, nil, [nil, '', {}, enabled: false]) }

    it 'returns an empty string' do
      expect(modifier_list.to_s).to be_empty
    end

    it 'returns an empty array' do
      expect(modifier_list.to_a).to be_empty
    end

    it 'returns an empty hash' do
      expect(modifier_list.to_h).to be_empty
    end
  end

  describe 'modifiers from a hash' do
    subject(:modifier_list) { described_class.new(:block_name, nil, enabled: true, theme: :green_islands, disabled: false) }

    it 'returns modifiers as a string' do
      expect(modifier_list.to_s).to eq 'block-name_enabled block-name_theme_green-islands'
    end

    it 'returns modifiers as an array' do
      expect(modifier_list.to_a).to match_array %w[block-name_enabled block-name_theme_green-islands]
    end

    it 'returns modifiers as a hash' do
      expect(modifier_list.to_h).to eql('enabled' => true, 'theme' => 'green-islands')
    end
  end

  describe 'modifiers from an array' do
    subject(:modifier_list) { described_class.new(:block_name, nil, [:enabled, theme: :green_islands, disabled: false]) }

    it 'returns modifiers as a string' do
      expect(modifier_list.to_s).to eq 'block-name_enabled block-name_theme_green-islands'
    end

    it 'returns modifiers as an array' do
      expect(modifier_list.to_a).to match_array %w[block-name_enabled block-name_theme_green-islands]
    end

    it 'returns modifiers as a hash' do
      expect(modifier_list.to_h).to eql('enabled' => true, 'theme' => 'green-islands')
    end
  end

  describe 'modifiers from a symbol' do
    subject(:modifier_list) { described_class.new(:block_name, :elem_name, :has_tail) }

    it 'returns modifiers as a string' do
      expect(modifier_list.to_s).to eq 'block-name__elem-name_has-tail'
    end

    it 'returns modifiers as an array' do
      expect(modifier_list.to_a).to match_array %w[block-name__elem-name_has-tail]
    end

    it 'returns modifiers as a hash' do
      expect(modifier_list.to_h).to eql('has-tail' => true)
    end
  end

  describe 'modifiers from a string' do
    subject(:modifier_list) { described_class.new(:block_name, :elem_name, 'Has-Tail') }

    it 'returns modifiers as a string' do
      expect(modifier_list.to_s).to eq 'block-name__elem-name_Has-Tail'
    end

    it 'returns modifiers as an array' do
      expect(modifier_list.to_a).to match_array %w[block-name__elem-name_Has-Tail]
    end

    it 'returns modifiers as a hash' do
      expect(modifier_list.to_h).to eql('Has-Tail' => true)
    end
  end
end

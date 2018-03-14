# frozen_string_literal: true

RSpec.describe Bemer::ModifierList do
  shared_examples 'modifier_list' do
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
  end

  context 'when transform_string_values is set to false' do
    before do
      Bemer.config.transform_string_values = false
    end

    include_examples 'modifier_list'

    describe 'modifiers from a string' do
      subject(:modifier_list) { described_class.new(:block_name, :elem_name, 'has_tail') }

      it 'returns modifiers as a string' do
        expect(modifier_list.to_s).to eq 'block-name__elem-name_has_tail'
      end

      it 'returns modifiers as an array' do
        expect(modifier_list.to_a).to match_array %w[block-name__elem-name_has_tail]
      end

      it 'returns modifiers as a hash' do
        expect(modifier_list.to_h).to eql('has_tail' => true)
      end
    end
  end

  context 'when transform_string_values is set to true' do
    before do
      Bemer.config.transform_string_values = true
    end

    include_examples 'modifier_list'

    describe 'modifiers from a string' do
      subject(:modifier_list) { described_class.new(:block_name, :elem_name, 'has_tail') }

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
  end
end

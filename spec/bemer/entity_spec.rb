# frozen_string_literal: true

RSpec.describe Bemer::Entity do
  subject(:entity) { described_class.new(:block, cls: 'class-1 class_2', class: [:class_3, 'class_4']) }

  describe '#cls' do
    it { expect(entity.cls).to match_array(%w[class-1 class_2 class-3 class_4]) }
  end

  context 'when a block' do
    subject(:block) { described_class.new(:block) }

    it { is_expected.to be_block }

    describe '#name' do
      it { expect(block.name).to eq 'block' }
    end

    describe '#bem_class' do
      it { expect(block.bem_class).to eq 'block' }
    end
  end

  context 'when an element' do
    subject(:elem) { described_class.new('', :elem) }

    it { is_expected.to be_element }

    describe '#name' do
      it { expect(elem.name).to eq '__elem' }
    end

    describe '#bem_class' do
      it { expect(elem.bem_class).to eq '' }
    end
  end
end

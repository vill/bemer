# frozen_string_literal: true

RSpec.describe Bemer::EntityBuilder do
  context 'when block name is missing' do
    let(:entity_builder) { described_class.new(nil, :elem) }

    describe '#attrs' do
      subject { entity_builder.attrs }

      it { is_expected.to be_empty }
    end
  end

  context 'when block name and elem name are missing' do
    let(:entity_builder) { described_class.new }

    describe '#attrs' do
      subject { entity_builder.attrs }

      it { is_expected.to be_empty }
    end
  end

  context 'when an entity is a block' do
    let(:entity_builder) { described_class.new(:block) }

    describe '#attrs' do
      subject(:attrs) { entity_builder.attrs }

      it { expect(attrs).to include(class: 'block') }
    end
  end

  context 'when an entity is an element' do
    let(:entity_builder) { described_class.new(:block, :elem) }

    describe '#attrs' do
      subject(:attrs) { entity_builder.attrs }

      it { expect(attrs).to include(class: 'block__elem') }
    end
  end
end

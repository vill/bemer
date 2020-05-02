# frozen_string_literal: true

RSpec.describe 'data_bem_for helper' do
  delegate :data_bem_for, to: :view

  context 'when a block and element have no name' do
    it { expect(data_bem_for).to be_empty }
  end

  context 'when only a block name is specified' do
    it { expect(data_bem_for(:block)).to include(class: 'block i-bem', 'data-bem': '{"block":{}}') }
    it { expect(data_bem_for(:block, mods: :enabled)).to include(class: 'block block_enabled i-bem', 'data-bem': '{"block":{}}') }
    it { expect(data_bem_for(:block, mix: { block1: :elem })).to include(class: 'block block1__elem i-bem', 'data-bem': '{"block":{}}') }
    it { expect(data_bem_for(:block, js: { key: :val })).to include(class: 'block i-bem', 'data-bem': '{"block":{"key":"val"}}') }
    it { expect(data_bem_for(:block, js: false)).to include(class: 'block') }

    ['', false].each do |elem|
      it { expect(data_bem_for(:block, elem)).to be_empty }
    end
  end

  context 'when only an element name is specified' do
    ['', nil, false].each do |block|
      it { expect(data_bem_for(block, :elem)).to be_empty }
    end
  end

  context 'when a name is specified for a block and element' do
    it { expect(data_bem_for(:block, :elem)).to include(class: 'block__elem i-bem', 'data-bem': '{"block__elem":{}}') }
    it { expect(data_bem_for(:block, :elem, mods: :enabled)).to include(class: 'block__elem block__elem_enabled i-bem', 'data-bem': '{"block__elem":{}}') }
    it { expect(data_bem_for(:block, :elem, mix: :block_2)).to include(class: 'block__elem block-2 i-bem', 'data-bem': '{"block__elem":{}}') }
    it { expect(data_bem_for(:block, :elem, js: { key: :val })).to include(class: 'block__elem i-bem', 'data-bem': '{"block__elem":{"key":"val"}}') }
    it { expect(data_bem_for(:block, :elem, js: false)).to include(class: 'block__elem') }
  end
end

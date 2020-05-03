# frozen_string_literal: true

RSpec.describe 'elem_tag helper' do
  delegate :elem_tag, to: :view

  context 'when the `default_element_tag` is set to `span`' do
    before do
      Bemer.config.default_element_tag = :span
    end

    it { expect(elem_tag(:block, :elem)).to have_empty_tag(:span, with: { class: 'block__elem' }, count: 1) }
  end

  context 'when the `element_name_separator` is set to `___`' do
    before do
      Bemer.config.element_name_separator = '___'
    end

    it { expect(elem_tag(:block, :elem)).to have_empty_tag(:div, with: { class: 'block___elem' }, count: 1) }
  end

  context 'when the `modifier_name_separator` is set to `--`' do
    before do
      Bemer.config.modifier_name_separator = '--'
    end

    it { expect(elem_tag(:block, :elem, mods: :enabled)).to have_empty_tag(:div, with: { class: 'block__elem block__elem--enabled' }, count: 1) }
  end

  context 'when the `modifier_value_separator` is set to `___`' do
    before do
      Bemer.config.modifier_value_separator = '___'
    end

    it { expect(elem_tag(:block, :elem, mods: { theme: :gray })).to have_empty_tag(:div, with: { class: 'block__elem block__elem_theme___gray' }, count: 1) }
  end

  # The bem parameter from the configuration does not affect the operation of elem_tag in any way.
  [true, false].each do |bem|
    context "when the `bem` is globally set to `#{bem}`" do
      before do
        Bemer.config.bem = bem
      end

      context 'when a block and element have no name' do
        it { expect(elem_tag).to(have_empty_tag(:div, count: 1)) { without_tag 'div[class]' } }
        it { expect(elem_tag(bem: true)).to(have_empty_tag(:div, count: 1)) { without_tag 'div[class]' } }
        it { expect(elem_tag(js: true)).to(have_empty_tag(:div, without: { class: 'i-bem' }, count: 1)) { without_tag 'div[data-bem]' } }

        ['', nil, false].repeated_permutation(2).each do |block, elem|
          it { expect(elem_tag(block, elem, bem: true)).to(have_empty_tag(:div, count: 1)) { without_tag 'div[class]' } }
          it { expect(elem_tag(block, elem, js: true)).to(have_empty_tag(:div, without: { class: 'i-bem' }, count: 1)) { without_tag 'div[data-bem]' } }
        end
      end

      context 'when only a block name is specified' do
        it { expect(elem_tag(:block, nil, bem: true)).to have_empty_tag(:div, with: { class: 'block' }, count: 1) }
        it { expect(elem_tag(:block, nil, js: true)).to have_empty_tag(:div, with: { class: 'block i-bem', 'data-bem': '{"block":{}}' }, count: 1) }

        ['', false].each do |elem|
          it { expect(elem_tag(:block, elem, bem: true)).to(have_empty_tag(:div, count: 1)) { without_tag 'div[class]' } }
          it { expect(elem_tag(:block, elem, js: true)).to(have_empty_tag(:div, without: { class: 'i-bem' }, count: 1)) { without_tag 'div[data-bem]' } }
        end
      end

      context 'when only an element name is specified' do
        ['', nil, false].each do |block|
          it { expect(elem_tag(block, :elem)).to(have_empty_tag(:div, count: 1)) { without_tag 'div[class]' } }
          it { expect(elem_tag(block, :elem, bem: true)).to(have_empty_tag(:div, count: 1)) { without_tag 'div[class]' } }
          it { expect(elem_tag(block, :elem, js: true)).to(have_empty_tag(:div, without: { class: 'i-bem' }, count: 1)) { without_tag 'div[data-bem]' } }
        end
      end

      context 'when a name is specified for a block and element' do
        # Entity name
        it { expect(elem_tag(:block_name, :elem_name)).to have_empty_tag(:div, with: { class: 'block-name__elem-name' }, count: 1) }
        it { expect(elem_tag('Block_Name', 'Elem_Name')).to have_empty_tag(:div, with: { class: 'Block_Name__Elem_Name' }, count: 1) }
        it { expect(elem_tag(:Block_Name, :Elem_Name)).to have_empty_tag(:div, with: { class: 'Block-Name__Elem-Name' }, count: 1) }
        it { expect(elem_tag('BlockName', 'ElemName')).to have_empty_tag(:div, with: { class: 'BlockName__ElemName' }, count: 1) }

        # bem parameter
        it { expect(elem_tag(:block, :elem, mix: :css_mixin, mods: :enabled, js: true, cls: :css_class)).to have_empty_tag(:div, with: { class: 'block__elem block__elem_enabled css-mixin css-class i-bem', 'data-bem': '{"block__elem":{}}' }, count: 1) }
        it { expect(elem_tag(:block, :elem, bem: true, mix: :css_mixin, mods: :enabled, js: true, cls: :css_class)).to have_empty_tag(:div, with: { class: 'block__elem block__elem_enabled css-mixin css-class i-bem', 'data-bem': '{"block__elem":{}}' }, count: 1) }
        it { expect(elem_tag(:block, :elem, bem: false, mix: :css_mixin, mods: :enabled, js: true, cls: :css_class)).to(have_empty_tag(:div, with: { class: 'css-class' }, without: { class: 'block__elem block__elem_enabled css-mixin i-bem' }, count: 1)) { without_tag 'div[data-bem]' } }

        # bem_cascade parameter
        it { expect(elem_tag(:block, :elem, bem_cascade: false)).to(have_empty_tag(:div, count: 1)) { without_tag 'div[class]' } }
        it { expect(elem_tag(:block, :elem, bem: true, bem_cascade: false)).to have_empty_tag(:div, with: { class: 'block__elem' }, count: 1) }
        it { expect(elem_tag(:block, :elem, bem: false, bem_cascade: true)).to(have_empty_tag(:div, count: 1)) { without_tag 'div[class]' } }

        # cls and class parameters
        it { expect(elem_tag(:block, :elem, cls: :css_class)).to have_empty_tag(:div, with: { class: 'block__elem css-class' }, count: 1) }
        it { expect(elem_tag(:block, :elem, class: :css_class)).to have_empty_tag(:div, with: { class: 'block__elem css-class' }, count: 1) }
        it { expect(elem_tag(:block, :elem, class: :css_class1, cls: :css_class2)).to have_empty_tag(:div, with: { class: 'block__elem css-class1 css-class2' }, count: 1) }
        it { expect(elem_tag(:block, :elem, class: 'css_class1', cls: 'css_class2')).to have_empty_tag(:div, with: { class: 'block__elem css_class1 css_class2' }, count: 1) }
        it { expect(elem_tag(:block, :elem, class: ['css_class1', :css_class2])).to have_empty_tag(:div, with: { class: 'block__elem css_class1 css-class2' }, count: 1) }
        it { expect(elem_tag(:block, :elem, cls: ['css_class1', :css_class2])).to have_empty_tag(:div, with: { class: 'block__elem css_class1 css-class2' }, count: 1) }

        # js parameter
        it { expect(elem_tag(:block, :elem, js: true)).to have_empty_tag(:div, with: { class: 'block__elem i-bem', 'data-bem': '{"block__elem":{}}' }, count: 1) }
        it { expect(elem_tag(:block, :elem, js: [1, 2])).to have_empty_tag(:div, with: { class: 'block__elem i-bem', 'data-bem': '{"block__elem":[1,2]}' }, count: 1) }
        it { expect(elem_tag(:block, :elem, js: { key: :val })).to have_empty_tag(:div, with: { class: 'block__elem i-bem', 'data-bem': '{"block__elem":{"key":"val"}}' }, count: 1) }

        # mix parameter
        it { expect(elem_tag(:block, :elem, mix: :css_mixin)).to have_empty_tag(:div, with: { class: 'block__elem css-mixin' }, count: 1) }
        it { expect(elem_tag(:block, :elem, mix: ['css_mixin', :block_name, block2: :elem])).to have_empty_tag(:div, with: { class: 'block__elem css_mixin block-name block2__elem' }, count: 1) }
        it { expect(elem_tag(:block, :elem, mix: { block_name: :elem })).to have_empty_tag(:div, with: { class: 'block__elem block-name__elem' }, count: 1) }
        it { expect(elem_tag(:block, :elem, mix: { block_name: :elem, js: true })).to have_empty_tag(:div, with: { class: 'block__elem block-name__elem i-bem', 'data-bem': '{"block-name__elem":{}}' }, count: 1) }
        it { expect(elem_tag(:block, :elem, js: true, mix: { block_1: :elem, js: { key: :val } })).to have_empty_tag(:div, with: { class: 'block__elem block-1__elem i-bem', 'data-bem': '{"block__elem":{},"block-1__elem":{"key":"val"}}' }, count: 1) }
        it { expect(elem_tag(:block, :elem, js: true, mix: { block: :elem, js: { key: :val } })).to have_empty_tag(:div, with: { class: 'block__elem i-bem', 'data-bem': '{"block__elem":{"key":"val"}}' }, count: 1) }
        it { expect(elem_tag(:block, :elem, mix: { block_name: :elem, mods: :enabled })).to have_empty_tag(:div, with: { class: 'block__elem block-name__elem block-name__elem_enabled' }, count: 1) }
        it { expect(elem_tag(:block, :elem, mix: [:mix, block_name: :elem, js: true])).to have_empty_tag(:div, with: { class: 'block__elem mix block-name__elem i-bem', 'data-bem': '{"block-name__elem":{}}' }, count: 1) }
        it { expect(elem_tag(:block, :elem, mix: [{ block_1: nil, mods: :enabled, js: { key: :val } }, { block_name: :elem, js: true }])).to have_empty_tag(:div, with: { class: 'block__elem block-1 block-1_enabled block-name__elem i-bem', 'data-bem': '{"block-1":{"key":"val"},"block-name__elem":{}}' }, count: 1) }
        it { expect(elem_tag(:block, :elem, mix: [:block_1, block2: %i[elem1 elem2], js: true])).to have_empty_tag(:div, with: { class: 'block__elem block-1 block2__elem1 block2__elem2 i-bem', 'data-bem': '{"block2__elem1":{},"block2__elem2":{}}' }, count: 1) }
        it { expect(elem_tag(:block, :elem, mix: { block2: %i[elem1 elem2], js: true })).to have_empty_tag(:div, with: { class: 'block__elem block2__elem1 block2__elem2 i-bem', 'data-bem': '{"block2__elem1":{},"block2__elem2":{}}' }, count: 1) }

        # mods parameter
        it { expect(elem_tag(:block, :elem, mods: :enabled)).to have_empty_tag(:div, with: { class: 'block__elem block__elem_enabled' }, count: 1) }
        it { expect(elem_tag(:block, :elem, mods: { enabled: true })).to have_empty_tag(:div, with: { class: 'block__elem block__elem_enabled' }, count: 1) }
        it { expect(elem_tag(:block, :elem, mods: { enabled: 'true' })).to have_empty_tag(:div, with: { class: 'block__elem block__elem_enabled_true' }, count: 1) }
        it { expect(elem_tag(:block, :elem, mods: { enabled: false })).to have_empty_tag(:div, with: { class: 'block__elem' }, without: { class: 'block__elem_enabled' }, count: 1) }
        it { expect(elem_tag(:block, :elem, mods: { enabled: 'false' })).to have_empty_tag(:div, with: { class: 'block__elem block__elem_enabled_false' }, count: 1) }
        it { expect(elem_tag(:block, :elem, mods: { enabled: '' })).to have_empty_tag(:div, with: { class: 'block__elem' }, without: { class: 'block__elem_enabled' }, count: 1) }
        it { expect(elem_tag(:block, :elem, mods: { enabled: nil })).to have_empty_tag(:div, with: { class: 'block__elem' }, without: { class: 'block__elem_enabled' }, count: 1) }
        it { expect(elem_tag(:block, :elem, mods: { enabled: 'nil' })).to have_empty_tag(:div, with: { class: 'block__elem block__elem_enabled_nil' }, count: 1) }
        it { expect(elem_tag(:block, :elem, mods: [:enabled, size: :small])).to have_empty_tag(:div, with: { class: 'block__elem block__elem_enabled block__elem_size_small' }, count: 1) }
        it { expect(elem_tag(:block, :elem, mods: [:enabled, %i[size small], %i[size large]])).to have_empty_tag(:div, with: { class: 'block__elem block__elem_enabled block__elem_size_large' }, count: 1) }

        # tag parameter
        it { expect(elem_tag(:block, :elem, tag: :span)).to have_empty_tag(:span, with: { class: 'block__elem' }, count: 1) }
        it { expect(elem_tag(:block, :elem, tag: '', content: 'Content')).to eq 'Content' }
        it { expect(elem_tag(:block, :elem, tag: '', content: '')).to eq '' }
        # got: nil
        # it { expect(elem_tag(:block, :elem, tag: '')).to eq '' }
        it { expect(elem_tag(:block, :elem, tag: false, content: 'Content')).to eq 'Content' }
        it { expect(elem_tag(:block, :elem, tag: false, content: '')).to eq '' }
        # got: nil
        # it { expect(elem_tag(:block, :elem, tag: false)).to eq '' }
        it { expect(elem_tag(:block, :elem, tag: nil, content: 'Content')).to have_tag(:div, with: { class: 'block__elem' }, text: 'Content', count: 1) }

        # attributes
        it { expect(elem_tag(:block, :elem, data: { key: :val })).to have_empty_tag(:div, with: { class: 'block__elem', 'data-key': 'val' }, count: 1) }
        it { expect(elem_tag(:block, :elem, 'data-key': :val)).to have_empty_tag(:div, with: { class: 'block__elem', 'data-key': 'val' }, count: 1) }
        it { expect(elem_tag(:block, :elem, data: { key: :val }, 'data-key2': :val)).to have_empty_tag(:div, with: { class: 'block__elem', 'data-key': 'val', 'data-key2': 'val' }, count: 1) }
        it { expect(elem_tag(:block, :elem, tag: :a, href: '#')).to have_empty_tag(:a, with: { class: 'block__elem', href: '#' }, count: 1) }

        # content parameter
        it { expect(elem_tag(:block, :elem, content: 'Content')).to have_tag(:div, with: { class: 'block__elem' }, text: 'Content', count: 1) }

        it do # rubocop:disable RSpec/ExampleLength
          html = elem_tag :block, :elem do
            elem_tag :block, :elem1, content: 'Content' do
              '<div></div>'.html_safe
            end
          end

          expect(html).to have_tag(:div, with: { class: 'block__elem' }, count: 1) do
            with_tag :div, with: { class: 'block__elem1' }, count: 1 do
              with_tag :div, without: { class: 'block__elem1' }, blank: true, count: 1
            end
          end
        end
      end
    end
  end
end

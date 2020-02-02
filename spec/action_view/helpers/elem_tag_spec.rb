# frozen_string_literal: true

RSpec.describe 'elem_tag helper' do
  delegate :elem_tag, to: :view

  subject(:html_entity_tree_builder_method) { view.method(:elem_tag) }

  context 'when the `default_element_tag` is set to `span`' do
    before do
      Bemer.config.default_element_tag = :span
    end

    it_behaves_like 'an HTML entity tree builder method', :block, :elem, '<span class="block__elem"></span>'
  end

  context 'when the `element_name_separator` is set to `___`' do
    before do
      Bemer.config.element_name_separator = '___'
    end

    it_behaves_like 'an HTML entity tree builder method', :block, :elem, '<div class="block___elem"></div>'
  end

  context 'when the `modifier_name_separator` is set to `--`' do
    before do
      Bemer.config.modifier_name_separator = '--'
    end

    it_behaves_like 'an HTML entity tree builder method', :block, :elem, { mods: :enabled }, '<div class="block__elem block__elem--enabled"></div>'
  end

  context 'when the `modifier_value_separator` is set to `___`' do
    before do
      Bemer.config.modifier_value_separator = '___'
    end

    it_behaves_like 'an HTML entity tree builder method', :block, :elem, { mods: { theme: :gray } }, '<div class="block__elem block__elem_theme___gray"></div>'
  end

  # The bem parameter from the configuration does not affect the operation of elem_tag in any way.
  [true, false].each do |bem|
    context "when the `bem` is globally set to `#{bem}`" do
      before do
        Bemer.config.bem = bem
      end

      context 'when a block and element have no name' do
        it_behaves_like 'an HTML entity tree builder method', '<div></div>'
        it_behaves_like 'an HTML entity tree builder method', { bem: true }, '<div></div>'
        it_behaves_like 'an HTML entity tree builder method', { js: true }, '<div></div>'

        ['', nil, false].repeated_permutation(2).each do |block, elem|
          it_behaves_like 'an HTML entity tree builder method', block, elem, { bem: true }, '<div></div>'
          it_behaves_like 'an HTML entity tree builder method', block, elem, { js: true }, '<div></div>'
        end
      end

      context 'when only a block name is specified' do
        it_behaves_like 'an HTML entity tree builder method', :block, nil, { bem: true }, '<div class="block"></div>'
        it_behaves_like 'an HTML entity tree builder method', :block, nil, { js: true }, '<div class="block i-bem" data-bem="{&quot;block&quot;:{}}"></div>'

        ['', false].each do |elem|
          it_behaves_like 'an HTML entity tree builder method', :block, elem, { js: true }, '<div></div>'
          it_behaves_like 'an HTML entity tree builder method', :block, elem, { bem: true }, '<div></div>'
        end
      end

      context 'when only an element name is specified' do
        ['', nil, false].each do |block|
          it_behaves_like 'an HTML entity tree builder method', block, :elem, '<div></div>'
          it_behaves_like 'an HTML entity tree builder method', block, :elem, { bem: true }, '<div></div>'
          it_behaves_like 'an HTML entity tree builder method', block, :elem, { js: true }, '<div></div>'
        end
      end

      context 'when a name is specified for a block and element' do
        # Entity name
        it_behaves_like 'an HTML entity tree builder method', :block_name, :elem_name, '<div class="block-name__elem-name"></div>'
        it_behaves_like 'an HTML entity tree builder method', 'Block_Name', 'Elem_Name', '<div class="Block_Name__Elem_Name"></div>'
        it_behaves_like 'an HTML entity tree builder method', :Block_Name, :Elem_Name, '<div class="Block-Name__Elem-Name"></div>'
        it_behaves_like 'an HTML entity tree builder method', 'BlockName', 'ElemName', '<div class="BlockName__ElemName"></div>'

        # bem parameter
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { mix: :css_mixin, mods: :enabled, js: true, cls: :css_class }, '<div class="block__elem block__elem_enabled css-mixin css-class i-bem" data-bem="{&quot;block__elem&quot;:{}}"></div>'
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { bem: true, mix: :css_mixin, mods: :enabled, js: true, cls: :css_class }, '<div class="block__elem block__elem_enabled css-mixin css-class i-bem" data-bem="{&quot;block__elem&quot;:{}}"></div>'
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { bem: false, mix: :css_mixin, mods: :enabled, js: true, cls: :css_class }, '<div class="css-class"></div>'

        # bem_cascade parameter
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { bem_cascade: false }, '<div></div>'
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { bem: true, bem_cascade: false }, '<div class="block__elem"></div>'
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { bem: false, bem_cascade: true }, '<div></div>'

        # cls and class parameters
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { cls: :css_class }, '<div class="block__elem css-class"></div>'
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { class: :css_class }, '<div class="block__elem css-class"></div>'
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { class: :css_class1, cls: :css_class2 }, '<div class="block__elem css-class1 css-class2"></div>'
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { class: 'css_class1', cls: 'css_class2' }, '<div class="block__elem css_class1 css_class2"></div>'
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { class: ['css_class1', :css_class2] }, '<div class="block__elem css_class1 css-class2"></div>'
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { cls: ['css_class1', :css_class2] }, '<div class="block__elem css_class1 css-class2"></div>'

        # js parameter
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { js: true }, '<div class="block__elem i-bem" data-bem="{&quot;block__elem&quot;:{}}"></div>'
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { js: [1, 2] }, '<div class="block__elem i-bem" data-bem="{&quot;block__elem&quot;:[1,2]}"></div>'
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { js: { key: :val } }, '<div class="block__elem i-bem" data-bem="{&quot;block__elem&quot;:{&quot;key&quot;:&quot;val&quot;}}"></div>'

        # mix parameter
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { mix: :css_mixin }, '<div class="block__elem css-mixin"></div>'
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { mix: ['css_mixin', :block_name, block2: :elem] }, '<div class="block__elem css_mixin block-name block2__elem"></div>'
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { mix: { block_name: :elem } }, '<div class="block__elem block-name__elem"></div>'

        # mods parameter
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { mods: :enabled }, '<div class="block__elem block__elem_enabled"></div>'
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { mods: { enabled: true } }, '<div class="block__elem block__elem_enabled"></div>'
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { mods: { enabled: 'true' } }, '<div class="block__elem block__elem_enabled_true"></div>'
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { mods: { enabled: false } }, '<div class="block__elem"></div>'
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { mods: { enabled: 'false' } }, '<div class="block__elem block__elem_enabled_false"></div>'
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { mods: { enabled: '' } }, '<div class="block__elem"></div>'
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { mods: { enabled: nil } }, '<div class="block__elem"></div>'
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { mods: { enabled: 'nil' } }, '<div class="block__elem block__elem_enabled_nil"></div>'
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { mods: [:enabled, size: :small] }, '<div class="block__elem block__elem_enabled block__elem_size_small"></div>'
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { mods: [:enabled, %i[size small], %i[size large]] }, '<div class="block__elem block__elem_enabled block__elem_size_large"></div>'

        # tag parameter
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { tag: :span }, '<span class="block__elem"></span>'
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { tag: '', content: 'Content' }, 'Content'
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { tag: false, content: 'Content' }, 'Content'
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { tag: nil, content: 'Content' }, '<div class="block__elem">Content</div>'

        # attributes
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { data: { key: :val } }, '<div data-key="val" class="block__elem"></div>'
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { 'data-key': :val }, '<div data-key="val" class="block__elem"></div>'
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { data: { key: :val }, 'data-key2': :val }, '<div data-key="val" data-key2="val" class="block__elem"></div>'
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { tag: :a, href: '#' }, '<a href="#" class="block__elem"></a>'

        # content parameter
        it_behaves_like 'an HTML entity tree builder method', :block, :elem, { content: 'Content' }, '<div class="block__elem">Content</div>'

        context 'when content is passed using a block' do # rubocop:disable RSpec/NestedGroups
          let(:content) do
            proc do
              elem_tag :block, :elem1, content: 'Content' do
                '<div></div>'.html_safe
              end
            end
          end

          let(:html) do
            <<-HTML
              <div class="block__elem">
                <div class="block__elem1">
                  <div></div>
                </div>
              </div>
            HTML
          end

          it_behaves_like 'an HTML entity tree builder method', :block, :elem
        end
      end
    end
  end
end

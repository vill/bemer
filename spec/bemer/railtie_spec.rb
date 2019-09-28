# frozen_string_literal: true

RSpec.describe Bemer::Railtie do
  def view_paths_for(klass)
    klass.view_paths.map { |view_path| view_path.instance_variable_get(:@path) }
  end

  def find_initializer(name)
    described_class.initializers.find { |initializer| initializer.name.eql?(name) }
  end

  let(:assets_path_initializer_name) { ::Rails::VERSION::MAJOR >= 5 ? :append_assets_path : :load_config_initializers }

  describe '.assets_path_initializer' do
    it { expect(described_class.assets_path_initializer).to be(assets_path_initializer_name) }
  end

  describe '.eager_load_namespaces' do
    it { expect(described_class.config.eager_load_namespaces).to include(Bemer) if described_class.config.respond_to?(:eager_load_namespaces) }
  end

  describe 'view paths' do
    let(:view_path)             { Rails.root.join('app', 'views').to_s }
    let(:bemer_view_paths)      { [Bemer.path, *Bemer.paths].map(&:to_s) }
    let(:mailer_view_paths)     { view_paths_for(ActionMailer::Base) }
    let(:controller_view_paths) { view_paths_for(ActionController::Base) }

    it { expect(controller_view_paths).to start_with(*bemer_view_paths, view_path) }
    it { expect(mailer_view_paths).to start_with(*bemer_view_paths, view_path) }
  end

  describe '.initializers' do
    let(:initializer_names) { %w[bemer.helpers bemer.prepend_asset_paths bemer.assets_precompile] }

    it { expect(described_class.initializers.map(&:name)).to match_array(initializer_names) }
  end

  describe 'bemer.helpers initializer' do
    subject(:initializer) { find_initializer('bemer.helpers') }

    let(:action_view) { ActionView::Base.new }

    helper_methods = %i[
      block_tag elem_tag bem_mix bem_mods render_component
      refine_component define_templates define_component
      component_pack component_asset_path component_partial_path
    ]

    it { expect(initializer.after).to be_nil }
    it { is_expected.not_to be_belongs_to(:all) }

    helper_methods.each do |helper_method|
      it { expect(action_view).to be_respond_to(helper_method) }
    end
  end

  describe 'bemer.prepend_asset_paths initializer' do
    subject(:initializer) { find_initializer('bemer.prepend_asset_paths') }

    let(:app) { Dummy::Application }

    let(:asset_paths) do
      assets_root      = Rails.root.join('app', 'assets')
      javascripts_path = assets_root.join('javascripts').to_s
      stylesheets_path = assets_root.join('stylesheets').to_s

      [Bemer.path.to_s, *Bemer.asset_paths, javascripts_path, stylesheets_path]
    end

    it { expect(initializer.after).to eql(assets_path_initializer_name) }
    it { is_expected.to be_belongs_to(:all) }
    it { expect(app.config.assets.paths).to start_with(*asset_paths) if defined?(::Sprockets) }

    context 'when prepend_asset_paths is set to true' do
      before { Bemer.config.prepend_asset_paths = true }

      it { expect(initializer.run(app).uniq).to start_with(*asset_paths) if defined?(::Sprockets) }
      it { expect(initializer.run(app)).to be_nil unless defined?(::Sprockets) }
    end

    context 'when prepend_asset_paths is set to false' do
      before { Bemer.config.prepend_asset_paths = false }

      it { expect(initializer.run(app)).to be_nil }
    end
  end

  describe 'bemer.assets_precompile initializer' do
    subject(:initializer) { find_initializer('bemer.assets_precompile') }

    it { expect(initializer.after).to be :load_config_initializers }
    it { is_expected.to be_belongs_to(:all) }
    it { expect(Rails.application.config.assets.precompile[0].class).to be(Bemer::AssetMatcher) if ::Rails::VERSION::MAJOR < 4 && defined?(::Sprockets) }
  end
end

# Bemer

1. Build reusable UI components for Ruby on Rails applications.
1. Develop Ruby on Rails applications using the `BEM` methodology.

**IMPORTANT**. *Using the `BEM` methodology is optional.*

Additional resources:

1. Habr article in Russian - [Переиспользуемые UI компоненты в приложениях на Ruby on Rails](https://habrahabr.ru/post/352938/).
1. [`bemer-simple_form`](https://github.com/vill/bemer-simple_form) - Add the `BEM` methodology to your `SimpleForm` forms.
1. [`bemer-bootstrap`](https://github.com/vill/bemer-bootstrap) - Reusable UI components of `Bootstrap`.
1. [Ruby on Rails application](https://github.com/vill/bemer-example) using `bemer` and [`bemer-bootstrap`](https://github.com/vill/bemer-bootstrap).

## Installation

Add it to your Gemfile:

```ruby
gem 'bemer'
```

Run the following command to install it:

    $ bundle

## Configuration

See [configuration documentation](docs/%D0%9A%D0%BE%D0%BD%D1%84%D0%B8%D0%B3%D1%83%D1%80%D0%B0%D1%86%D0%B8%D1%8F.md) for details.

```ruby
# config/initializers/bemer.rb

Bemer.setup do |config|
  config.bem                     = true
  config.modifier_name_separator = '--'
  config.path                    = 'app/frontend/components' # or Webpacker.config.source_path
  # config.default_path_prefix     = lambda { |path, view|
  #   view.controller.class.name.split('::')[0].underscore
  # }
end
```

## Integrations
### Webpacker

```yml
# config/webpacker.yml

default: &default
  source_path: app/frontend/components
  source_entry_path: ../packs
  public_output_path: frontend/assets
  # ...

development:
  <<: *default
  # ...

test:
  <<: *default
  # ...

production:
  <<: *default
  # ...
```
#### File naming and folder structure
See [file naming and folder structure documentation](docs/%D0%A4%D0%B0%D0%B8%CC%86%D0%BB%D0%BE%D0%B2%D0%B0%D1%8F-%D1%81%D1%82%D1%80%D1%83%D0%BA%D1%82%D1%83%D1%80%D0%B0.md) for details.

```
app/
  ├── frontend/
  |     ├── components/
  |     |     ├── common/
  |     |     |     ├── carousel/
  |     |     |     |     ├── index.slim
  |     |     |     |     ├── index.bemhtml.slim
  |     |     |     |     ├── index.js
  |     |     |     |     ├── index.scss
  |     |     |     |     └── ...
  |     |     |     ├── form/
  |     |     |     |     ├── error_messages_elem/
  |     |     |     |     |     ├── index.slim
  |     |     |     |     |     ├── index.js
  |     |     |     |     |     ├── index.scss
  |     |     |     |     |     └── ...
  |     |     |     |     ├── locales/
  |     |     |     |     |     ├── en.yml
  |     |     |     |     |     └── ...
  |     |     |     |     ├── index.slim
  |     |     |     |     ├── base.rb
  |     |     |     |     ├── index.js
  |     |     |     |     ├── index.scss
  |     |     |     |     └── ...
  |     |     |     └── ...
  |     |     ├── admin_panel/
  |     |     |     └── ...
  |     |     ├── landing/
  |     |     |     └── ...
  |     |     ├── user_panel/
  |     |     |     └── ...
  |     |     └── ...
  |     ├── packs/
  |     |     ├── admin_panel/
  |     |     |     ├── application.js
  |     |     |     └── ...
  |     |     ├── landing/
  |     |     |     ├── application.js
  |     |     |     └── ...
  |     |     ├── user_panel/
  |     |     |     ├── application.js
  |     |     |     └── ...
  |     |     └── ...
  |     └── ...
  └── ...
```

### Sprockets

You do not need to do anything, but add additional assets to the asset load path if necessary:

```ruby
# config/initializers/bemer.rb

Bemer.setup do |config|
  config.asset_paths << Rails.root.join('some/asset/path')
end
```

### File naming and folder structure
See [file naming and folder structure documentation](docs/%D0%A4%D0%B0%D0%B8%CC%86%D0%BB%D0%BE%D0%B2%D0%B0%D1%8F-%D1%81%D1%82%D1%80%D1%83%D0%BA%D1%82%D1%83%D1%80%D0%B0.md) for details.

```
app/
  ├── assets/
  |     ├── javascripts/
  |     |     ├── admin_panel/
  |     |     |     ├── application.js
  |     |     |     └── ...
  |     |     ├── landing/
  |     |     |     ├── application.js
  |     |     |     └── ...
  |     |     ├── user_panel/
  |     |     |     ├── application.js
  |     |     |     └── ...
  |     |     └── ...
  |     ├── stylesheets/
  |     |     ├── admin_panel/
  |     |     |     ├── application.scss
  |     |     |     └── ...
  |     |     ├── landing/
  |     |     |     ├── application.scss
  |     |     |     └── ...
  |     |     ├── user_panel/
  |     |     |     ├── application.scss
  |     |     |     └── ...
  |     |     └── ...
  |     └── ...
  ├── frontend/
  |     ├── components/
  |     |     ├── common/
  |     |     |     ├── carousel/
  |     |     |     |     ├── index.slim
  |     |     |     |     ├── index.bemhtml.slim
  |     |     |     |     ├── index.js
  |     |     |     |     ├── index.scss
  |     |     |     |     └── ...
  |     |     |     ├── form/
  |     |     |     |     ├── error_messages_elem/
  |     |     |     |     |     ├── index.slim
  |     |     |     |     |     ├── index.js
  |     |     |     |     |     ├── index.scss
  |     |     |     |     |     └── ...
  |     |     |     |     ├── locales/
  |     |     |     |     |     ├── en.yml
  |     |     |     |     |     └── ...
  |     |     |     |     ├── index.slim
  |     |     |     |     ├── base.rb
  |     |     |     |     ├── index.js
  |     |     |     |     ├── index.scss
  |     |     |     |     └── ...
  |     |     |     └── ...
  |     |     ├── admin_panel/
  |     |     |     └── ...
  |     |     ├── landing/
  |     |     |     └── ...
  |     |     ├── user_panel/
  |     |     |     └── ...
  |     |     └── ...
  |     └── ...
  └── ...
```

## Usage

### Component to which `BEMHTML` templates cannot be applied

HTML structure of the [Carousel component from Bootstrap](https://getbootstrap.com/docs/4.3/components/carousel/#with-indicators):

```slim
/ app/frontend/components/common/carousel/index.slim

.carousel.slide data-ride="carousel" class=local_assigns[:cls]
  ol.carousel-indicators
    - image_urls.size.times do |i|
      li data-target=".carousel" class=(:active if i.zero?) data-slide-to=i
  .carousel-inner
    - image_urls.each_with_index do |image_url, i|
      .carousel-item class=(:active if i.zero?)
        = image_tag image_url, class: 'd-block w-100'
  a.carousel-control-prev data-slide="prev" data-target='.carousel' role="button"
    span.carousel-control-prev-icon aria-hidden="true"
    span.sr-only Previous
  a.carousel-control-next data-slide="next" data-target='.carousel' role="button"
    span.carousel-control-next-icon aria-hidden="true"
    span.sr-only Next
```
[Rendering](docs/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-render_component.md) the `carousel` component in any view or [other UI components](docs/%D0%A1%D0%BE%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-%D0%B8-%D0%B8%D1%81%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5-UI-%D0%BA%D0%BE%D0%BC%D0%BF%D0%BE%D0%BD%D0%B5%D0%BD%D1%82.md):
```slim
= render_component :carousel, prefix: :common, image_urls: image_urls, cls: 'carousel-fade'
```

### Component to which `BEMHTML` templates can be applied

Tree structure of the [Carousel component from Bootstrap](https://getbootstrap.com/docs/4.3/components/carousel/#with-indicators):

```slim
/ app/frontend/components/common/carousel/index.slim

= define_component do |component|
  = component.block :carousel, 'data-ride': :carousel, 'data-interval': false, cls: :slide do |carousel|
    = carousel.elem :indicators, tag: :ol, cls: 'carousel-indicators'
      - image_urls.size.times do |i|
        = carousel.elem :indicator, tag: :li, 'data-slide-to': i, mods: (:active if i.zero?), 'data-target': '.carousel'
    = carousel.elem :inner, cls: 'carousel-inner'
      - image_urls.each_with_index do |image_url, i|
        = carousel.elem :item, cls: 'carousel-item', mods: (:active if i.zero?)
          = carousel.elem :image, tag: :img, cls: 'd-block w-100', src: image_url
    = carousel.elem :control_prev, tag: :a, cls: 'carousel-control-prev', 'data-slide': :prev, role: :button, 'data-target': '.carousel'
      span.carousel-control-prev-icon aria-hidden="true"
      span.sr-only Previous
    = carousel.elem :control_next, tag: :a, cls: 'carousel-control-next', 'data-slide': :next, role: :button, 'data-target': '.carousel'
      span.carousel-control-next-icon aria-hidden="true"
      span.sr-only Next
```

[Default template](docs/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-define_templates.md):
```slim
/ app/frontend/components/common/carousel/index.bemhtml.slim

= define_templates do |template|
  = template.elem(mods: :active).add_cls :active
```

[Rendering](docs/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-render_component.md) the `carousel` component in any view or [other UI components](docs/%D0%A1%D0%BE%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-%D0%B8-%D0%B8%D1%81%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5-UI-%D0%BA%D0%BE%D0%BC%D0%BF%D0%BE%D0%BD%D0%B5%D0%BD%D1%82.md) using [`BEMHTML`](docs/BEMHTML.md) [templates](docs/%D0%A8%D0%B0%D0%B1%D0%BB%D0%BE%D0%BD%D1%8B.md):
```slim
= render_component :carousel, prefix: :common, image_urls: image_urls do |template|
  = template.block(:carousel).add_mix :carousel_fade
```

## Documentation in Russian

1. [File naming and folder structure](docs/%D0%A4%D0%B0%D0%B8%CC%86%D0%BB%D0%BE%D0%B2%D0%B0%D1%8F-%D1%81%D1%82%D1%80%D1%83%D0%BA%D1%82%D1%83%D1%80%D0%B0.md)
1. [Configuration](docs/%D0%9A%D0%BE%D0%BD%D1%84%D0%B8%D0%B3%D1%83%D1%80%D0%B0%D1%86%D0%B8%D1%8F.md)
1. [Creating and using UI components](docs/%D0%A1%D0%BE%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-%D0%B8-%D0%B8%D1%81%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5-UI-%D0%BA%D0%BE%D0%BC%D0%BF%D0%BE%D0%BD%D0%B5%D0%BD%D1%82.md)
1. Helpers for UI components
    1. [`define_component`](docs/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-define_component.md)
    1. [`define_templates`](docs/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-define_templates.md)
    1. [`render_component`](docs/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-render_component.md)
    1. [`refine_component`](docs/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-refine_component.md)
    1. [`component_pack`](docs/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-component_pack.md)
    1. [`component_asset_path`](docs/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-component_asset_path.md)
    1. [`component_partial_path`](docs/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-component_partial_path.md)
1. Additional helpers for the BEM methodology
    1. [`bem_attrs_for`](docs/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-bem_attrs_for.md)
    1. [`bem_mix`](docs/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-bem_mix.md)
    1. [`bem_mods`](docs/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-bem_mods.md)
    1. [`block_tag`](docs/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-block_tag.md)
    1. [`elem_tag`](docs/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-elem_tag.md)
1. [BEMHTML](docs/BEMHTML.md)
    1. [Templates](docs/%D0%A8%D0%B0%D0%B1%D0%BB%D0%BE%D0%BD%D1%8B.md)
    1. [Node](docs/%D0%9A%D0%BE%D0%BD%D1%82%D0%B5%D0%BA%D1%81%D1%82-%D1%83%D0%B7%D0%BB%D0%B0.md)
    1. [Predicates](docs/%D0%9F%D1%80%D0%B5%D0%B4%D0%B8%D0%BA%D0%B0%D1%82%D1%8B.md)
    1. [Modes](docs/%D0%A0%D0%B5%D0%B6%D0%B8%D0%BC%D1%8B.md)

## Links

1. BEM methodology - https://bem.info/methodology/
1. Minimal stack for coding client-side JavaScript and templating - https://github.com/bem/bem-core
1. Declarative template engine for the browser and server with regular JS syntax - https://github.com/bem/bem-xjst
1. BEM Forum - https://bem.info/forum/

## License

Copyright (c) 2017-2023 Alexander Grigorev. See [LICENSE.txt](LICENSE.txt) for further details.

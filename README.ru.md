# Bemer

**ВАЖНО**. *Для работы с UI компонентами не обязательно использовать методологию БЭМ.*

1. Позволяет создавать переиспользуемые UI компоненты для приложений на Ruby on Rails.
1. Предоставляет функционал для разработки приложений на Ruby on Rails с использованием методологии БЭМ.

## Дополнительно

1. Статья на Хабре - [Переиспользуемые UI компоненты в приложениях на Ruby on Rails](https://habrahabr.ru/post/352938/).
1. [`bemer-simple_form`](https://github.com/vill/bemer-simple_form) - Использование соглашений из БЭМ методологии в формах `SimpleForm`.
1. [`bemer-bootstrap`](https://github.com/vill/bemer-bootstrap) - переиспользуемые компоненты Bootstrap v3.
1. [Пример приложения](https://github.com/vill/bemer-example) с использованием `bemer` и [`bemer-bootstrap`](https://github.com/vill/bemer-bootstrap).

## Установка

Добавить в `Gemfile`:

```ruby
gem 'bemer'
```

Выполнить в терминале команду:

    $ bundle

## Использование

### Конфигурация

[Конфигурация](docs/%D0%9A%D0%BE%D0%BD%D1%84%D0%B8%D0%B3%D1%83%D1%80%D0%B0%D1%86%D0%B8%D1%8F.md) для `Bemer`:

```ruby
# config/initializers/bemer.rb

Bemer.setup do |config|
  config.bem                     = true
  config.modifier_name_separator = '--'
  config.path                    = 'app/frontend/components' # или Webpacker.config.source_path
  # config.default_path_prefix     = lambda { |path, view|
  #   view.controller.class.name.split('::')[0].underscore
  # }
end
```

Если используется [`Webpacker`](https://github.com/rails/webpacker):

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

### Файловая структура

Пример [файловой структуры](docs/%D0%A4%D0%B0%D0%B8%CC%86%D0%BB%D0%BE%D0%B2%D0%B0%D1%8F-%D1%81%D1%82%D1%80%D1%83%D0%BA%D1%82%D1%83%D1%80%D0%B0.md) при использовании [`Sprockets`](https://github.com/rails/sprockets-rails):
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
Пример [файловой структуры](docs/%D0%A4%D0%B0%D0%B8%CC%86%D0%BB%D0%BE%D0%B2%D0%B0%D1%8F-%D1%81%D1%82%D1%80%D1%83%D0%BA%D1%82%D1%83%D1%80%D0%B0.md) при использовании [`Webpacker`](https://github.com/rails/webpacker):
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
### Создание `HTML` структуры компонента

#### Простой компонент
Структура компонента [Сarousel из Bootstrap](https://getbootstrap.com/docs/4.3/components/carousel/#with-indicators):

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
    span.sr-only Предыдущий
  a.carousel-control-next data-slide="next" data-target='.carousel' role="button"
    span.carousel-control-next-icon aria-hidden="true"
    span.sr-only Следующий
```
[Вызов компонента](docs/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-render_component.md) `carousel` в любом представлении или в [других компонентах](docs/%D0%A1%D0%BE%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-%D0%B8-%D0%B8%D1%81%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5-UI-%D0%BA%D0%BE%D0%BC%D0%BF%D0%BE%D0%BD%D0%B5%D0%BD%D1%82.md):
```slim
= render_component :carousel, prefix: :common, image_urls: image_urls, cls: 'carousel-fade'
```

#### Компонент к которому можно применять `BEMHTML` шаблоны

Структура компонента [Сarousel из Bootstrap](https://getbootstrap.com/docs/4.3/components/carousel/#with-indicators):

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
      span.sr-only Предыдущий
    = carousel.elem :control_next, tag: :a, cls: 'carousel-control-next', 'data-slide': :next, role: :button, 'data-target': '.carousel'
      span.carousel-control-next-icon aria-hidden="true"
      span.sr-only Следующий
```

[Шаблон по умолчанию](docs/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-define_templates.md):
```slim
/ app/frontend/components/common/carousel/index.bemhtml.slim

= define_templates do |template|
  = template.elem(mods: :active).add_cls :active
```

[Вызов компонента](docs/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-render_component.md) `carousel` в любом представлении или в [других компонентах](docs/%D0%A1%D0%BE%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-%D0%B8-%D0%B8%D1%81%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5-UI-%D0%BA%D0%BE%D0%BC%D0%BF%D0%BE%D0%BD%D0%B5%D0%BD%D1%82.md) с применением [`BEMHTML`](docs/BEMHTML.md) [шаблонов](docs/%D0%A8%D0%B0%D0%B1%D0%BB%D0%BE%D0%BD%D1%8B.md):
```slim
= render_component :carousel, prefix: :common, image_urls: image_urls do |template|
  = template.block(:carousel).add_mix :carousel_fade
```

## Документация

1. [Файловая структура](docs/%D0%A4%D0%B0%D0%B8%CC%86%D0%BB%D0%BE%D0%B2%D0%B0%D1%8F-%D1%81%D1%82%D1%80%D1%83%D0%BA%D1%82%D1%83%D1%80%D0%B0.md)
1. [Конфигурация](docs/%D0%9A%D0%BE%D0%BD%D1%84%D0%B8%D0%B3%D1%83%D1%80%D0%B0%D1%86%D0%B8%D1%8F.md)
1. [Создание и использование UI компонент](docs/%D0%A1%D0%BE%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-%D0%B8-%D0%B8%D1%81%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5-UI-%D0%BA%D0%BE%D0%BC%D0%BF%D0%BE%D0%BD%D0%B5%D0%BD%D1%82.md)
1. Хелперы для работы с компонентами
    1. [`define_component`](docs/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-define_component.md)
    1. [`define_templates`](docs/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-define_templates.md)
    1. [`render_component`](docs/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-render_component.md)
    1. [`refine_component`](docs/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-refine_component.md)
    1. [`component_pack`](docs/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-component_pack.md)
    1. [`component_asset_path`](docs/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-component_asset_path.md)
    1. [`component_partial_path`](docs/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-component_partial_path.md)
1. Дополнительные хелперы для БЭМ методологии
    1. [`bem_attrs_for`](docs/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-bem_attrs_for.md)
    1. [`bem_mix`](docs/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-bem_mix.md)
    1. [`bem_mods`](docs/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-bem_mods.md)
    1. [`block_tag`](docs/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-block_tag.md)
    1. [`elem_tag`](docs/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-elem_tag.md)
1. [BEMHTML](docs/BEMHTML.md)
    1. [Шаблоны](docs/%D0%A8%D0%B0%D0%B1%D0%BB%D0%BE%D0%BD%D1%8B.md)
    1. [Контекст узла](docs/%D0%9A%D0%BE%D0%BD%D1%82%D0%B5%D0%BA%D1%81%D1%82-%D1%83%D0%B7%D0%BB%D0%B0.md)
    1. [Предикаты](docs/%D0%9F%D1%80%D0%B5%D0%B4%D0%B8%D0%BA%D0%B0%D1%82%D1%8B.md)
    1. [Режимы](docs/%D0%A0%D0%B5%D0%B6%D0%B8%D0%BC%D1%8B.md)

## Ссылки

1. BEM methodology - https://bem.info/methodology/
1. Minimal stack for coding client-side JavaScript and templating - https://github.com/bem/bem-core
1. Declarative template engine for the browser and server with regular JS syntax - https://github.com/bem/bem-xjst
1. BEM Forum - https://bem.info/forum/

## Лицензия

Copyright (c) 2017 - 2020 Александр Григорьев. Более подробную информацию о лицензии можно получить в файле [LICENSE.txt](LICENSE.txt).

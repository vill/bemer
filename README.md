# Bemer

**ВАЖНО**. *Для работы с UI компонентами не обязательно использовать методологию БЭМ.*

1. Позволяет создавать переиспользуемые UI компоненты для приложений на Ruby on Rails.
1. Предоставляет функционал для разработки приложений на Ruby on Rails с использованием методологии БЭМ.

## Дополнительно

1. Статья на Хабре - [Переиспользуемые UI компоненты в приложениях на Ruby on Rails](https://habrahabr.ru/post/352938/).
1. [bemer-bootstrap](https://github.com/vill/bemer-bootstrap) - переиспользуемые компоненты Bootstrap v3.
1. [Пример приложения](https://github.com/vill/bemer-example) с использованием `bemer` и [bemer-bootstrap](https://github.com/vill/bemer-bootstrap).

## Установка

Добавить в `Gemfile`:

```ruby
gem 'bemer', '~> 0.1.0'
```

Выполнить в терминале команду:

    $ bundle

## Использование

1. [Файловая структура](docs/%D0%A4%D0%B0%D0%B9%D0%BB%D0%BE%D0%B2%D0%B0%D1%8F-%D1%81%D1%82%D1%80%D1%83%D0%BA%D1%82%D1%83%D1%80%D0%B0.md)
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

1. https://ru.bem.info/methodology/
1. https://github.com/bem/bem-xjst
1. https://github.com/bem-site/bem-forum-content-ru/issues

## Лицензия

Copyright (c) 2017 - 2018 Александр Григорьев. Более подробную информацию о лицензии можно получить в файле [LICENSE.txt](LICENSE.txt).

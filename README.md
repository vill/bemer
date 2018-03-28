# Bemer

**ВАЖНО**. *Для работы с UI компонентами не обязательно использовать методологию БЭМ.*

1. Позволяет создавать переиспользуемые UI компоненты для приложений на Ruby on Rails.
1. Предоставляет функционал для разработки приложений на Ruby on Rails с использованием методологии БЭМ.


## Установка

Добавить в `Gemfile`:

```ruby
gem 'bemer', '~> 0.1.0'
```

Выполнить в терминале команду:

    $ bundle

## Использование

1. [Файловая структура](https://github.com/vill/bemer/wiki/%D0%A4%D0%B0%D0%B9%D0%BB%D0%BE%D0%B2%D0%B0%D1%8F-%D1%81%D1%82%D1%80%D1%83%D0%BA%D1%82%D1%83%D1%80%D0%B0)
1. [Конфигурация](https://github.com/vill/bemer/wiki/%D0%9A%D0%BE%D0%BD%D1%84%D0%B8%D0%B3%D1%83%D1%80%D0%B0%D1%86%D0%B8%D1%8F)
1. [Создание и использование UI компонент](https://github.com/vill/bemer/wiki/%D0%A1%D0%BE%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-%D0%B8-%D0%B8%D1%81%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5-UI-%D0%BA%D0%BE%D0%BC%D0%BF%D0%BE%D0%BD%D0%B5%D0%BD%D1%82)
1. Хелперы для работы с компонентами
    1. [`define_component`](https://github.com/vill/bemer/wiki/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-define_component)
    1. [`define_templates`](https://github.com/vill/bemer/wiki/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-define_templates)
    1. [`render_component`](https://github.com/vill/bemer/wiki/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-render_component)
    1. [`refine_component`](https://github.com/vill/bemer/wiki/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-refine_component)
    1. [`component_pack`](https://github.com/vill/bemer/wiki/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-component_pack)
1. Дополнительные хелперы для БЭМ методологии
    1. [`bem_mix`](https://github.com/vill/bemer/wiki/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-bem_mix)
    1. [`bem_mods`](https://github.com/vill/bemer/wiki/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-bem_mods)
    1. [`block_tag`](https://github.com/vill/bemer/wiki/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-block_tag)
    1. [`elem_tag`](https://github.com/vill/bemer/wiki/%D0%A5%D0%B5%D0%BB%D0%BF%D0%B5%D1%80-elem_tag)
1. [BEMHTML](https://github.com/vill/bemer/wiki/BEMHTML)
    1. [Шаблоны](https://github.com/vill/bemer/wiki/%D0%A8%D0%B0%D0%B1%D0%BB%D0%BE%D0%BD%D1%8B)
    1. [Контекст узла](https://github.com/vill/bemer/wiki/%D0%9A%D0%BE%D0%BD%D1%82%D0%B5%D0%BA%D1%81%D1%82-%D1%83%D0%B7%D0%BB%D0%B0)
    1. [Предикаты](https://github.com/vill/bemer/wiki/%D0%9F%D1%80%D0%B5%D0%B4%D0%B8%D0%BA%D0%B0%D1%82%D1%8B)
    1. [Режимы](https://github.com/vill/bemer/wiki/%D0%A0%D0%B5%D0%B6%D0%B8%D0%BC%D1%8B)

## Ссылки

1. https://ru.bem.info/methodology/
1. https://github.com/bem/bem-xjst
1. https://github.com/bem-site/bem-forum-content-ru/issues

## Лицензия

Copyright (c) 2017 - 2018 Александр Григорьев. Более подробную информацию о лицензии можно получить в файле [LICENSE](LICENSE).

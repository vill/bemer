# Bemer

**ВАЖНО**. *Для работы с UI компонентами не обязательно использовать методологию БЭМ.*

1. Позволяет создавать переиспользуемые UI компоненты для приложений на Ruby on Rails.
1. Предоставляет функционал для разработки приложений на Ruby on Rails с использованием методологии БЭМ.


## Установка

Добавить в `Gemfile`:

```ruby
gem 'bemer'
```

Выполнить в терминале команду:

    $ bundle

## Использование

1. [Файловая структура](Файловая-структура)
1. [Конфигурация](Конфигурация)
1. [Создание и использование UI компонент](Создание-и-использование-UI-компонент)
1. Хелперы для работы с компонентами
    1. [`define_component`](Хелпер-define_component)
    1. [`define_templates`](Хелпер-define_templates)
    1. [`render_component`](Хелпер-render_component)
    1. [`refine_component`](Хелпер-refine_component)
    1. [`component_pack`](Хелпер-component_pack)
1. Дополнительные хелперы для БЭМ методологии
    1. [`bem_mix`](Хелпер-bem_mix)
    1. [`bem_mods`](Хелпер-bem_mods)
    1. [`block_tag`](Хелпер-block_tag)
    1. [`elem_tag`](Хелпер-elem_tag)
1. [BEMHTML](BEMHTML)
    1. [Шаблоны](Шаблоны)
    1. [Контекст узла](Контекст-узла)
    1. [Предикаты](Предикаты)
    1. [Режимы](Режимы)

## Ссылки

1. https://ru.bem.info/methodology/
1. https://github.com/bem/bem-xjst
1. https://github.com/bem-site/bem-forum-content-ru/issues

## Лицензия

Copyright (c) 2017 - 2018 Александр Григорьев. Более подробную информацию о лицензии можно получить в файле [LICENSE](LICENSE).

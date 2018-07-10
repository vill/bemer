# Хелпер render_component

**ВАЖНО**. *Является псевдонимом для `refine_component`.*

**ВАЖНО**. *Только для компонент, структура (дерево) которых была создана с помощью [хелпера `define_component`](Хелпер-define_component.md) доступно использование [BEMHTML шаблонов](Шаблоны.md).*

**ДОПОЛНИТЕЛЬНО**. *Различные способы создания и рендеринга компонент описаны [здесь](Создание-и-использование-UI-компонент.md).*

Соглашения по использованию:
1. `render_component` используется для рендеринга компонент
1. `refine_component` используется для создания новых компонент на основе существующих, реализованных [с помощью `define_component`](Хелпер-define_component.md)

Используя `render_component` можно получать HTML структуру компонента, а если компонент был создан [с помощью `define_component`](Хелпер-define_component.md) тогда и изменять его структуру/внешний вид с помощью шаблонов BEMHTML.

Все передаваемые параметры будут доступны в теле компонента как локальные переменные, исключение составляют параметры `cached` и `prefix`.

Используется следующая файловая структура:
```
app/
  ├── assets/
  |     ├── javascripts/
  |     |     └── application.js
  |     └── stylesheets/
  |           └── application.css
  ├── bemer_components/
  |     ├── progress/
  |     |     ├── index.html.slim
  |     |     ├── index.js
  |     |     └── index.css
  |     └── ...
  └── ...
```
Подключение технологий JavaScript и CSS компонента `progress` при использовании Sprockets:

```js
// Файл app/assets/javascripts/application.js
//= require progress
```

```scss
// Файл app/assets/stylesheets/application.css
//= require progress
```
В качестве структуры компонента `progress` будет взят [компонент `Progress bar` из библиотеки Twitter Bootstrap](https://getbootstrap.com/docs/3.3/components/#progress):

```html
<!-- Исходная HTML структура компонента Progress bar из библиотеки Twitter Bootstrap -->
<div class="progress">
  <div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;">
    60%
  </div>
</div>
```
Возможный вариант разметки компонента `progress` с использованием `define_component` по методологии БЭМ:
```slim
/ Содержимое файла index.html.slim компонента panel
= define_component bem_cascade: false, tag: :div do |component|
  = component.block :progress, cls: :progress do |progress|
    = progress.elem :bar, role: :progressbar, cls: :progress_bar
```
## Использование BEMHTML шаблонов

В случае если структура компонента была создана [с помощью `define_component`](Хелпер-define_component.md), тогда при вызове `render_component` можно передать `&block` в теле которого будет доступен билдер (builder) шаблонов технологии BEMHTML:

```slim
/ Эквивалентный результат, только режим `attrs` здесь будет быстрее чем цепочка `add_attrs`
= render_component :progress do |template|
  = template.elem :bar do |bar|
    = bar.attrs 'aria-valuenow': 60, 'aria-valuemin': 0, 'aria-valuemax': 100, style: 'width: 60%;'
    = bar.content '60%'

= render_component :progress do |template|
  = template.elem :bar do |bar|
    = bar.add_attrs 'aria-valuenow': 60
    = bar.add_attrs 'aria-valuemin': 0
    = bar.add_attrs 'aria-valuemax': 100
    = bar.add_attrs style: 'width: 60%;'
    = bar.content '60%'

/ =>
/ <div class="progress">
/   <div role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;" class="progress-bar">
/     60%
/   </div>
/ </div>
```
Для изменения внешнего вида, можно добавить css классы `progress-bar-success`, `progress-bar-striped` и `active`:
```slim
= render_component :progress do |template|
  = template.elem :bar do |bar|
    = bar.attrs 'aria-valuenow': 60, 'aria-valuemin': 0, 'aria-valuemax': 100, style: 'width: 60%;'
    = bar.content '60%'
    = bar.add_cls :progress_bar_striped, :active, :progress_bar_success

/ =>
/ <div class="progress">
/   <div aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;" class="progress-bar progress-bar-striped active progress-bar-success">
/     60%
/   </div>
/ </div>
```
## Параметр `prefix`

Для чего нужен и как использовать параметр `prefix` можно прочитать [здесь](Конфигурация.md#%D0%9F%D0%B0%D1%80%D0%B0%D0%BC%D0%B5%D1%82%D1%80-default_path_prefix).

## Параметр `cached`

Описание про `cached` можно найти [в `component_pack`](Хелпер-component_pack.md).

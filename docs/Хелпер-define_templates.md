# Хелпер define_templates

**ВАЖНО**. *Только для компонент, структура (дерево) которых была создана с помощью [хелпера `define_component`](Хелпер-define_component.md) доступно использование [BEMHTML шаблонов](Шаблоны.md).*

Позволяет создавать шаблоны по умолчанию (технология BEMHTML) для компонент созданных [с помощью `define_component`](Хелпер-define_component.md).

При вызове `define_templates` можно передать единственный параметр `cached` который по умолчанию равен `true`, см. [хелпер `component_pack`](Хелпер-component_pack.md).

Используется следующая файловая структура:
```
app/
  ├── assets/
  |     ├── javascripts/
  |     |     └── application.js
  |     └── stylesheets/
  |           └── application.css
  ├── bemer_components/
  |     ├── panel/
  |     |     ├── index.html.slim
  |     |     ├── index.bemhtml.slim
  |     |     ├── index.js
  |     |     └── index.css
  |     └── ...
  └── ...
```
Подключение технологий JavaScript и CSS компонента `panel` при использовании Sprockets:

```js
// Файл app/assets/javascripts/application.js
//= require panel
```

```scss
// Файл app/assets/stylesheets/application.css
//= require panel
```
В качестве структуры компонента `panel` будет взят [компонент `panel` из библиотеки Twitter Bootstrap](https://getbootstrap.com/docs/3.3/components/#panels):

```html
<!-- Исходная HTML структура компонента panel из библиотеки Twitter Bootstrap -->
<div class="panel panel-default">
  <div class="panel-heading">
    <h3 class="panel-title">Panel title</h3>
  </div>
  <div class="panel-body">Panel content</div>
  <div class="panel-footer">Panel footer</div>
</div>
```
Возможный вариант разметки компонента `panel` по БЭМ методологии:
```slim
/ Содержимое файла index.html.slim компонента panel
= define_component bem_cascade: false, tag: :div do |component|
  = component.block :panel, cls: 'panel' do |panel|
    = panel.elem :heading, cls: 'panel-heading'
      = panel.elem :title, tag: :h3, cls: 'panel-title', content: 'Panel title'
    = panel.elem :content, cls: 'panel-body', content: 'Panel content'
    = panel.elem :footer, cls: 'panel-footer', content: 'Panel footer'
```

После рендеринга без применения шаблонов по умолчанию, HTML структура будет выглядеть следующим образом:
```slim
/ Шаблонизатор Slim
= render_component :panel

/ =>
/ <div class="panel">
/   <div class="panel-heading">
/     <h3 class="panel-title">Panel title</h3>
/   </div>
/   <div class="panel-body">Panel content</div>
/   <div class="panel-footer">Panel footer</div>
/ </div>
```
С помощью файла `index.bemhtml.slim` можно задать дефолтные шаблоны для компонента, которые можно будет переопределить при вызове `render_component` или `refine_component`.

Возможный вариант шаблонов по умолчанию для компонента `panel`:
```slim
/ Содержимое файла index.bemhtml.slim компонента panel
= define_templates do |template|
  = template.block(:panel).add_cls :panel_default
```

После рендеринга HTML структура теперь будет выглядеть следующим образом (добавлен css класс `panel-default`):
```slim
/ Шаблонизатор Slim
= render_component :panel

/ =>
/ <div class="panel panel-default">
/   <div class="panel-heading">
/     <h3 class="panel-title">Panel title</h3>
/   </div>
/   <div class="panel-body">Panel content</div>
/   <div class="panel-footer">Panel footer</div>
/ </div>
```

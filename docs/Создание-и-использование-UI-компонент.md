# Создание и использование UI компонент

**ВАЖНО**. *Только для компонент, структура (дерево) которых была создана с помощью [хелпера `define_component`](Хелпер-define_component.md) доступно использование [BEMHTML шаблонов](Шаблоны.md).*

Для всех примеров используется следующая файловая структура:

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
  |     |     ├── index.js
  |     |     └── index.css
  |     └── ...
  └── ...
```
Подключение технологий JavaScript и CSS компонента `panel` при использование Sprockets:

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
## Компонент без использования шаблонизатора

```html
<!-- Содержимое файла index.html компонента panel -->
<div class="panel panel-default">
  <div class="panel-heading">
    <h3 class="panel-title">Panel title</h3>
  </div>
  <div class="panel-body">Panel content</div>
  <div class="panel-footer">Panel footer</div>
</div>
```
получение HTML кода компонента в представлениях и/или хелперах:
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

## Компонент с использованием шаблонизатора

```slim
/ Содержимое файла index.html.slim компонента panel
.panel.panel-default
  .panel-heading
    h3.panel-title Panel title
  .panel-body Panel content
  .panel-footer Panel footer
```
получение HTML кода компонента в представлениях и/или хелперах:
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

## Компонент с помощью `block_tag`

```slim
/ Содержимое файла index.html.slim компонента panel
= block_tag :panel, bem_cascade: false, tag: :div, cls: 'panel panel-default' do |panel|
  = panel.elem :heading, tag: :div, cls: 'panel-heading'
    = panel.elem :title, tag: :h3, cls: 'panel-title', content: 'Panel title'
  = panel.elem :body, tag: :div, cls: 'panel-body', content: 'Panel content'
  = panel.elem :footer, tag: :div, cls: 'panel-footer', content: 'Panel footer'
```
получение HTML кода компонента в представлениях и/или хелперах:
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

## Компонент с помощью `define_component`

**ВАЖНО**. *Доступно использование [BEMHTML шаблонов](Шаблоны.md).*

```slim
/ Содержимое файла index.html.slim компонента panel
= define_component bem_cascade: false, tag: :div do |component|
  = component.block :panel, cls: 'panel panel-default' do |panel|
    = panel.elem :heading, cls: 'panel-heading'
      = panel.elem :title, tag: :h3, cls: 'panel-title', content: 'Panel title'
    = panel.elem :body, cls: 'panel-body', content: 'Panel content'
    = panel.elem :footer, cls: 'panel-footer', content: 'Panel footer'
```
получение HTML кода компонента в представлениях и/или хелперах:
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

## Передача локальных переменных в индексный файл технологии HTML

```slim
/ Содержимое файла index.html.slim компонента panel
.panel.panel-default
  .panel-heading
    h3.panel-title = local_assigns.fetch(:title, 'Default title')
  .panel-body = local_assigns.fetch(:content, 'Default content')
  .panel-footer = local_assigns.fetch(:footer, 'Default footer')
```
получение HTML кода компонента в представлениях и/или хелперах:
```slim
/ Шаблонизатор Slim
= render_component :panel, title: 'Title', content: 'Content', footer: 'Footer'

/ =>
/ <div class="panel panel-default">
/   <div class="panel-heading">
/     <h3 class="panel-title">Title</h3>
/   </div>
/   <div class="panel-body">Content</div>
/   <div class="panel-footer">Footer</div>
/ </div>
```

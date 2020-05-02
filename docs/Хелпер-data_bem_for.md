# Хелпер data_bem_for

Хелпер `data_bem_for` генерирует `class` и `data-bem` атрибуты для указанной сущности.

## Допустимые параметры

`cls` (синоним `class`), `js`, `mix` и `mods`, все остальные переданные параметры с названиями не из этого списка будут считаться атрибутами, за исключением: `bem`, `bem_cascade`, `content` и `tag`.


## Использование

```slim
= data_bem_for :block, :element
/ => { class: "block__element i-bem", "data-bem": "{\"block__element\":{}}" }
```

```slim
= data_bem_for :block, :element, js: { some: :value }
/ => { class: "block__element i-bem", "data-bem": "{\"block__element\":{\"some\":\"value\"}}" }
```

```slim
= simple_form_for :form, url: '#' do |f|
  = f.input :numbers, collection: (1..5).map { |n| [n, n, data_bem_for(:form, :number, js: { value: n })] }
  = f.button :submit
/ =>
/ <form novalidate="novalidate" class="form" action="#" accept-charset="UTF-8" method="post">
/   <!-- ... -->
/   <select class="form__numbers form__numbers--select form__numbers--required" name="form[numbers]" id="form_numbers">
/     <option value=""></option>
/     <option class="form__number i-bem" data-bem="{&quot;form__number&quot;:{&quot;value&quot;:1}}" value="1">1</option>
/     <option class="form__number i-bem" data-bem="{&quot;form__number&quot;:{&quot;value&quot;:2}}" value="2">2</option>
/     <option class="form__number i-bem" data-bem="{&quot;form__number&quot;:{&quot;value&quot;:3}}" value="3">3</option>
/     <option class="form__number i-bem" data-bem="{&quot;form__number&quot;:{&quot;value&quot;:4}}" value="4">4</option>
/     <option class="form__number i-bem" data-bem="{&quot;form__number&quot;:{&quot;value&quot;:5}}" value="5">5</option>
/   </select>
/   <!-- ... -->
/ </form>
```

```slim
= simple_form_for :form, url: '#' do |f|
  = f.input :numbers, collection: (1..5).map { |n| [n, n, data_bem_for(:form, :number, js: false)] }
  = f.button :submit
/ =>
/ <form novalidate="novalidate" class="form" action="#" accept-charset="UTF-8" method="post">
/   <!-- ... -->
/   <select class="form__numbers form__numbers--select form__numbers--required" name="form[numbers]" id="form_numbers">
/     <option value=""></option>
/     <option class="form__number" value="1">1</option>
/     <option class="form__number" value="2">2</option>
/     <option class="form__number" value="3">3</option>
/     <option class="form__number" value="4">4</option>
/     <option class="form__number" value="5">5</option>
/   </select>
/   <!-- ... -->
/ </form>
```

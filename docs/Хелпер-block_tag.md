# Хелпер block_tag

**ВАЖНО**. *Только для компонент, [структура (дерево) которых была создана](Создание-и-использование-UI-компонент.md) с помощью [хелпера `define_component`](Хелпер-define_component.md) доступно использование [BEMHTML шаблонов](Шаблоны.md).*

**ВАЖНО**. *Для сущностей у которых не указано название, не будут созданы css классы и js атрибуты из методологии БЭМ*:
```ruby
block_tag js: true, bem: true # => <div></div>
```

**ВАЖНО**. *[Параметр `bem` из конфигурации](Конфигурация.md#%D0%9F%D0%B0%D1%80%D0%B0%D0%BC%D0%B5%D1%82%D1%80-bem) никак не влияет на работу `block_tag`.*

**ВАЖНО**. *Использование строковых (`String`) ключей при передаче параметров не допустимо, ключами могут быть только сиволы (`Symbol`).*

Позволяет создавать блок по методологии БЭМ.

## Название сущности

При вызове `block_tag` первым аргументом передается название блока (указывать не обязательно) допустимые типы:
1. `Symbol` ВСЕ символы нижнего подчеркивания будут преобразованы в тире, при формирование css классов по методологии БЭМ
1. `String` возвращается без изменений

```ruby
# Вызов без каких-либо параметров
block_tag # => <div></div>
```
```ruby
block_tag :block_name # => <div class="block-name"></div>
```

**ВАЖНО**. *Будьте ВНИМАТЕЛЬНЫ при использовании названий с типом `String`, если в них содержатся знаки нижнего подчеркивания `_`, это может привести к неправильному результату согласно методологии БЭМ*:
```ruby
block_tag 'block_name' # => <div class="block_name"></div>
```

## Допустимые параметры

`bem`, `bem_cascade`, `cls` (синоним `class`), `content`, `js`, `mix`, `mods` и `tag`, все остальные переданные параметры с названиями не из этого списка будут считаться атрибутами.

### Параметр `bem`

Разрешает или запрещает использовать методологию БЭМ при создании текущего блока.

```ruby
block_tag :block, bem: true  # => <div class="block"></div>
block_tag :block, bem: false # => <div></div>
block_tag :block, bem: nil # => <div class="block"></div>
```

### Параметр `bem_cascade`

Разрешает или запрещает использовать методологию БЭМ для текущего блока и ТОЛЬКО всех его элементов (в [хелпере `define_component` используется для ВСЕХ ДОЧЕРНИХ ЭЛЕМЕНТОВ см. описание параметра `content`](#%D0%9F%D0%B0%D1%80%D0%B0%D0%BC%D0%B5%D1%82%D1%80-content))

```ruby
block_tag :block, bem_cascade: true  # => <div class="block"></div>
block_tag :block, bem_cascade: false # => <div></div>
```

Имеет меньший приоритет чем параметр `bem`:

```ruby
block_tag :block, bem_cascade: true, bem: false # => <div></div>
block_tag :block, bem_cascade: false, bem: true # => <div class="block"></div>
```

### Параметр `cls` синоним `class`

Добавляет css классы.

```ruby
block_tag :block, cls: 'class-1', bem: false  # => <div class="class-1"></div>
block_tag :block, class: 'class-1', bem: true # => <div class="block class-1"></div>
```
ВСЕ символы нижнего подчеркивания будут преобразованы в тире, если класс передан как `Symbol`:

```ruby
block_tag :block, cls: ['cls_1', :cls_2], bem: false # => <div class="cls_1 cls-2"></div>
```

### Параметр `content`

Добавляет содержимое для блока.

```ruby
block_tag :block, content: 'Block content' # => <div class="block">Block content</div>
```
Если передан `Ruby &block`, тогда параметр `content` игнорируется:

```slim
/ Шаблонизатор Slim
= block_tag :block, content: 'Block content', bem: false do
  h1 Content from Ruby &block

/ => <div><h1>Content from Ruby &block</h1></div>
```
Для блоков доступно альтернативное создание элементов:

```slim
/ Шаблонизатор Slim
= block_tag :block, bem_cascade: true do |block|
  = block.elem :elem_1 do
    = block.elem :elem_2 do
      span Elem 2 content

/ =>
/<div class="block">
/   <div class="block__elem-1">
/     <div class="block__elem-2">
/       <span>Elem 2 content</span>
/     </div>
/   </div>
/ </div>

= block_tag :block, bem_cascade: false, bem: true do |block|
  = block.elem :elem_1 do
    = block.elem :elem_2 do
      span Elem 2 content

/ =>
/ <div class="block">
/   <div>
/     <div>
/       <span>Elem 2 content</span>
/     </div>
/   </div>
/ </div>

= block_tag :block, bem_cascade: false, bem: true do |block|
  = block.elem :elem_1, bem: true do
    = block.elem :elem_2 do
      span Elem 2 content
/ =>
/ <div class="block">
/   <div class="block__elem-1">
/     <div>
/       <span>Elem 2 content</span>
/     </div>
/   </div>
/ </div>
```


### Параметр `js`

Создает атрибут `data-bem` и css класс `i-bem`.

```ruby
block_tag :block, js: true, bem: true
# => <div class="block i-bem" data-bem="{"block":{}}"></div>

block_tag :block, js: [1, 2], bem: true
# => <div class="block i-bem" data-bem="{"block":[1,2]}"></div>

block_tag :block, js: { key: :val }, bem: true
# => <div class="block i-bem" data-bem="{"block":{"key":"val"}}"></div>

block_tag :block, js: true, bem: false # => <div></div>
```
Для блока без имени js атрибуты не создаются:
```ruby
block_tag js: true, bem: true # => <div></div>
```
### Параметр `mix`

Добавляет миксы подробнее см. [хелпер `bem_mix`](Хелпер-bem_mix.md).

```ruby
block_tag :block, mix: [:mix_1, block_1: :elem], bem: true
# => <div class="block mix-1 block-1__elem"></div>

block_tag :block, mix: { block_1: :elem }, bem: true
# => <div class="block block-1__elem"></div>
```

### Параметр `mods`

Добавляет модификаторы подробнее см. [хелпер `bem_mods`](Хелпер-bem_mods.md).

```ruby
block_tag :block, mods: :enabled, bem: true
# => <div class="block block_enabled"></div>

block_tag :block, mods: [:enabled, size: :small], bem: true
# => <div class="block block_enabled block_size_small"></div>

block_tag :block, mods: { size: :small }, bem: true
# => <div class="block block_size_small"></div>
```

### Параметр `tag`

Добавляет или удаляет html тег, допустимые значения: `Symbol`, `String`, `false` и `nil`.

```ruby
block_tag :block, tag: :span, content: 'Block content'
# => <span class="block">Block content</span>

block_tag :block, tag: '', content: 'Block content'
# => 'Block content'

block_tag :block, tag: false, content: 'Block content'
# => 'Block content'

# Будет использован default_block_tag из конфига
block_tag :block, tag: nil, content: 'Block content'
# => <div class="block">Block content</div>
```

### Атрибуты

Любой параметр с названием не из [списка допустимых параметров](#%D0%94%D0%BE%D0%BF%D1%83%D1%81%D1%82%D0%B8%D0%BC%D1%8B%D0%B5-%D0%BF%D0%B0%D1%80%D0%B0%D0%BC%D0%B5%D1%82%D1%80%D1%8B) считается атрибутом:

```ruby
block_tag :block, data: { key: :val } # => <div data-key="val"></div>
block_tag :block, key: :val           # => <div key="val"></div>
```
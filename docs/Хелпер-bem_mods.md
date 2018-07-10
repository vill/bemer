# Хелпер bem_mods

**ВАЖНО**. *Для сущностей у которых не указано название, не будут созданы css классы из методологии БЭМ*.

Позволяет создавать модификаторы по методологии БЭМ.

Действуют такие же правила трансформации для символов нижнего подчеркивания в символы тире как и у [хелпера `bem_mix`](Хелпер-bem_mix.md).

`bem_mods` принимает название блока, название элемента (которые не могут быть `''`, `false` или `nil`) и параметры модификаторов которые могут быть массивом, хешем, символом или строкой.

Модификаторы для блока:

```ruby
bem_mods :block_name, theme: :green_islands # => 'block-name_theme_green-islands'
```

Модификаторы для элемента:

```ruby
bem_mods :block_name, :elem_name, has_tail: true # => 'block-name__elem-name_has-tail'
```

Единственный модификатор с значением `true`:

```ruby
# Эквивалентные записи
bem_mods :block_name, :has_tail            # => 'block-name_has-tail'
bem_mods :block_name, has_tail: true       # => 'block-name_has-tail'
bem_mods :block_name, [:has_tail]          # => 'block-name_has-tail'
bem_mods :block_name, [has_tail: true]     # => 'block-name_has-tail'
bem_mods :block_name, [{ has_tail: true }] # => 'block-name_has-tail'
```

Список модификаторов:

```ruby
# Эквивалентные записи
bem_mods :block, enabled: true, size: :small           # => 'block_enabled block_size_small'
bem_mods :block, [enabled: true, size: :small]         # => 'block_enabled block_size_small'
bem_mods :block, [{ enabled: true, size: :small }]     # => 'block_enabled block_size_small'
bem_mods :block, [{ enabled: true }, { size: :small }] # => 'block_enabled block_size_small'
bem_mods :block, [:enabled, size: :small]              # => 'block_enabled block_size_small'
```
**ВАЖНО.** *Будьте ВНИМАТЕЛЬНЫ при использование аргументов с типом `String`, а также ключей и/или значений хеша с типом `String` это может привести к неправильному результату согласно методологии БЭМ*:

```ruby
bem_mods :block_name, 'has_tail'                # => 'block-name_has_tail'
bem_mods :block_name, 'has_tail' => true        # => 'block-name_has_tail'
bem_mods :block_name, 'mod_name' => 'mod_value' # => 'block-name_mod_name_mod_value'
```
те же самые модификаторы при использовании типа `Symbol`:
```ruby
bem_mods :block_name, :has_tail            # => 'block-name_has-tail'
bem_mods :block_name, has_tail: true       # => 'block-name_has-tail'
bem_mods :block_name, mod_name: :mod_value # => 'block-name_mod-name_mod-value'
```
Модификаторы у которых значение `false`, `nil` или `''`:
```ruby
# Эквивалентные записи
bem_mods :block_name, enabled: false, size: :small # => 'block-name_size_small'
bem_mods :block_name, enabled: '', size: :small    # => 'block-name_size_small'
bem_mods :block_name, enabled: nil, size: :small   # => 'block-name_size_small'
```

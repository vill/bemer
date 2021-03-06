# Хелпер bem_mix

**ВАЖНО**. *Для сущностей у которых не указано название, не будут созданы css классы из методологии БЭМ*.

Позволяет создавать миксы по методологии БЭМ.

Все передаваемые аргументы типа `Symbol` создают миксы блоков, аргументы типа `Hash` создают миксы элементов (исключение хеш у которого значение `nil`, см. пример ниже).

У ВСЕХ аргументов переданных как тип:
* `Symbol` ВСЕ символы нижнего подчеркивания будут преобразованы в тире
* `String` возвращаются без модификации (включая ключи и/или значения хешей)

```ruby
bem_mix :block_name, block_name: :elem_name   # => 'block-name block-name__elem-name'
```

эквивалентная запись:

```ruby
bem_mix [:block_name, block_name: :elem_name] # => 'block-name block-name__elem-name'
```
С помощью хеша можно создать микс блока если значение передать как `nil`
```ruby
bem_mix block_name: nil # => 'block-name'
```

если значение хеша указано как `''` или `false` микс создан не будет:
```ruby
bem_mix block_name: false # => ''
bem_mix block_name: ''    # => ''
```
Если у нескольких элементов название блока одинаковое, чтобы не переопределить предыдущее значение следующим, можно каждый элемент передавать как отдельный хеш:

```ruby
bem_mix({ block: :elem1 }, { block: :elem2 }) # => 'block__elem1 block__elem2'
```
или эквивалентная и более компактная запись используя массив:

```ruby
bem_mix block: [:elem1, :elem2] # => 'block__elem1 block__elem2'
```
**ВАЖНО.** *Будьте ВНИМАТЕЛЬНЫ при использование аргументов с типом `String`, а также ключей и/или значений хеша с типом `String` это может привести к неправильному результату согласно методологии БЭМ*:

```ruby
bem_mix 'block_name' => 'elem_name' # => 'block_name__elem_name'
```
Аргументы переданные как тип `String` ВСЕГДА остаются неизменными:

```ruby
bem_mix 'block_name', 'block_name__elem' # => 'block_name block_name__elem'
```

Пустые аргументы возвращают пустую строку
```ruby
bem_mix nil, '', {} # => ''
```
# Хелпер define_component

**ВАЖНО**. *Необходимо только описывать структуру (дерево) компонента в терминах (блок и элемент) методологии БЭМ*, **создание `css` классов и `js` атрибутов из методологии БЭМ НЕ ОБЯЗАТЕЛЬНО**.

**ВАЖНО**. *В отличие от хелперов `block_tag` и `elem_tag`, генерация данных из методологии БЭМ зависит от параметра [`bem` в конфигурации](Конфигурация.md#%D0%9F%D0%B0%D1%80%D0%B0%D0%BC%D0%B5%D1%82%D1%80-bem).*

**ВАЖНО**. *Доступно использование [BEMHTML шаблонов](Шаблоны.md).*

**ВАЖНО**. *Для сущностей у которых не указано название, не будут созданы css классы и js атрибуты из методологии БЭМ*.

Хелпер `define_component` позволяет описывать структуру (дерево) компонента с помощью сущностей (блок и элемент) методологии БЭМ, благодаря этому, используя BEMHTML шаблоны можно более продвинутыми способами взаимодействовать с такими типами компонент.

При вызове `define_component` обязательно нужно использовать `&block` в который будет передан билдер (builder) для построения структуры (дерева) компонента.

##  Метод `block`

Принимает такие же параметры как и [хелпер `block_tag`](Хелпер-block_tag.md).

**ВАЖНО**. *В отличие от `block_tag` и `elem_tag`, переданный в текущий узел параметр `bem_cascade` распространяется на сам узел и все его дочерние узлы (блоки и элементы), даже если текущий узел является элементом.*

Позволяет создавать блок из методологии БЭМ:
```slim
= define_component do |component|
  = component.block content: 'Plain text'

= define_component do |component|
  = component.block :block_name, content: 'Plain text'

= define_component do |component|
  = component.block
    span Content

/ bem_cascade: false применится к узлу и ко всем его дочерним узлам
= define_component do |component|
  = component.block bem_cascade: false do |block|
    = component.block :block2 do |block2|
      = block2.elem :elem
    = block.elem content: 'Plain text'
```

##  Метод `elem`

Принимает такие же параметры как и [хелпер `elem_tag`](Хелпер-elem_tag.md).

**ВАЖНО**. *В отличие от `block_tag` и `elem_tag`, переданный в текущий узел параметр `bem_cascade` распространяется на сам узел и все его дочерние узлы (блоки и элементы), даже если текущий узел является элементом.*

Позволяет создавать элемент из методологии БЭМ:
```slim
= define_component do |component|
  = component.elem content: 'Plain text'

= define_component do |component|
  = component.elem :block_name, :elem_name, content: 'Plain text'

= define_component do |component|
  = component.elem
    span Content

/ bem_cascade: true применится к узлу и ко всем его дочерним узлам
= define_component do |component|
  = component.elem bem_cascade: true
    = component.block do |block|
      = block.elem content: 'Plain text'
```

##  Метод `text`

**ВАЖНО**. *Переданные параметры через методы `apply`, `apply_next`, `content` и `ctx` не будут использоваться в узлах внутри метода `text`*.

Создает текстовый узел(`TextNode`) в структуре(дереве) компонента, к узлам такого типа **не применяются шаблоны BEMHTML** и значение параметра `tag` указано как `false`, не принимает никаких дополнительных параметров.

Узлы с типом `TextNode` предназначены ТОЛЬКО для расположения текста на определенном уровне в структуре(дереве), чтобы при рендеринге компонента не происходило выталкивание вверх текстовых вставок:

```slim
/ При такой структуре 'span Content' всплывет на верх
= define_component bem_cascade: true do |component|
  = component.block :block_name
  span Content

/ =>
/ <span>Content</span>
/ <div class="block-name"></div>

= define_component bem_cascade: true do |component|
  = component.block :block_name
  = component.text
    span Content

/ =>
/ <div class="block-name"></div>
/ <span>Content</span>

= define_component bem_cascade: true do |component|
  = component.block :block_name
  = component.text 'Content'

/ =>
/ <div class="block-name"></div>
/ Content
```

В данном случае, результат будет одинаковым, но лучше избегать использование методов `block` и `elem` внутри метода `text`:
```slim
= define_component bem_cascade: true do |component|
  = component.block :block1
  = component.text
    = component.block :block2 do |block2|
      = block2.elem :elem

= define_component bem_cascade: true do |component|
  = component.block :block1
  = component.block :block2 do |block2|
    = block2.elem :elem

/ =>
/ <div class="block1"></div>
/ <div class="block2">
/   <div class="block2__elem"></div>
/ </div>
```

##  Параметры по умолчанию

В `define_component` можно передать такие же параметры как и в методы `block` и `elem`, которые будут значениями по умолчанию для узлов дерева (структуры) компонента:
```slim
/ Эквивалентные записи
= define_component do |component|
  = component.block :block1, tag: :div, js: true, bem: true
  = component.block :block2, tag: :div, js: true, bem: true do |block2|
    = block2.elem :elem, tag: :div, js: true, bem: true

= define_component tag: :div, js: true, bem: true do |component|
  = component.block :block1
  = component.block :block2 do |block2|
    = block2.elem :elem

/ =>
/ <div data-bem="{"block1":{}}" class="block1 i-bem"></div>
/ <div data-bem="{"block2":{}}" class="block2 i-bem">
/   <div data-bem="{"block2__elem":{}}" class="block2__elem i-bem"></div>
/ </div>

/ Переопределение дефолтных значений
= define_component tag: :div, js: true, bem: true do |component|
  = component.block :block1, js: false
  = component.block :block2, js: false do |block2|
    = block2.elem :elem

/ =>
/ <div class="block1"></div>
/ <div class="block2">
/   <div data-bem="{"block2__elem":{}}" class="block2__elem i-bem"></div>
/ </div>
```
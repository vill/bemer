# Хелпер component_partial_path

Хелпер `component_partial_path` возвращает путь до партиала (partial) в каталоге компонента. При вызове хелпера необходимо передать название партиала (partial).

Для примеров используется следующая файловая структура:

```
app/
  ├── bemer_components/
  |     ├── image_gallery/
  |     |     ├── _image.html.slim
  |     |     ├── index.html.slim
  |     |     ├── index.js
  |     |     ├── index.scss
  |     |     └── ...
  └── ...
```

## Использование

```slim
/ app/bemer_components/image_gallery/index.html.slim

= component_partial_path(:image) / => 'image_gallery/image'

= render component_partial_path(:image)

```

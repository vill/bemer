# Хелпер component_asset_path

**ВАЖНО**. *Необходимо делать прекомпиляцию ресурсов, с помощью `sprockets` или `webpacker`.*

Хелпер `component_asset_path` возвращает путь до ресурса (asset) компонента: изображения, файла и т.д. При вызове, хелперу необходимо передать название ресурса (asset).

Для примеров используется следующая файловая структура:

```
app/
  ├── bemer_components/
  |     ├── image_gallery/
  |     |     ├── images/
  |     |     |     ├── placeholder.jpg
  |     |     |     └── ...  
  |     |     ├── _image.html.slim
  |     |     ├── index.html.slim
  |     |     ├── index.js
  |     |     ├── index.scss
  |     |     └── ...
  |     ├── user_profile/
  |     |     ├── images/
  |     |     |     ├── placeholder.jpg
  |     |     |     └── ...
  |     |     ├── index.html.slim
  |     |     ├── index.js
  |     |     ├── index.scss
  |     |     └── ...
  |     └── ...
  ├── views/
  |     ├── users/
  |     |     ├── show.html.slim
  |     |     └── ...
  |     ├── images/
  |     |     ├── index.html.slim
  |     |     └── ...
  |     └── ...
  └── ...
```

## Использование

```slim
/ app/bemer_components/user_profile/index.html.slim

= component_asset_path('images/placeholder.jpg') / => 'user_profile/images/placeholder.jpg'
= component_asset_path('image_gallery/images/placeholder.jpg') / => 'image_gallery/images/placeholder.jpg'

```

```slim
/ app/bemer_components/image_gallery/_image.html.slim

= component_asset_path('images/placeholder.jpg') / => 'image_gallery/images/placeholder.jpg'
= component_asset_path('user_profile/images/placeholder.jpg') / => 'user_profile/images/placeholder.jpg'

```

```slim
/ app/views/users/show.html.slim

= component_asset_path('user_profile/images/placeholder.jpg') / => 'user_profile/images/placeholder.jpg'

```

```slim
/ app/views/images/index.html.slim

= component_asset_path('image_gallery/images/placeholder.jpg') / => 'image_gallery/images/placeholder.jpg'

```
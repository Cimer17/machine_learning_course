# Глава 11. Keras и мобильные роботы

## Материалы

- `mobile_robot_dataset/` - готовый датасет для `tf.keras.utils.image_dataset_from_directory`.
- `mobile_robot_dataset/dataset_manifest.csv` - список изображений, классов и split-разметки.
- `assets/robot_assets_manifest.csv` - описание исходных ассетов.
- `assets/robot_assets_contact_sheet.jpg` - превью изображений.

## Классы

- `legged_robot`
- `tracked_robot`
- `wheeled_robot`

Датасет разложен по папкам `train`, `validation`, `test`. Его можно подключить в ноутбуке так:

```python
train_ds = tf.keras.utils.image_dataset_from_directory(
    "shared/chapters/11_keras_mobile_robot/mobile_robot_dataset/train",
    image_size=(128, 128),
    batch_size=12,
)
```

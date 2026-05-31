# Глава 12. YOLO

## Материалы

- `assets/mobile_robots_lab.jpg` - исходное изображение с мобильными роботами.
- `assets/yolo_robot_classes_annotated.jpg` - пример нанесенной разметки.
- `robot_yolo_dataset/` - минимальный датасет в формате YOLO.

Файл `robot_yolo_dataset/mobile_robots.yaml` описывает классы:

- `wheeled_robot`
- `tracked_robot`
- `legged_robot`

Мини-датасет нужен для проверки структуры и формата разметки. Для полноценного обучения его следует расширить большим количеством изображений.

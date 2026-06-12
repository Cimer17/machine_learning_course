# Datasets

This directory contains the datasets required by the course and the corrected пособие.

## Contents

| Path | Purpose | Format |
| --- | --- | --- |
| `st.csv` | Mobile robot tabular data for the CSV/Matplotlib example and figure 42. | CSV |
| `mobile_robot_classification/` | Keras image classification dataset: `legged_robot`, `tracked_robot`, `wheeled_robot`. | `train/validation/test/<class>/*.jpg` |
| `robot_types_detection/` | Minimal YOLO dataset for detecting robot types on the lab photo. | YOLO `images/`, `labels/`, `mobile_robots.yaml` |
| `mechanical_parts/` | Mechanical Parts Dataset 2022 from Zenodo, used as an external profile dataset for bearings, bolts, gears and nuts. | YOLO `train/val/test/images` + `labels` |

## Sources

- `mobile_robot_classification/`, `robot_types_detection/` and `st.csv` are course materials prepared from the local mobile robotics examples.
- `mechanical_parts/` is downloaded from Zenodo record `7504801`, DOI `10.5281/zenodo.7504801`, file `Mechanical Parts Dataset.rar`, MD5 `fc2bfa33c4d0439188cb5974694a4520`.

## Usage

For Keras classification with the course robot dataset:

```python
from pathlib import Path
import tensorflow as tf

dataset = Path("datasets/mobile_robot_classification")
train_ds = tf.keras.utils.image_dataset_from_directory(
    dataset / "train",
    image_size=(128, 128),
    batch_size=12,
)
```

For YOLO training or format checks:

```python
from ultralytics import YOLO

model = YOLO("yolov8n.pt")
model.train(data="datasets/robot_types_detection/mobile_robots.yaml", epochs=10, imgsz=640)
```

For the external mechanical parts dataset:

```python
from ultralytics import YOLO

model = YOLO("yolov8n.pt")
model.train(data="datasets/mechanical_parts/mech_parts_data.yaml", epochs=10, imgsz=640)
```

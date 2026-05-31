# Local package mirror

Эта папка описывает локальное зеркало Python-пакетов для курса.

## Что здесь лежит

- `requirements.lock.txt` - прямые зависимости курса с зафиксированными версиями.
- `constraints.txt` - те же ограничения для установки и скачивания.
- `packages_manifest.csv` - назначение каждого пакета.
- `wheelhouse/` - локальная папка для wheel-файлов.
- `build_mirror.ps1` - скачивает wheel-файлы в `wheelhouse`.
- `install_from_mirror.ps1` - создает виртуальное окружение и ставит пакеты из `wheelhouse`.

Wheel-файлы TensorFlow, YOLO и PyTorch-зависимостей могут занимать сотни мегабайт. Поэтому в репозитории зафиксированы версии, инструкции и папка зеркала, а сам `wheelhouse` заполняется командой ниже на машине с доступом к интернету.

## Создать зеркало

Рекомендуется Python 3.12.

```powershell
cd C:\Users\ivank\OneDrive\Desktop\machine_learning_course
.\shared\package_mirror\build_mirror.ps1 -Python py -PythonArgs "-3.12"
```

Если команда `py -3.12` недоступна, укажите путь к нужному Python:

```powershell
.\shared\package_mirror\build_mirror.ps1 -Python "C:\Python312\python.exe"
```

После скачивания в `shared/package_mirror/wheelhouse` появятся wheel-файлы и `wheelhouse_inventory.csv` со списком локальных пакетов.

## Установить из зеркала

```powershell
cd C:\Users\ivank\OneDrive\Desktop\machine_learning_course
.\shared\package_mirror\install_from_mirror.ps1 -Python py -PythonArgs "-3.12"
```

Скрипт создаст `.venv`, установит пакеты только из локального `wheelhouse` и зарегистрирует Jupyter kernel `machine-learning-course`.

## Подключить зеркало вручную

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --no-index --find-links .\shared\package_mirror\wheelhouse -r .\shared\package_mirror\requirements.lock.txt -c .\shared\package_mirror\constraints.txt
python -m ipykernel install --user --name machine-learning-course --display-name "Machine Learning Course"
```

## Временно настроить pip на локальное зеркало

```powershell
pip config set global.no-index true
pip config set global.find-links "C:\Users\ivank\OneDrive\Desktop\machine_learning_course\shared\package_mirror\wheelhouse"
```

Вернуть обычную установку из интернета:

```powershell
pip config unset global.no-index
pip config unset global.find-links
```

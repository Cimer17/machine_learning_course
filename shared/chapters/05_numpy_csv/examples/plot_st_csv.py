import csv
from pathlib import Path

import matplotlib.pyplot as plt


csv_path = Path(__file__).with_name("st.csv")

masses = []
speeds = []
platforms = []

with csv_path.open(encoding="utf-8", newline="") as file:
    reader = csv.DictReader(file)
    for row in reader:
        masses.append(float(row["mass"]))
        speeds.append(float(row["speed"]))
        platforms.append(row["platform"])

colors = {
    "wheeled": "#1f77b4",
    "tracked": "#2ca02c",
    "legged": "#d62728",
}

fig, ax = plt.subplots(figsize=(8, 5))
for platform in sorted(set(platforms)):
    xs = [mass for mass, item_platform in zip(masses, platforms) if item_platform == platform]
    ys = [speed for speed, item_platform in zip(speeds, platforms) if item_platform == platform]
    ax.scatter(xs, ys, label=platform, color=colors.get(platform), alpha=0.8)

ax.set_title("Мобильные роботы: масса и максимальная скорость")
ax.set_xlabel("Масса, кг")
ax.set_ylabel("Максимальная скорость, м/с")
ax.grid(True, alpha=0.3)
ax.legend(title="Платформа")

fig.tight_layout()
plt.show()

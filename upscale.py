import os
from PIL import Image

input_dir = "./assets/1x/"
output_dir = "./assets/2x/"
upscaled = 0
deleted = 0

os.makedirs(output_dir, exist_ok=True)

for filename in os.listdir(output_dir):
    file = os.path.join(output_dir, filename)
    if os.path.exists(file):
        try:
            os.remove(file)
        except:
            print(f"Failed to delete {file}, it's probably fine")
        deleted += 1

for filename in os.listdir(input_dir):
    if filename.endswith(".png"):
        input_path = os.path.join(input_dir, filename)
        output_path = os.path.join(output_dir, filename)

        img = Image.open(input_path)
        scaled_img = img.resize((img.width * 2, img.height * 2), Image.NEAREST)
        scaled_img.save(output_path)

        upscaled += 1

print(f"Deleted {deleted} 2x files.")
print(f"Upscaled {upscaled} 1x files.")

import sys
sys.exit(0)
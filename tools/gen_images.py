from PIL import Image
from PIL import ImageDraw
from PIL import ImageFont

import os

img_size = (1024,1024)
img_folder = "images/"
img_filename = "sample-"
img_extension = ".jpg"

android_folder = "/sdcard/Pictures/test"

def transfer_image_to_android(img_name):
    os.system("adb push " + img_name + " /sdcard/Pictures")

def generate_image(str_text):
    background_color = (224,234,241)
    im = Image.new('RGB', img_size, background_color)
    draw = ImageDraw.Draw(im)
    text_color = (0,0,0)
    text_pos = (200,200)
    text = str_text
    font = ImageFont.truetype("open-sans/OpenSans-Bold.ttf", 150);
    draw.text(text_pos, text, fill=text_color, font=font)
    del draw
    img_name = img_folder + img_filename + str_text + img_extension
    im.save(img_name)
    transfer_image_to_android(img_name)

def generate_batch_images(max_images):
    for i in range(0, max_images):
        if i < 10:
            generate_image("000" + str(i))
        elif i < 100:
            generate_image("00" + str(i))
        elif i < 1000:
            generate_image("0" + str(i))
        else:
            generate_image("" + str(i))

generate_batch_images(200)
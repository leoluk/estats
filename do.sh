#!/bin/bash
set -euo pipefail

cat login_msg.bin | nc -q -1 $1 9000 | ffmpeg -t 1 -i - -y -vframes 1 pic.png
gimp --no-interface --no-splash --no-data --no-fonts --batch-interpreter python-fu-eval -b 'img = pdb.gimp_file_load("pic.png", ""); drawable = pdb.gimp_image_get_active_layer(img); pdb.plug_in_retinex(img, drawable, 250, 3, 1, 0.3); pdb.file_png_save(img, drawable, "pic_retinex.png", "raw_filename", 0, 9, 0, 0, 0, 0, 0); pdb.gimp_quit(1)'
ssocr -d -1 -i 2 -D rotate 4 crop 130 100 85 50 pic_retinex.png 

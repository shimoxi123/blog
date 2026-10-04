#!/usr/bin/env fish

for img in (find content -type f -iname '*.jpg' -o -type f -iname '*.jpeg' -o -type f -iname '*.png' -o -type f -iname '*.webp')
    exiftool -all= -overwrite_original "$img"
end

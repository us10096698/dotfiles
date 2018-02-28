#!/bin/bash
# https://qiita.com/wonder_zone/items/f00de737fd2e1eeb6581

FILE="~/.pyenv/versions/anaconda3-5.1.0/lib/python3.6/site-packages/pip/_internal/download.py"
sed -i 's/(method, url, \*args, \*\*kwargs/(method, url, verify=False, \*args, \*\*kwargs/g' $FILE

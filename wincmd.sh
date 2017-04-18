#!/usr/bin/bash.exe

echo $@
cmd /C $@ | iconv -f cp932 -t utf-8


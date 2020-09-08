#!/bin/bash
lscpu | awk -F : '($1=="CPU MHz") {printf "%3.2fGHz\n", $2/1000}'

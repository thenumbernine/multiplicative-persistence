#!/usr/bin/env gnuplot
set style data lines
set terminal png size 1024 768
set output 'out.png'
plot 'out.txt' using 1:2 title 'steps', 'out.txt' using 1:3 title 'max'

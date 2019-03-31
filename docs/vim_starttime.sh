vim --startuptime ~/vim_startup.log

vim --startuptime ~/vim_startup.log && awk -F'[ /]' '/\.vim\/plugged/ {print $3,$12}' vim_startup.log | \
awk '{plug[$2]++; time[$2]+=$1} END {for (i in plug) {printf "%30s %20.3f ms\n", i, time[i] | "sort -k2nr"}}'

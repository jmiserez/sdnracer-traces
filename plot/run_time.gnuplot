
# AH: Some arts and crafts is needed to make this graph prettier!

set terminal pdfcairo font "Gill Sans,9" linewidth 2 rounded fontscale 1.0
set output "./figures/fig6_run_time.pdf"



set xtic scale 0 font ",8"

# Line style for axes
set style line 80 lt rgb "#808080"

# Line style for grid
set style line 81 lt 0  # dashed
set style line 81 lt rgb "#808080"  # grey
set grid ytics xtics  # draw lines for each ytics and mytics
set grid               # enable the grid


set datafile separator ','
set xlabel 'Time in seconds' offset 0,0.5                  # x-axis label
set ylabel 'CDF'      # y-axis label
set yrange [0:1.1]
set xrange [0:250]
#set xtics 1
set style func linespoints
#set logscale x

# Line styles: try to pick pleasing colors, rather
# than strictly primary colors or hard-to-see colors
# like gnuplot's default yellow.  Make the lines thick
# so they're easy to see in small plots in papers.
set style line 1 lt rgb "#A00000" lw 1
set style line 2 lt rgb "#00A000" lw 1
set style line 3 lt rgb "#5060D0" lw 1
set style line 4 lt rgb "#F25900" lw 1
set style fill solid 0.5 border

set key samplen 1 font ",8"
set key bottom right
#set key autotitle columnheader


plot  './benchmark_data/bench_cdf.csv' using 2:4 notitle with steps ls 2, '' using 2:4 title "Median time" with points ls 2, \
      '' using 3:5 notitle with steps ls 3, '' using 3:5 title "95th Percentile" with points ls 3
    
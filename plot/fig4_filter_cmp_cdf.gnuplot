
# AH: Some arts and crafts is needed to make this graph prettier!

set terminal pdfcairo font "Gill Sans,9" linewidth 2 rounded fontscale 1.0
set output "./figures/fig4_filter_cmp_cdf.pdf"



set xtic scale 0 font ",8"

# Line style for axes
set style line 80 lt rgb "#808080"

# Line style for grid
set style line 81 lt 0  # dashed
set style line 81 lt rgb "#808080"  # grey
set grid ytics xtics  # draw lines for each ytics and mytics
set grid               # enable the grid


set datafile separator ','
set ylabel 'CDF'                        # x-axis label
set xlabel '% of races reduced by each filter'   offset 0,0.5   # y-axis label
set yrange [0:1.1]
set xrange [0:1.1]
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
set key top left
set key autotitle columnheader


plot  './data/races_cdf.csv' using 1:2   notitle with steps ls 2, './data/races_cdf.csv' using 1:2 title "Commute" with points ls 2, \
      './data/races_cdf.csv' using 7:8   notitle with steps ls 3, './data/races_cdf.csv' using 7:8  title "Time Filter ({/Symbol d}=2)" with points ls 3, \
      './data/races_cdf.csv' using 31:32 notitle with steps ls 1, './data/races_cdf.csv' using 31:32  title "All filters" with points ls 1

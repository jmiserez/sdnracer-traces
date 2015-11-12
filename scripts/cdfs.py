#!/usr/bin/env python
from __future__ import division

import argparse
import csv
import glob

def get_column(matrix, i):
    return [row[i] for row in matrix]

timings = dict([(str(i), None) for i in range(0, 11)])
timings['inf'] = None

keys = {}
keys['Races'] = None
keys['Commute'] = None
keys['Harmful'] = []
keys['Covered'] = []
keys['num_time_filtered_races'] = []
tt = [i for i in range(0,11)]
tt.append('inf')
  
def read_matrix(filename):
    matrix = []
    with open(filename, 'r') as csvfile:
      rd = csv.reader(csvfile, delimiter=',')
      timings_header = rd.next()
      for k in timings:
        timings[k] = timings_header.index(k)

      header = rd.next()
      for k in keys:
        if keys[k] is None:
          keys[k] = header.index(k)
          continue
        last_index = 0
        for t in timings:
          i = header.index(k, last_index)
          keys[k].append(i)
          last_index = i +1 
      for row in rd:
        matrix.append(row)
    return matrix

def extract_data(matrix):
  races = get_column(matrix, keys['Races'])
  commute = get_column(matrix, keys['Commute'])
  races = [int(i) for i in races]
  commute = [int(i) for i in commute]
  covered = []
  harmful = []
  tfiltered = []
  total_reduction = []

  for i, t in enumerate(tt):
    harmful.append([int(v) for v in get_column(matrix, keys['Harmful'][i])])
    covered.append([int(v) for v in get_column(matrix, keys['Covered'][i])])
    tfiltered.append([int(v) for v in get_column(matrix, keys['num_time_filtered_races'][i])])
    x = [races[i] - harmful[-1][i] for i in range(len(harmful[-1]))]
    y = [tfiltered[-1][i] + covered[-1][i] + commute[i] for i in range(len(harmful[-1]))]
    for o,_ in enumerate(x):
      if x[o] != y[o]:
        print i, t
        print "Races", races[o]
        print "Commute", commute[o]
        print "Time", tfiltered[-1][o]
        print "covered", covered[-1][o]
        print "harmful", harmful[-1][o]
        print  "x[o] %d == y[o] %d " % (x[o], y[o])
        #assert x[o] == y[o], "x[o] %d == y[o] %d " % (x[o], y[o])
    #total_reduction.append([races[i] - harmful[-1][i] for i in range(len(harmful[-1]))])
    total_reduction.append([races[i] - harmful[-1][i] for i in range(len(harmful[-1]))])
  return races, commute, covered, harmful, tfiltered, total_reduction


def get_ratio(races, num_filtered):
  #return [races[i] / (races[i] - num_filtered[i]) for i in range(len(races))]
  return [num_filtered[i] / races[i] for i in range(len(races))]
     
def get_cdf(data):
  tmp = sorted(data)
  length = len(data)
  out = []
  for i, v in enumerate(tmp):
    point = (i +1) / length
    out.append(point)
  return tmp, out
  
def main(filename):
  matrix = read_matrix(filename)

  RACES, commute, covered, harmful, tfiltered, total_reduction = extract_data(matrix)
  races_commute = get_ratio(RACES, commute)
  #races_covered = get_ratio(RACES, covered[2])
  races_harmful = []
  races_tfiltered = []
  races_total = []
  races_covered = []
  
  for t in harmful:
    races_harmful.append(get_ratio(RACES, t))
  for t in tfiltered:
    races_tfiltered.append(get_ratio(RACES, t))
  for t in covered:
    races_covered.append(get_ratio(RACES, t))
  for t in total_reduction:
    races_total.append(get_ratio(RACES, t))
  
  time_cdfs = []
  for ft in races_tfiltered:
    x, y = get_cdf(ft)
    time_cdfs.append((x, y))
  
  covered_cdfs = []
  for ft in races_covered:
    x, y = get_cdf(ft)
    covered_cdfs.append((x, y))
  
  total_cdfs = []
  for ft in races_total:
    x, y = get_cdf(ft)
    total_cdfs.append((x, y))
  
  
  races_x,races_y = get_cdf(races_commute)
  covered_x,covered_y = get_cdf(races_covered)
  
    
  header = ['commute', 'cdf']
  for t in tt[0:12]:
    header.append('t=%s' % t)
    header.append('cdf')
  for t in tt[0:12]:
    header.append('total_t=%s' % t)
    header.append('cdf=%s' % t)
  for t in tt[0:12]:
    header.append('covered_t=%s' % t)
    header.append('cdf=%s' % t)
  print ','.join(header)
  for i in range(len(races_x)):
    row = []
    row.append(str(races_x[i]))
    row.append(str(races_y[i]))
    for time_x_y in time_cdfs[0:12]:
      row.append(str(time_x_y[0][i]))
      row.append(str(time_x_y[1][i]))
    for time_x_y in total_cdfs[0:12]:
      row.append(str(time_x_y[0][i]))
      row.append(str(time_x_y[1][i]))
    for time_x_y in covered_cdfs[0:12]:
      row.append(str(time_x_y[0][i]))
      row.append(str(time_x_y[1][i]))
    assert len(row) == len(header), "%d != %d" % (len(row), len(header))
    print ','.join(row)
    #print len(row)
    
if __name__ == '__main__':
  parser = argparse.ArgumentParser()
  parser.add_argument('filename')
  args = parser.parse_args()
  main(args.filename)
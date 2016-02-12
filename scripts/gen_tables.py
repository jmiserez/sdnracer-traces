#!/usr/bin/env python

#####################################################################
# Collect the data and generate the table used in the paper         #
#####################################################################

import argparse
import csv
import glob

def get_column(matrix, i):
    return [row[i] for row in matrix]


races_selected_keys = {}
races_selected_keys['App'] = None
races_selected_keys['Controller'] = None
races_selected_keys['Topology'] = None
races_selected_keys['rw_delta'] = None
races_selected_keys['alt_barr'] = None
races_selected_keys['num_read'] = None
races_selected_keys['num_writes'] = None
races_selected_keys['num_harmful'] = None
races_selected_keys['num_commute'] = None
races_selected_keys['num_races'] = None
races_selected_keys['num_covered'] = None
races_selected_keys['num_time_filtered_races'] = None
races_value_keys = ['rw_delta', 'num_covered', 'num_time_filtered_races', 'num_harmful' ]

races_special_keys= {}
races_special_keys['App'] = None
races_special_keys['Topology'] = None
races_special_keys['Controller'] = None
races_special_keys['num_writes'] = None
races_special_keys['num_read'] = None
races_special_keys['num_races'] = None
races_special_keys['num_commute'] = None
races_special_keys_order = ['App', 'Topology', 'Controller',  'num_writes', 'num_read', 'num_races', 'num_commute']


con_selected_keys = {}
con_selected_keys['App'] = None
con_selected_keys['Controller'] = None
con_selected_keys['Topology'] = None
con_selected_keys['rw_delta'] = None
con_selected_keys['alt_barr'] = None
con_selected_keys['num_per_pkt_races'] = None
con_selected_keys['num_per_pkt_inconsistent_covered'] = None
con_selected_keys['num_per_pkt_entry_version_race'] = None
con_selected_keys['num_per_pkt_inconsistent'] = None
con_selected_keys['num_per_pkt_inconsistent_no_repeat'] = None
con_selected_keys['num_versions'] = None
con_selected_keys['num_racing_versions'] = None

#con_value_keys = ['rw_delta', 'num_per_pkt_races', 'num_per_pkt_inconsistent_covered', 'num_per_pkt_entry_version_race', 'num_per_pkt_inconsistent',  'num_per_pkt_inconsistent_no_repeat', 'num_racing_versions']
con_value_keys = ['rw_delta', 'num_per_pkt_races', 'num_per_pkt_inconsistent_covered', 'num_per_pkt_entry_version_race',  'num_per_pkt_inconsistent', 'num_per_pkt_inconsistent_no_repeat', 'num_racing_versions']

con_special_keys= {}
con_special_keys['App'] = None
con_special_keys['Topology'] = None
con_special_keys['Controller'] = None
con_special_keys['num_versions'] = None
con_special_keys_order = ['App', 'Topology', 'Controller',  'num_versions']



total_selected_keys = {}
# General Info
total_selected_keys['App'] = None
total_selected_keys['Controller'] = None
total_selected_keys['Topology'] = None
total_selected_keys['rw_delta'] = None
total_selected_keys['alt_barr'] = None
# Operations and events
total_selected_keys['num_events'] = None
total_selected_keys['num_read'] = None
total_selected_keys['num_writes'] = None
# Races
total_selected_keys['num_races'] = None
total_selected_keys['num_commute'] = None
total_selected_keys['num_time_filtered_races'] = None
total_selected_keys['num_covered'] = None
total_selected_keys['num_harmful'] = None
# Consistent Update
total_selected_keys['num_versions'] = None
total_selected_keys['num_racing_versions'] = None
# Pack Incon.
total_selected_keys['num_pkts'] = None
total_selected_keys['num_per_pkt_races'] = None
total_selected_keys['num_per_pkt_inconsistent_covered'] = None
total_selected_keys['num_per_pkt_entry_version_race'] = None
total_selected_keys['num_per_pkt_inconsistent'] = None


total_value_keys = ['rw_delta', 'num_time_filtered_races', 'num_covered', 'num_harmful',
                      'num_versions', 'num_racing_versions', 
                      'num_pkts', 'num_per_pkt_races', 'num_per_pkt_inconsistent_covered', 'num_per_pkt_entry_version_race', 'num_per_pkt_inconsistent' ]

total_special_keys= {}
total_special_keys['App'] = None
total_special_keys['Topology'] = None
total_special_keys['Controller'] = None
total_special_keys['num_events'] = None
total_special_keys['num_writes'] = None
total_special_keys['num_read'] = None
total_special_keys['num_races'] = None
total_special_keys['num_commute'] = None
total_special_keys['num_versions'] = None
total_special_keys['num_pkts'] = None

total_special_keys_order = ['App', 'Topology', 'Controller',  'num_events', 'num_writes', 'num_read', 'num_races', 'num_commute']


def read_matrix(filename, special_keys, selected_keys, value_keys):
  matrix = []
  with open(filename, 'r') as csvfile:
    rd = csv.reader(csvfile, delimiter=',')
    header = rd.next()
    for i, key in enumerate(header):
      if key in selected_keys:
        selected_keys[key] = i
    matrix.append([header[selected_keys[i]] for i in value_keys])
    for row in rd:
      if row[2] == 'True':
        continue
      for k in special_keys:
        special_keys[k] = row[selected_keys[k]]
      matrix.append([row[selected_keys[i]] for i in value_keys])
  return matrix, special_keys


def summarize(matrix, special_keys, special_keys_order, summarize, filter_indcies=[2]):
  columns = []
  timings = None

  for i, k in enumerate(matrix[0]):
    column = get_column(matrix, i)
    if k == 'rw_delta':
      timings = column
    else:
      columns.append(column)


  used_keys = []
  values_rows = [[] for t in timings[1:]]
  for column in columns:
    used_keys.append(column[0])
    for i, v in enumerate(column[1:]):
      values_rows[i].append(v)

  timing_header = [['' for k in used_keys] for t in timings[1:]]
  for i, t in enumerate(timings[1:]):
     timing_header[i][0] = t
  subheader = [used_keys for t in timings[1:]]
  """
  if 'num_harmful' in used_keys and 'num_covered' in used_keys:
    i_harm = used_keys.index('num_harmful')
    i_covered = used_keys.index('num_covered')
    for i, v in enumerate(values_rows):
      values_rows[i][i_harm] = str(int(v[i_harm]) - int(v[i_covered]))
  """
  if summarize:
    summarize_timing_header = []
    summarize_subheader = []
    summarize_values_rows = []
    for i in filter_indcies:
      summarize_timing_header.append(timing_header[i])
      summarize_subheader.append(subheader[i])
      summarize_values_rows.append(values_rows[i])
    timing_header = summarize_timing_header
    subheader = summarize_subheader
    values_rows = summarize_values_rows
    num_races = None
    for kk in special_keys:
      if kk == 'num_races':
        num_races = float(special_keys[kk])
    if num_races:
      for i, h in enumerate(subheader):
        if 'num_harmful' not in h:
          break
        harmful_index = h.index('num_harmful')
        covered_index = h.index('num_covered')
        harmful = int(values_rows[i][harmful_index])
        covered = int(values_rows[i][covered_index])
        values_rows[i][harmful_index] = "%d (%.2f%%)" % (harmful, (float(harmful)/num_races) * 100) 

  timing_header = [val for sublist in timing_header for val in sublist]
  subheader = [val for sublist in subheader for val in sublist]
  values_rows = [val for sublist in values_rows for val in sublist]

  header = ['' for k in special_keys_order]
  header.extend(timing_header)
  second_header = [k for k in special_keys_order]
  second_header.extend(subheader)
  values = [special_keys[k] for k in special_keys_order]
  values.extend(values_rows)
  return header, second_header, values


def main(filename, total, consistency, time_filter, print_headers):
  
  if consistency:
    matrix, special_keys = read_matrix(filename, con_special_keys, con_selected_keys, con_value_keys)
    header, second_header, values = summarize(matrix, special_keys, con_special_keys_order, time_filter)
  if total:
    matrix, special_keys = read_matrix(filename, total_special_keys, total_selected_keys, total_value_keys)
    header, second_header, values = summarize(matrix, special_keys, total_special_keys_order, time_filter)
  else:
    matrix, special_keys = read_matrix(filename, races_special_keys, races_selected_keys, races_value_keys)
    header, second_header, values = summarize(matrix, special_keys, races_special_keys_order, time_filter)

  pretty_names = {}
  pretty_names['rw_delta'] = 't'
  pretty_names['num_per_pkt_races'] = 'Racing Pkts'
  pretty_names['num_per_pkt_inconsistent_covered'] = 'Covered'
  pretty_names['num_per_pkt_entry_version_race'] = '1st Switch'
  pretty_names['num_per_pkt_inconsistent'] = 'Incon.'
  pretty_names['num_per_pkt_inconsistent_no_repeat'] = 'Incon. Pkt. Sum'
  pretty_names['num_racing_versions'] = 'Incon. Upd.'
  
  pretty_names['num_writes'] = 'Writes'
  pretty_names['num_read'] = 'Reads'
  pretty_names['num_races'] = 'Races'
  pretty_names['num_commute'] = 'Commute'
  pretty_names['num_covered'] = 'Covered'
  pretty_names['num_harmful'] = 'Remaining'
  pretty_names['num_versions'] = 'Versions'
  pretty_names['num_events'] = 'Events'
  pretty_names['num_pkts'] = 'Pkts'
  if time_filter:
    pretty_names['num_time_filtered_races'] = 'Time'
    pretty_names['2'] = 'With Time Filter(delta=2)'
    pretty_names['inf'] = 'Without Time'

  for i, v in enumerate(header):
    if v in pretty_names:
      header[i] = pretty_names[v]
  for i, v in enumerate(second_header):
    if v in pretty_names:
      second_header[i] = pretty_names[v]
  if print_headers:
    print ','.join(header)
    print ','.join(second_header)
  print ','.join(values)



if __name__ == '__main__':
  parser = argparse.ArgumentParser()
  parser.add_argument('filename')
  parser.add_argument('-s', dest='summary', action='store_true', default=False, help='Generate only data for t=2 and t=inf')
  parser.add_argument('-p', dest='print_headers', action='store_true', default=False)
  parser.add_argument('-c', dest='consistency', action='store_true', default=False)
  parser.add_argument('-t', dest='total', action='store_true', default=False)
  args = parser.parse_args()
  main(args.filename, args.total, args.consistency, args.summary, args.print_headers)

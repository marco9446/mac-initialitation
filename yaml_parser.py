"""This module does blah blah."""

import yaml


with open('./program_list.yaml', 'r') as f:
  doc = yaml.load(f)


for el in doc:
  print (el['name'])
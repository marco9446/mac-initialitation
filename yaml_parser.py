"""
  This module install some useful stuff.
"""

import yaml
import sys
from subprocess import call
from program import Program

PLATFORM = sys.argv[1]


class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'



with open('./program_list.yaml', 'r') as f:
    doc = yaml.load(f)

for el in doc:

    # check if program can be installed on this platform
    if PLATFORM in el['os']:
        pr = Program(el, PLATFORM)
        pr.installModule()
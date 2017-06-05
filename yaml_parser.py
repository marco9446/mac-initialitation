"""
  This module install some useful stuff.
"""

import yaml
import sys
from subprocess import call
from program import Program

PLATFORM = sys.argv[1]


with open('./program_list.yaml', 'r') as f:
    doc = yaml.load(f)

for el in doc:

    # check if program can be installed on this platform
    if PLATFORM in el['os']:
        if (len(sys.argv) <= 2):
            pr = Program(el, PLATFORM)
            pr.installModule()
        else:
            if (el['name'] == sys.argv[2]):
                pr = Program(el, PLATFORM)
                pr.installModule()
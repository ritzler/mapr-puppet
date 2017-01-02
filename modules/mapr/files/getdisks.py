#!/usr/bin/env python

import json
import subprocess
from subprocess import PIPE

p = subprocess.Popen(['facter','--json'],stdout=PIPE,stdin=PIPE)
facter = json.load(p.stdout)

disks = []
for d in facter['disks']:
   if d.startswith('sd'):
      disks.append(d)

partitions = [p for p in facter['partitions']]

freedisks = set([d for d in disks if not p.startswith('/dev/' + d) for p in partitions])

with open('/tmp/disks.txt','w') as disksfile:
   for d in freedisks:
      disksfile.write('/dev/' + d + '\n')

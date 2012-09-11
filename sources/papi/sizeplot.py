#! /usr/bin/env python

from __future__ import with_statement
import matplotlib
matplotlib.use('PDF')
import matplotlib.pyplot as plot
import sys
import re
import getopt

options,arguments = getopt.getopt(sys.argv[1:],"n:h")
n = 15
for o,v in options:
    if o=="-n":
        n = int(v)-1

if len(arguments)<1:
    print "Usage: "+sys.argv[0]+" fn"
    sys.exit(1)

infile = arguments[0].split('.')[0]
x = []; y = []; z = []; yy = []
with open(infile+".out") as results:
    for line in results:
        line = line.strip()
        if re.match("Run",line):
            datasetsize = line.split("=")[1]
            x.append(int(datasetsize)/1000)
        if re.search("L1 lines missed",line):
            miss = line.split(":")[1]
            y.append(miss)
        if re.search("L2 lines missed",line):
            miss = line.split(":")[1]
            z.append(miss)
        if re.match("cycles per",line):
            cyc = line.split(":")[1]
            yy.append(cyc)
x = x[:n]; y = y[:n]; z = z[:n]; yy = yy[:n]
plot.hold(True)

fig = plot.figure()
plot1 = fig.add_subplot(111)
plot1.set_xlabel("dataset size")
plot1.set_ylabel("Cache miss fraction")
for t in plot1.get_yticklabels():
    t.set_color('b')
plot1.plot(x,y,'b-')
plot1.plot(x,z,'b-*')

plot2 = plot1.twinx()
plot2.set_ylabel("cycles per op")
for t in plot2.get_yticklabels():
    t.set_color('r')
plot2.plot(x,yy,'r.')

plot.show()
plot.savefig(infile)


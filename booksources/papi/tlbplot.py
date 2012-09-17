#! /usr/bin/env python

from __future__ import with_statement
import matplotlib
matplotlib.use('PDF')
import matplotlib.pyplot as plot
import sys
import re
import getopt

options,arguments = getopt.getopt(sys.argv[1:],"h")
if len(arguments)<1:
    print "Usage: "+argv[0]+" fn"
    sys.exit(1)

infile = arguments[0].split('.')[0]
x = []; y = []; yy = []
with open(infile+".out") as results:
    for line in results:
        line = line.strip()
        if re.match("m,n",line):
            m,n = line.split("=")[1].split(",")
            x.append(n)
        if re.match("misses",line):
            miss = line.split(":")[1]
            y.append(miss)
        if re.match("Tot cycles",line):
            cyc = line.split(":")[1]
            yy.append(cyc)
plot.hold(True)

fig = plot.figure()
plot1 = fig.add_subplot(111)
plot1.set_xlabel("#columns")
plot1.set_ylabel("tlb misses / column")
for t in plot1.get_yticklabels():
    t.set_color('b')
plot1.plot(x,y,'b-')

plot2 = plot1.twinx()
plot2.set_ylabel("total cycles")
for t in plot2.get_yticklabels():
    t.set_color('r')
plot2.plot(x,yy,'r.')

plot.show()
plot.savefig(infile)


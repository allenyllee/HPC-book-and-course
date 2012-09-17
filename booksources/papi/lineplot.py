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
            stride = line.split("=")[1]
            x.append(stride)
        if re.match("accesses per miss",line):
            miss = line.split(":")[1]
            y.append(miss)
        if re.match("accesses per refill",line):
            miss = line.split(":")[1]
            z.append(miss)
        if re.match("Tot",line):
            cyc = line.split(":")[1]
            yy.append(str(int(cyc)/1000))
x = x[:n]; y = y[:n]; z = z[:n]; yy = yy[:n]
plot.hold(True)

fig = plot.figure()
plot1 = fig.add_subplot(111)
plot1.set_xlabel("stride")
plot1.set_ylabel("cache line utilization")
for t in plot1.get_yticklabels():
    t.set_color('b')
#plot1.plot(x,y,'b-')
plot1.plot(x,z,'b-')

plot2 = plot1.twinx()
plot2.set_ylabel("total kcycles")
for t in plot2.get_yticklabels():
    t.set_color('r')
plot2.plot(x,yy,'r.')

plot.show()
plot.savefig(infile)


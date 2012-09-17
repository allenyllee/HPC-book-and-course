#! /usr/bin/env python

from __future__ import with_statement
import matplotlib
matplotlib.use('PDF')
import matplotlib.pyplot as plot
import matplotlib.path as path
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
        if re.match("Run",line):
            m,n = line.split()[1].split(",")
            m = int(m); n = int(n)
        if re.match("misses",line):
            miss = line.split()[3].strip()
        if re.match("Tot cycles",line):
            cyc = float(line.split()[2].strip())
        if re.match("misses",line) and n==4096:
            print str(m)+" "+str(miss)+" "+str(cyc/(m*n))
            x.append(m); y.append(miss); yy.append(cyc/(m*n))
plot.hold(True)

fig = plot.figure()
plot1 = fig.add_subplot(111)
plot1.set_xlabel("#terms")
plot1.set_ylabel("L1 cache misses per column")
for t in plot1.get_yticklabels():
    t.set_color('b')
plot1.plot(x,y,'b-')
#misspath = path.Path([0,0],[x[len(x)-1],x[len(x)-1]])

plot2 = plot1.twinx()
plot2.set_ylabel("cycles per column")
for t in plot2.get_yticklabels():
    t.set_color('r')
plot2.plot(x,yy,'r.')

plot1.set_xlim(.5,x[len(x)-1]+.5)
plot2.set_ylim(0,max(yy)+.5)

plot.show()
plot.savefig(infile)


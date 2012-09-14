#   (c) Nicholas Dykeman 2012.

import numpy as np
print 'Welcome To GPS Plotter!'
print "Please enter the file name, including the .gpx, and make sure that"
print "it is located in the same folder as this program!"
fileName = raw_input()
currentLine = 0  #the line that we're currently on
wordsFound = 0   #the number of found words
amountOfLines = 0#the number of lines in the text
currentFoundWord = 0 #the word that were currently on from the found ones

for line in open(fileName):
        if "lat" in line:
            wordsFound+=1
            amountOfLines+=1
        else:
            amountOfLines +=1
print 'Words found: ', wordsFound
print 'Amount of Lines: ', amountOfLines
#this bit was to figure out how many words we have

linesX = []
linesLine = []
for line in open(fileName):
        if "lat" in line:
            currentFoundWord +=1
            currentLine +=1
            
            linesX.append(currentLine)
            linesLine.append(currentFoundWord)
            testLine = currentLine
        else:
            currentLine +=1
combined = []
for A, B in zip(linesLine, linesX):
    combined.append([A,B])
print
print 'Format: Word Number, Line Number:' #linesLine, linesX

for i in range(wordsFound):
    print combined[i]

# =======now we have all the necessary information to continue to
#trimming the lines, so we can grab the coordinates

print
print
print
#getting all the lats in an array
f=open(fileName)
lines=f.readlines()
L=[]
lon=[]
lat=[]
for i in range(len(linesLine)):
    print lines[linesX[i]-1],  ###testing

for i in range(len(linesLine)):
    lines[linesX[i]-1] = lines[linesX[i]-1][15:]
    lines[linesX[i]-1] = lines[linesX[i]-1][:24]
    lines[linesX[i]-1] = lines[linesX[i]-1].split('\"')    
    lat.append(lines[linesX[i]-1][0])
    lon.append(lines[linesX[i]-1][2])
for i in range(len(lat)):
    print 'Latitude: ',lat[i]
    print 'Longitude: ',lon[i]
print
print '======================================'
print
for i in range(len(lat)):
    print lat[i]

    
#########################################################3333
#uncomment the bottom part to get the lats and lons paired

#now we combine the lat & lon to get pairs
#LatLon = []
#for A,B in zip(lat, lon):
#   LatLon.append([A,B])
#for i in range(len(LatLon)):
#    print LatLon[i]  #gives us the combined values Format: Lat, Lon
###############################################################
from matplotlib.pyplot import *
from math import *
import numpy as np
plot(lon, lat)
xlabel('Longitude')
ylabel('Latitude')
title('Plotted Longitude & Latitude')
print '(c) Nicholas Dykeman 2012.'
show()
print '(c) Nicholas Dykeman 2012.'
close = raw_input("Press enter to close..")

###   (c) NMD 2012   ###

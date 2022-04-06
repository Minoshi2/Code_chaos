# Importing required libraries

import geocoder as geocoder
from googleplaces import GooglePlaces, types, lang
import webbrowser
import os
import folium as folium

# import requests
# import json

# This is the way to make api requests
# using python requests library

# send_url = 'http://freegeoip.net/json'
# r = requests.get(send_url)
# j = json.loads(r.text)
# print(j)
# lat = j['latitude']
# lon = j['longitude']
# print(lat,lon)


g = geocoder.ip("me")
print(g)

myAddress = g.latlng

myLatitude = g.lat
myLongitude = g.lng

# myLatitude = 6.680195
# myLongitude = 80.421186

print(myAddress)

# Generate an API key by going to this location
# https://cloud.google.com /maps-platform/places/?apis =
# places in the google developers

# Use your own API key for making api request calls
API_KEY = 'AIzaSyCkVPWRhFZRnDx5z8YnIhiUIEo7g-3OxYM'

# Initialising the GooglePlaces constructor
google_places = GooglePlaces(API_KEY)

# call the function nearby search with
# the parameters as longitude, latitude,
# radius and type of place which needs to be searched of
# type can be HOSPITAL, CAFE, BAR, CASINO, etc
query_result = google_places.nearby_search(
    # lat_lng ={'lat': 46.1667, 'lng': -1.15},
    lat_lng={'lat': myLatitude, 'lng': myLongitude},
    radius=1000,
    # types =[types.TYPE_HOSPITAL] or
    # [types.TYPE_CAFE] or [type.TYPE_BAR]
    # or [type.TYPE_CASINO])
    # types=[types.TYPE_HOSPITAL]
    types=[types.TYPE_CAFE]
)

# If any attributions related
# with search results print them
if query_result.has_attributions:
    print(query_result.html_attributions)

# Iterate over the search results
cafeLocations = []
cafeName = []
for place in query_result.places:
    # i = 1
    # while i < 6:
    #     print(i)
    #     i += 1

    cafeLocations.append(place.geo_location['lat'])
    cafeLocations.append(place.geo_location['lng'])
    cafeName.append(place.name)

    # print(cafeLocations)

    # print(type(place))
    # place.get_details()
    print(place.name)
    print("Latitude", place.geo_location['lat'])
    print("Longitude", place.geo_location['lng'])
    print()

# ///////////////////////////////////////////////////////////////
print(cafeLocations)
my_map1 = folium.Map(location=[myLatitude, myLongitude],
                     zoom_start=16)

folium.CircleMarker(location=myAddress,
                    radius=30, popup="My Location", color='red').add_to(my_map1)

folium.Marker([myLatitude, myLongitude],
              popup="My Location").add_to(my_map1)

print(len(cafeLocations))
i = 0
while i < (len(cafeLocations)) / 8:
    lat = cafeLocations[i + i]
    lng = cafeLocations[i + 1 + i]

    print(lat, lng)
    folium.Marker(([cafeLocations[i + i], cafeLocations[i + 1 + i]]),
                  popup=cafeName[i]).add_to(my_map1)
    # print(i)
    i += 1

# import codecs
#
# f = codecs.open("My_map.html", 'r')
# print(f.read())


my_map1.save("My_map.html")

# creating nd viewing the html files in python


# # to open/create a new html file in the write mode
# f = open('My_map.html', 'w')
#
# # the html code which will go in the file GFG.html
# html_template = """
# <html>
# <head></head>
# <body>
# <p>Geeks For Geeks</p>
#
# </body>
# </html>
# """
# # writing the code into the file
# f.write(html_template)
#
# # close the file
# f.close()

# 1st method how to open html files in chrome using
filename = 'file:///' + os.getcwd() + '/' + 'My_map.html'
webbrowser.open_new_tab(filename)

import tkinter as tk
from tkinter import *
from tkinter import ttk

# class karl(Frame):
#     def __init__(self):
#         tk.Frame.__init__(self)
#         self.pack()
#         self.master.title("Karlos")
#         self.button1 = Button(self, text="CLICK HERE", width=25,
#                               command=self.new_window)
#         self.button1.grid(row=0, column=1, columnspan=2, sticky=W + E + N + S)
#
#     def new_window(self):
#         # self.newWindow = karl2()
#         filename = 'file:///' + os.getcwd() + '/' + 'My_map.html'
#         webbrowser.open_new_tab(filename)
#
#
# class karl2(Frame):
#     def __init__(self):
#         new = tk.Frame.__init__(self)
#         new = Toplevel(self)
#         new.title("karlos More Window")
#         new.button = tk.Button(text="PRESS TO CLOSE", width=25,
#                                command=self.close_window)
#         new.button.pack()
#
#     def close_window(self):
#         self.destroy()
#
#
# def main():
#     karl().mainloop()
#
#
# if __name__ == '__main__':
#     main()


# import subprocess
#
# subprocess.Popen("C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe") #This will launch notepad But you
# can enter the path of an executable and this will launch it.


# File Name -- Map.py
# from gmplot import gmplot
#
# # Initialize the map at a given point
# gmap = gmplot.GoogleMapPlotter(myLatitude, myLongitude, 13)
#
# # Add a marker
# gmap.marker(myLatitude, myLongitude, 'cornflowerblue')
#
# # Draw map into HTML file
# gmap.draw("my_map.html")
###############################################################################################################
# browser module helps in open default web browser of os
# from webbrowser import open
# # sys contains command line arguments
# from sys import argv
# # To access clipboard
# from pyperclip import paste
#
# if len(argv) > 1:
#     address = " ".join(argv[1:])
# else:
#     address = paste()
# open("https://www.google.com/maps/place/" + address)
####################################################################################################


# Importing required libraries

import geocoder as geocoder
import webbrowser
import os
import folium as folium


g = geocoder.ip("me")
print(g)

myAddress = g.latlng

myLatitude = g.lat
myLongitude = g.lng

# myLatitude = 6.680195
# myLongitude = 80.421186

print(myAddress)


my_map1 = folium.Map(location=[myLatitude, myLongitude],
                     zoom_start=16)

folium.CircleMarker(location=myAddress,
                    radius=30, popup="My Location", color='red').add_to(my_map1)

folium.Marker([myLatitude, myLongitude],
              popup="My Location").add_to(my_map1)

my_map1.save("My_map.html")

# 1st method how to open html files in chrome using
filename = 'file:///' + os.getcwd() + '/' + 'My_map.html'
webbrowser.open_new_tab(filename)

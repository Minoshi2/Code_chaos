import subprocess
import time
from tkinter import *
from tkinter import messagebox

# creating Tk window
vrYes = 0
def showTKwindow():
    root = Tk()

    # setting geometry of tk window
    root.geometry("300x250")

    # Using title() to display a message in
    # the dialogue box of the message in the
    # title bar.
    root.title("Nearest Coffee shop")

    # Declaration of variables
    hour = StringVar()

    # setting the default value as 0
    hour.set("You Seems Drowsy")

    # Use of Entry class to take input from the user
    hourEntry = Entry(root, width=20, font=("Arial", 18, ""),
                      textvariable=hour)
    hourEntry.place(x=40, y=20)

    # vrYes = 0
    def nearestCoffee():
        global vrYes
        vrYes = 1
        root.destroy()
        root.mainloop()
        # subprocess.call(['python', 'LocationTracker.py'])

    # button widget0
    btn = Button(root, text="Nearest Coffee Shops", bd='10',
                 command=nearestCoffee)
    btn.place(x=50, y=80)

    # btn1 = Button(root, text="I do not feel drowsy", bd='10',
    #               command=root.destroy)
    # btn1.place(x=50, y=140)

    # infinite loop which is required to
    # run tkinter program infinitely
    # until an interrupt occurs
    root.mainloop()

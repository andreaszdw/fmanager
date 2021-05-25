#!/usr/bin/env python3

"""
    player_editor.py
"""

import tkinter as tk

class Main(tk.Frame):

    def __init__(self):
        super().__init__()
        self.initUI()


    def initUI(self):
        r = 0
        lbl_name = tk.Label(master=self, text="Name")
        lbl_name.grid(row=r, column=0, padx="5", pady="5")
        r += 1
        lbl_age = tk.Label(master=self, text="Age")
        lbl_age.grid(row=r, column=0, padx="5", pady="5")

        self.pack()

if __name__ == '__main__':
    root = tk.Tk()
    app = Main()
    root.mainloop()

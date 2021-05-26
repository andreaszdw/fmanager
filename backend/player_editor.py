#!/usr/bin/env python3

"""
    player_editor.py
"""

import tkinter as tk

class Main(tk.Frame):

    def __init__(self):
        super().__init__()
        # self.master.geometry("800x600")
        self.initUI()

    def initUI(self):
        name="Egal Egal"
        age=17
        contract=2
        salary=14000
        playerGrid = [(name, "name"),
                (age, "age"),
                (contract, "contract"),
                (salary, "salary")]

        r = 0
        for l in playerGrid:
            tmp_lbl = tk.Label(self, text=l[1])
            tmp_lbl.grid(row=r, column=0, padx="5", pady="5")
            tmp_ent = tk.Entry(self, width=50)
            tmp_ent.insert(0, l[0])
            tmp_ent.grid(row=r, column=1, padx=5, pady=5)
            r += 1

        self.pack()


if __name__ == '__main__':
    root = tk.Tk()
    app = Main()
    root.mainloop()

#!/usr/bin/env python3

"""
    playerEditor.py
"""
import wx
import wx.grid as gridlib

import playerTable
import player
import sqlite3

class Main(wx.Frame):

    def __init__(self, parent):
        super().__init__(parent, -1, "Player Editor", size=(800, 600))
        panel = wx.Panel(self, -1, style=0)

        colLabels = [
            "Name", "Alter", "Vertrag", "Gehalt", "image",
            "Fuss", "Position", "Fitness", "Schnelligkeit",
            "Ausdauer", "Passen", "Kopfball", "Schuss", "Zweikampf",
            "Taktik", "Potential", "Rating", "Experience", "id"]

        sql = "SELECT * FROM Player;"

        con = sqlite3.connect("player.db")
        cur = con.cursor()
        cur.execute(sql)

        data = cur.fetchall()

        self.playerGrid = playerTable.Grid(panel, colLabels, data)
        self.playerGrid.Bind(
            gridlib.EVT_GRID_CELL_LEFT_DCLICK,
            self.OnLeftDClick)

        boxSizer = wx.BoxSizer(wx.VERTICAL)
        boxSizer.Add(self.playerGrid, 1, wx.EXPAND | wx.ALL, 5)
        panel.SetSizer(boxSizer)

    def OnLeftDClick(self, event):
        print("here")
        print(self.playerGrid.getValue(event.GetRow(), 18))


if __name__ == '__main__':
    app = wx.App()
    frame = Main(None)
    frame.Show(True)
    app.MainLoop()

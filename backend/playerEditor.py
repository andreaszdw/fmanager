#!/usr/bin/env python3

"""
    playerEditor.py
"""
import wx
import wx.grid as gridlib

import playerTable
import playerDialog
import player
import sqlite3

class Main(wx.Frame):

    def __init__(self, parent):
        super().__init__(parent, -1, "Player Editor", size=(800, 600))
        panel = wx.Panel(self, -1, style=0)

        colLabels = [
            "id", "Name", "Land", "Alter", "Vertrag", "Gehalt", "image_id",
            "Fuss", "Position", "Fitness", "MaxFitness", "Schnelligkeit", "MaxSchnelligkeit",
            "Ausdauer", "MaxAusdauer", "Passen", "MaxPassen", "Kopfball", "MaxKopfball", 
            "Schuss", "MaxSchuss", "Zweikampf", "MaxZweikamp", "Taktik", "MaxTaktik", 
            "Potential", "Rating", "Experience"]

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
        print("click")
        p = player.Player()

        con = sqlite3.connect("player.db")
        cur = con.cursor()

        p.loadFromDBbyID(cur, self.playerGrid.getValue(event.GetRow(), 0))

        pd = playerDialog.PlayerDialog(None, title=p.name, player=p)
        pd.ShowModal()
        pd.Destroy


if __name__ == '__main__':
    app = wx.App()
    frame = Main(None)
    frame.Show(True)
    app.MainLoop()

#!/usr/bin/env python3

"""
    playerEditor.py
"""
import wx
import wx.grid as gridlib

import playerTable

class Main(wx.Frame):

    def __init__(self, parent):
        super().__init__(parent, -1, "Player Editor", size=(800, 600))
        panel = wx.Panel(self, -1, style=0)

        colLabels = [
            "Name", "Alter", "Vertrag", "Gehalt",
            "Fuss", "Position", "Fitness", "Schnelligkeit",
            "Ausdauer", "Passen", "Kopfball", "Schuss", "Zweikampf",
            "Taktik", "Potential", "Rating", "Experience"]

        dataTypes = [
            gridlib.GRID_VALUE_STRING,  # Name
            gridlib.GRID_VALUE_NUMBER,  # Alter
            gridlib.GRID_VALUE_NUMBER,  # Vertrag
            gridlib.GRID_VALUE_NUMBER,
            gridlib.GRID_VALUE_CHOICE,
            gridlib.GRID_VALUE_CHOICE,
            gridlib.GRID_VALUE_NUMBER,
            gridlib.GRID_VALUE_NUMBER,
            gridlib.GRID_VALUE_NUMBER,
            gridlib.GRID_VALUE_NUMBER,
            gridlib.GRID_VALUE_NUMBER,
            gridlib.GRID_VALUE_NUMBER,
            gridlib.GRID_VALUE_NUMBER,
            gridlib.GRID_VALUE_NUMBER,
            gridlib.GRID_VALUE_NUMBER,
            gridlib.GRID_VALUE_NUMBER,
            gridlib.GRID_VALUE_NUMBER
        ]

        data = [
            ["A", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            ["B", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            ["C", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        ]

        playerGrid = playerTable.Grid(panel, colLabels, dataTypes, data)
        playerGrid.Bind(gridlib.EVT_GRID_CELL_LEFT_DCLICK, self.OnLeftDClick)

        boxSizer = wx.BoxSizer(wx.VERTICAL)
        boxSizer.Add(playerGrid, 1, wx.EXPAND | wx.ALL, 5)
        panel.SetSizer(boxSizer)

    def OnLeftDClick(self, event):
        print("here")
        print(event.GetRow())


if __name__ == '__main__':
    app = wx.App()
    frame = Main(None)
    frame.Show(True)
    app.MainLoop()

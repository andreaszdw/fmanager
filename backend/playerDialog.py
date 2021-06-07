#!/usr/bin/env python3

"""
    playerDialog.py
"""
import wx
import player
import sqlite3

class PlayerDialog(wx.Dialog):

    def __init__(self, parent, playerId, title="Spieler Dialog"):
        super().__init__(parent, title=title)

        self.InitUI()

    def InitUI(self):

        panel = wx.Panel(self)
        sizer = wx.GridBagSizer(5, 5)

        self.name = wx.TextCtrl(panel)
        self.age = wx.TextCtrl(panel)
        self.contract = wx.TextCtrl(panel)
        self.salary = wx.TextCtrl(panel)
        self.foot = wx.TextCtrl(panel)
        self.position = wx.TextCtrl(panel)

        data = (
            ("Spieler Daten", "head"),
            ("Name", "tc", self.name),
            ("Alter", "tc", self.age),
            ("Vertrag", "tc", self.contract),
            ("Gehalt", "tc", self.salary),
            ("Fuss", "tc", self.foot),
            ("Position", "tc", self.position))

        pr = 0
        pc = 0

        for gData in data:
            if(gData[1] == "head"):
                tmpTxt = wx.StaticText(
                    panel, label=gData[0], style=wx.ALIGN_CENTER)
                sizer.Add(
                    tmpTxt, pos=(pr, pc), span=(1, 3),
                    flag=wx.ALL | wx.EXPAND, border=15)
                pr += 1

            if(gData[1] == "tc"):
                tmpTxt = wx.StaticText(panel, label=gData[0])
                sizer.Add(
                    tmpTxt, pos=(pr, pc), flag=wx.LEFT | wx.RIGHT, border=10)
                pc += 1

                sizer.Add(gData[2], pos=(pr, pc), flag=wx.RIGHT, border=25)
                pr += 1
                pc = 0

        panel.SetSizer(sizer)
        sizer.Fit(self)

class TestFrame(wx.Frame):

    def __init__(self, parent, title="TestFrame"):
        super().__init__(parent, title=title)

        # show the dialog
        pd = PlayerDialog(None, title="Spieler Dialog", playerId=1)
        pd.ShowModal()
        pd.Destroy


if __name__ == '__main__':
    app = wx.App()
    frame = TestFrame(None)
    frame.Show(True)
    app.MainLoop()

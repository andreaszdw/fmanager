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

        pr = 0
        pc = 0

        panel = wx.Panel(self)
        sizer = wx.GridBagSizer(5, 5)

        txtHeader = wx.StaticText(panel, label="Spielerdaten")
        sizer.Add(
            txtHeader, pos=(pr, pc), span=(1, 3),
            flag=wx.ALL | wx.EXPAND, border=15)
        pr += 1

        txtName = wx.StaticText(panel, label="Name")
        sizer.Add(txtName, pos=(pr, pc), flag=wx.LEFT, border=10)
        pc += 1

        tcName = wx.TextCtrl(panel)
        sizer.Add(tcName, pos=(pr, pc), flag=wx.EXPAND | wx.TOP)
        pr += 1
        pc = 0

        txtAge = wx.StaticText(panel, label="Alter")
        sizer.Add(
            txtAge, pos=(pr, pc), flag=wx.LEFT, border=10)
        pc += 1

        tcAge = wx.TextCtrl(panel)
        sizer.Add(tcAge, pos=(pr, pc), flag=wx.EXPAND | wx.TOP)
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

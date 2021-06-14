#!/usr/bin/env python3

"""
    playerDialog.py
"""
import wx
import player
import sqlite3
import pathlib

class PlayerDialog(wx.Dialog):

    def __init__(self, parent, player, title="Spieler Dialog"):
        super().__init__(parent, title=title)

        self.player = player

        self.InitUI()

    def InitUI(self):

        panel = wx.Panel(self)

        '''self.id = wx.TextCtrl(panel, value=str(self.player.id))
        self.name = wx.TextCtrl(panel, value=self.player.name)
        self.age = wx.TextCtrl(panel, value=str(self.player.age))
        self.contract = wx.TextCtrl(panel, value=str(self.player.contract))
        self.salary = wx.TextCtrl(panel, value=str(self.player.salary))
        self.foot = wx.TextCtrl(panel, value=str(self.player.foot))
        self.position = wx.TextCtrl(panel, value=str(self.player.position))'''

        mainSizer = wx.BoxSizer(wx.HORIZONTAL)
        firstHBox = wx.BoxSizer(wx.HORIZONTAL)

        # the player image
        ip = pathlib.Path.cwd() / "assets" / "player" / self.player.imageFile

        pImage = wx.StaticBitmap(
            panel, bitmap=wx.Bitmap(str(ip), wx.BITMAP_TYPE_PNG))
        firstHBox.Add(pImage, flag=wx.EXPAND | wx.ALL, border=15)

        data = (
            ("Spieler ID", "tc"),  # self.id),
            ("Name", "tc"),  # self.name),
            ("Alter", "tc"),  # self.age),
            ("Vertrag", "tc"),  # self.contract),
            ("Gehalt", "tc"),  # self.salary),
            ("Fuss", "tc"),  # self.foot),
            ("Position", "tc"),  # self.position))
            ("sjdflaslfjsl", "tc"),
            ("sjflsflaslflasf", "tc"))

        firstVBox = wx.BoxSizer(wx.VERTICAL)

        for d in data:
            tmpTxt = wx.StaticText(panel, label=d[0])
            firstVBox.Add(
                tmpTxt, flag=wx.ALL | wx.EXPAND, border=5)

        firstHBox.Add(firstVBox, flag=wx.ALL | wx.EXPAND, border=5)
        mainSizer.Add(firstHBox, flag=wx.ALL | wx.EXPAND, border=10)
        mainSizer.Layout()

        panel.SetSizer(mainSizer)

        panelSizer = wx.BoxSizer(wx.VERTICAL)
        panelSizer.Add(panel)
        self.SetSizerAndFit(panelSizer)


class TestFrame(wx.Frame):

    def __init__(self, parent, title="TestFrame"):
        super().__init__(parent, title=title)

        p = player.Player()

        con = sqlite3.connect("player.db")
        cur = con.cursor()

        p.loadFromDBbyID(cur, 1)

        # show the dialog
        pd = PlayerDialog(None, title="Spieler Dialog", player=p)
        pd.ShowModal()
        pd.Destroy


if __name__ == '__main__':
    app = wx.App()
    frame = TestFrame(None)
    frame.Show(True)
    app.MainLoop()
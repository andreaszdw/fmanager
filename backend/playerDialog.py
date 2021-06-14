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

        self.id = wx.TextCtrl(panel, value=str(self.player.id))
        self.name = wx.TextCtrl(panel, value=self.player.name)
        self.age = wx.TextCtrl(panel, value=str(self.player.age))
        self.contract = wx.TextCtrl(panel, value=str(self.player.contract))
        self.salary = wx.TextCtrl(panel, value=str(self.player.salary))
        self.foot = wx.TextCtrl(panel, value=str(self.player.foot))
        self.position = wx.TextCtrl(panel, value=str(self.player.position))

        mainSizer = wx.BoxSizer(wx.HORIZONTAL)

        firstVBox = wx.BoxSizer(wx.VERTICAL)

        # the player image
        ip = pathlib.Path.cwd() / "assets" / "player" / self.player.imageFile

        '''pImage = wx.StaticBitmap(
            panel, bitmap=wx.Bitmap(str(ip), wx.BITMAP_TYPE_PNG))
        firstVBox.Add(pImage, flag=wx.ALL, border=5)'''

        data = (
            ("Spieler ID", "tc", self.id),
            ("Name", "tc", self.name),
            ("Alter", "tc", self.age),
            ("Vertrag", "tc", self.contract),
            ("Gehalt", "tc", self.salary),
            ("Fuss", "tc", self.foot),
            ("Position", "tc", self.position))

        firstHBox = wx.BoxSizer(wx.HORIZONTAL)

        for d in data:
            tmpTxt = wx.StaticText(panel, label=d[0])
            firstHBox.Add(
                tmpTxt, flag=wx.ALL | wx.EXPAND, border=5)


        firstVBox.Add(firstHBox, flag=wx.ALL | wx.EXPAND, border=5)


        mainSizer.Add(firstVBox, flag=wx.EXPAND, border=10)
        panel.SetSizerAndFit(mainSizer)

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

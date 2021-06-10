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

        pr = 0
        pc = 0

        gbSizer = wx.GridBagSizer(5, 5)

        ip = pathlib.Path.cwd() / "assets" / "player" / self.player.imageFile
        print(ip)

        pImage = wx.StaticBitmap(
            panel, bitmap=wx.Bitmap(str(ip), wx.BITMAP_TYPE_PNG))
        gbSizer.Add(pImage, pos=(pr, pc), flag=wx.ALL, border=5)

        panel.SetSizer(gbSizer)

        mainSizer = wx.BoxSizer(wx.VERTICAL)
        mainSizer.Add(panel, border=10)
        self.SetSizerAndFit(mainSizer)

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

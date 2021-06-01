#!/usr/bin/env python3

"""
    playerDialog.py
"""
import wx
import player
import sqlite3

class PlayerDialog(wx.Dialog):

    def __init__(self, parent, playerId, title="Spieler Dialog"):
        super().__init__(parent, title)


if __name__ == '__main__':
    app = wx.App()
    frame = PlayerDialog(None, 1)
    frame.Show(True)
    app.MainLoop()

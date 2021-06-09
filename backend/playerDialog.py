#!/usr/bin/env python3

"""
    playerDialog.py
"""
import wx
import player
import sqlite3

class PlayerDialog(wx.Dialog):

    def __init__(self, parent, player, title="Spieler Dialog"):
        super().__init__(parent, title=title)

        print(player.name)

        self.player = player

        self.InitUI()

    def InitUI(self):

        panel = wx.Panel(self)
        sizer = wx.GridBagSizer(5, 5)

        self.id = wx.TextCtrl(panel, value=str(self.player.id))
        self.name = wx.TextCtrl(panel, value=self.player.name)
        self.age = wx.TextCtrl(panel, value=str(self.player.age))
        self.contract = wx.TextCtrl(panel, value=str(self.player.contract))
        self.salary = wx.TextCtrl(panel, value=str(self.player.salary))
        self.foot = wx.TextCtrl(panel, value=str(self.player.foot))
        self.position = wx.TextCtrl(panel, value=str(self.player.position))
        self.fitness = wx.TextCtrl(panel, value=str(self.player.fitness))
        self.speed = wx.TextCtrl(panel, value=str(self.player.speed))
        self.stamina = wx.TextCtrl(panel, value=str(self.player.stamina))
        self.passing = wx.TextCtrl(panel, value=str(self.player.passing))
        self.header = wx.TextCtrl(panel, value=str(self.player.header))
        self.shot = wx.TextCtrl(panel, value=str(self.player.shot))
        self.tackle = wx.TextCtrl(panel, value=str(self.player.tackle))
        self.tactic = wx.TextCtrl(panel, value=str(self.player.tactic))
        self.potential = wx.TextCtrl(panel, value=str(self.player.potential))
        self.rating = wx.TextCtrl(panel, value=str(self.player.rating))
        self.experience = wx.TextCtrl(panel, value=str(self.player.experience))

        data = (
            ("Spieler Daten", "head"),
            ("Spieler ID", "tc", self.id),
            ("Name", "tc", self.name),
            ("Alter", "tc", self.age),
            ("Vertrag", "tc", self.contract),
            ("Gehalt", "tc", self.salary),
            ("Fuss", "tc", self.foot),
            ("Position", "tc", self.position),
            ("Fitness", "tc", self.fitness),
            ("Schnelligkeit", "tc", self.speed),
            ("Ausdauer", "tc", self.stamina),
            ("Passen", "tc", self.passing),
            ("Kopfball", "tc", self.header),
            ("Schuss", "tc", self.shot),
            ("Zweikampf", "tc", self.tackle),
            ("Taktik", "tc", self.tactic),
            ("Potenzial", "tc", self.potential),
            ("Rating", "tc", self.rating),
            ("Erfahrung", "tc", self.experience))

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

        p = player.Player()

        con = sqlite3.connect("player.db")
        cur = con.cursor()

        p.loadFromDBbyID(cur, 2)

        # show the dialog
        pd = PlayerDialog(None, title="Spieler Dialog", player=p)
        pd.ShowModal()
        pd.Destroy


if __name__ == '__main__':
    app = wx.App()
    frame = TestFrame(None)
    frame.Show(True)
    app.MainLoop()

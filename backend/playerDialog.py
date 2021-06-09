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

        static = wx.StaticBox(panel, -1, "Spielerdaten")
        sizer = wx.GridBagSizer(5, 5)

        self.id = wx.TextCtrl(static, value=str(self.player.id))
        self.image = wx.TextCtrl(static, value=str(self.player.imageFile))
        self.name = wx.TextCtrl(static, value=self.player.name)
        self.age = wx.TextCtrl(static, value=str(self.player.age))
        self.contract = wx.TextCtrl(static, value=str(self.player.contract))
        self.salary = wx.TextCtrl(static, value=str(self.player.salary))
        self.foot = wx.TextCtrl(static, value=str(self.player.foot))
        self.position = wx.TextCtrl(static, value=str(self.player.position))
        self.fitness = wx.TextCtrl(static, value=str(self.player.fitness))
        self.speed = wx.TextCtrl(static, value=str(self.player.speed))
        self.stamina = wx.TextCtrl(static, value=str(self.player.stamina))
        self.passing = wx.TextCtrl(static, value=str(self.player.passing))
        self.header = wx.TextCtrl(static, value=str(self.player.header))
        self.shot = wx.TextCtrl(static, value=str(self.player.shot))
        self.tackle = wx.TextCtrl(static, value=str(self.player.tackle))
        self.tactic = wx.TextCtrl(static, value=str(self.player.tactic))
        self.potential = wx.TextCtrl(static, value=str(self.player.potential))
        self.rating = wx.TextCtrl(static, value=str(self.player.rating))
        self.exp = wx.TextCtrl(static, value=str(self.player.experience))

        data = (
            ("Spieler Daten", "head"),
            ("Spieler ID", "tc", self.id),
            ("Bild", "tc", self.image),
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
            ("Erfahrung", "tc", self.exp))

        pr = 0
        pc = 0

        for gData in data:
            if(gData[1] == "head"):
                tmpTxt = wx.StaticText(
                    static, label=gData[0], style=wx.ALIGN_CENTER)
                sizer.Add(
                    tmpTxt, pos=(pr, pc), span=(1, 3),
                    flag=wx.ALL | wx.EXPAND, border=15)
                pr += 1

            if(gData[1] == "tc"):
                tmpTxt = wx.StaticText(static, label=gData[0])
                sizer.Add(
                    tmpTxt, pos=(pr, pc), flag=wx.LEFT | wx.RIGHT, border=10)
                pc += 1

                sizer.Add(gData[2], pos=(pr, pc), flag=wx.RIGHT, border=25)
                pr += 1
                pc = 0

        '''buttonBox = wx.BoxSizer(wx.HORIZONTAL)

        abortButton = wx.Button(panel, label="Abbrechen")
        saveButton = wx.Button(panel, label="Speichern")
        buttonBox.Add(abortButton, 0)
        buttonBox.Add(saveButton, 0)
        sizer.Add(buttonBox, pos=(pr, pc), span=(1, 3), flag=wx.RIGHT, border=10)'''
        static.SetSizer(sizer)
        sizer.Fit(self)
        static.Fit()

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

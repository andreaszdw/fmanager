#!/usr/bin/env python3

"""
    playerDialog.py
"""
import wx
import player
import sqlite3
import pathlib
from face import Face

class PlayerDialog(wx.Dialog):

    def __init__(self, parent, player, title="Spieler Dialog"):
        super().__init__(parent, title=title)

        self.player = player

        self.InitUI()

    def InitUI(self):

        panel = wx.Panel(self)

        mainGbs = wx.GridBagSizer(5, 5)  # this is the main gridbagsizer

        sRow = 0
        sCol = 0

        # here comes the player image
        con = sqlite3.connect("player.db")
        cur = con.cursor()

        face = Face()
        face.loadFromDBbyID(cur, self.player.image_id)

        # the image files
        path = pathlib.Path.cwd() / "faces" / "assets"
        headPath = path / face.head
        hairPath = path / face.hair
        browsPath = path / face.brows
        eyesPath = path / face.eyes
        nosePath = path / face.nose
        mouthPath = path / face.mouth

        # this is the bitmap
        w, h = 250, 250
        wh = w // 2
        hh = h // 2
        faceBitmap = wx.Bitmap(w, h)
        memDC = wx.MemoryDC()
        memDC.SelectObject(faceBitmap)

        self.headBmp = wx.Bitmap(str(headPath), wx.BITMAP_TYPE_PNG)
        x = self.headBmp.Width // 2
        y = self.headBmp.Height // 2
        memDC.DrawBitmap(self.headBmp, wh - x, hh - y)
        
        self.hairBmp = wx.Bitmap(str(hairPath), wx.BITMAP_TYPE_PNG)
        x = self.hairBmp.Width // 2
        y = self.hairBmp.Height // 2
        memDC.DrawBitmap(self.hairBmp, wh - x + face.hairX, hh - y - face.hairY)

        self.browsImage = wx.Image(str(browsPath), wx.BITMAP_TYPE_PNG)
        x = self.browsImage.Width // 2
        y = self.browsImage.Height //2
        self.leftBrowBmp = wx.Bitmap(self.browsImage)
        memDC.DrawBitmap(self.leftBrowBmp, wh - x + face.browsLX, hh - y - face.browsLY)
        self.rightBrowBmp = wx.Bitmap(self.browsImage.Mirror())
        memDC.DrawBitmap(self.rightBrowBmp, wh - x + face.browsRX, hh - y - face.browsRY)

        self.eyesBmp = wx.Bitmap(str(eyesPath), wx.BITMAP_TYPE_PNG)
        x = self.eyesBmp.Width // 2
        y = self.eyesBmp.Height //2
        memDC.DrawBitmap(self.eyesBmp, wh - x + face.eyesLX, hh - y - face.eyesLY)
        memDC.DrawBitmap(self.eyesBmp, wh - x + face.eyesRX, hh - y - face.eyesRY)

        self.noseBmp = wx.Bitmap(str(nosePath), wx.BITMAP_TYPE_PNG)
        x = self.noseBmp.Width // 2
        y = self.noseBmp.Height // 2
        memDC.DrawBitmap(self.noseBmp, wh - x + face.noseX, hh - y - face.noseY)

        self.mouthBmp = wx.Bitmap(str(mouthPath), wx.BITMAP_TYPE_PNG)
        x = self.mouthBmp.Width // 2
        y = self.mouthBmp.Height // 2
        memDC.DrawBitmap(self.mouthBmp, wh - x + face.mouthX, hh - y - face.mouthY)

        # the player image, add to mainGbs
        pImage = wx.StaticBitmap(panel, bitmap=wx.Bitmap(faceBitmap))
        mainGbs.Add(pImage, pos=(sRow, sCol), flag=wx.ALL, border=15)

        sCol += 1

        # new gridbagsizer for personal data
        pdGbs = wx.GridBagSizer(5, 5)

        # staticbox for personal data
        staticBoxPD = wx.StaticBoxSizer(wx.VERTICAL, panel, "Spielerdaten")

        # widgets for personal data
        self.id = wx.TextCtrl(panel, value=str(self.player.id))
        self.name = wx.TextCtrl(panel, value=self.player.name)
        self.country = wx.TextCtrl(panel, value=self.player.country)
        self.age = wx.TextCtrl(panel, value=str(self.player.age))
        self.contract = wx.TextCtrl(panel, value=str(self.player.contract))
        self.salary = wx.TextCtrl(panel, value=str(self.player.salary))
        self.foot = wx.TextCtrl(panel, value=str(self.player.foot))
        self.position = wx.TextCtrl(panel, value=str(self.player.position))
        self.potential = wx.TextCtrl(panel, value=str(self.player.potential))
        self.rating = wx.TextCtrl(panel, value=str(self.player.rating))

        data = (
            ("Spieler ID", "tc", self.id),
            ("Name", "tc", self.name),
            ("Land", "tc", self.country),
            ("Alter", "tc", self.age),
            ("Vertrag", "tc", self.contract),
            ("Gehalt", "tc", self.salary),
            ("Fuss", "tc", self.foot),
            ("Position", "tc", self.position),
            ("Potenzial", "tc", self.potential),
            ("Rating", "tc", self.rating))

        # let a function add the data
        self.addToGridBagSizer(panel, pdGbs, data)

        # add it into the staticbox
        staticBoxPD.Add(pdGbs, flag=wx.ALL, border=15)

        # add it to the mainGbs
        mainGbs.Add(staticBoxPD, pos=(sRow, sCol), flag=wx.ALL, border=5)

        # new row, col at 0
        sRow += 1
        sCol = 0

        # new gridbagsizer properties
        #propGbs = wx.GridBagSizer(5, 5)

        # new staticBox properties
        staticBoxProp = wx.StaticBoxSizer(wx.HORIZONTAL, panel, "Eigenschaften")

        # physical propertis
        propsGbs = wx.GridBagSizer(5, 5)

        # widgets for physProp
        self.fitness = wx.TextCtrl(panel, value=str(self.player.fitness))
        self.speed = wx.TextCtrl(panel, value=str(self.player.speed))
        self.stamina = wx.TextCtrl(panel, value=str(self.player.stamina))
        self.passing = wx.TextCtrl(panel, value=str(self.player.passing))
        self.header = wx.TextCtrl(panel, value=str(self.player.header))
        self.shot = wx.TextCtrl(panel, value=str(self.player.shot))
        self.tackle = wx.TextCtrl(panel, value=str(self.player.tackle))
        self.tactic = wx.TextCtrl(panel, value=str(self.player.tactic))

        props = (
            ("Fitness", "tc", self.fitness),
            ("Schnelligkeit", "tc", self.speed),
            ("Ausdauer", "tc", self.stamina),
            ("Passen", "tc", self.passing),
            ("Kopfball", "tc", self.header),
            ("Schuss", "tc", self.shot),
            ("Zweikampf", "tc", self.tackle),
            ("Taktik", "tc", self.tactic))

        # add it to the properties sizer
        self.addToGridBagSizer(panel, propsGbs, props)

        # add it to the staticbox
        staticBoxProp.Add(propsGbs, flag=wx.ALL | wx.EXPAND, border=5)

        # football football properties
        maxPropsGbs = wx.GridBagSizer(5, 5)

        self.maxFitness = wx.TextCtrl(panel, value=str(self.player.maxFitness))
        self.maxSpeed = wx.TextCtrl(panel, value=str(self.player.maxSpeed))
        self.maxStamina = wx.TextCtrl(panel, value=str(self.player.maxStamina))
        self.maxPassing = wx.TextCtrl(panel, value=str(self.player.maxPassing))
        self.maxHeader = wx.TextCtrl(panel, value=str(self.player.maxHeader))
        self.maxShot = wx.TextCtrl(panel, value=str(self.player.maxShot))
        self.maxTackle = wx.TextCtrl(panel, value=str(self.player.maxTackle))
        self.maxTactic = wx.TextCtrl(panel, value=str(self.player.maxTactic))

        maxProps = (
            ("Fitness (Max)", "tc", self.maxFitness),
            ("Schnelligkeit (Max)", "tc", self.maxSpeed),
            ("Ausdauer (Max)", "tc", self.maxStamina),
            ("Passen (Max)", "tc", self.maxPassing),
            ("Kopfball (Max)", "tc", self.maxHeader),
            ("Schuss (Max)", "tc", self.maxShot),
            ("Zweikampf (Max)", "tc", self.maxTackle),
            ("Taktik (Max)", "tc", self.maxTactic))

        self.addToGridBagSizer(panel, maxPropsGbs, maxProps)

        staticBoxProp.Add(maxPropsGbs, flag=wx.ALL | wx.EXPAND, border=5)

        # add it to the mainGbs
        mainGbs.Add(
            staticBoxProp, pos=(sRow, sCol), span=(1, 2),
            flag=wx.ALL | wx.EXPAND, border=5)

        sRow += 1

        # buttons
        buttonBox = wx.BoxSizer(wx.HORIZONTAL)

        saveButton = wx.Button(panel, wx.ID_ANY, "Speichern")
        buttonBox.Add(saveButton)
        abortButton = wx.Button(panel, wx.ID_ANY, "Abbrechen")
        buttonBox.Add(abortButton)

        mainGbs.Add(
            buttonBox, pos=(sRow, sCol), span=(1, 2),
            flag=wx.ALIGN_RIGHT, border=5)

        # set the panel sizer
        panel.SetSizer(mainGbs)

        # the sizer for the dialog
        mainSizer = wx.BoxSizer(wx.VERTICAL)
        mainSizer.Add(panel, flag=wx.ALL, border=5)
        self.SetSizerAndFit(mainSizer)

    def addToGridBagSizer(self, panel, gbs, data):
        tmpRow = 0
        tmpCol = 0

        for d in data:

            if(d[1]) == "spacer":
                tmpTxt = wx.StaticText(
                    panel, label=d[0], style=wx.ALIGN_CENTER)
                gbs.Add(
                    tmpTxt, pos=(tmpRow, tmpCol),
                    flag=wx.ALL | wx.EXPAND, border=0)
                tmpRow += 1

            if(d[1] == "head"):
                tmpTxt = wx.StaticText(
                    panel, label=d[0], style=wx.ALIGN_CENTER)
                font = wx.Font(
                    10, wx.FONTFAMILY_DEFAULT,
                    wx.FONTSTYLE_NORMAL, wx.FONTWEIGHT_BOLD)
                wx.Font()
                tmpTxt.SetFont(font)
                gbs.Add(
                    tmpTxt, pos=(tmpRow, tmpCol),
                    flag=wx.ALL | wx.EXPAND, border=5)
                tmpRow += 1

            if(d[1] == "tc"):
                tmpTxt = wx.StaticText(panel, label=d[0])
                gbs.Add(
                    tmpTxt, pos=(tmpRow, tmpCol), flag=wx.ALL, border=5)

                tmpCol += 1
                gbs.Add(d[2], pos=(tmpRow, tmpCol), flag=wx.RIGHT, border=5)
                tmpRow += 1
                tmpCol = 0


class TestFrame(wx.Frame):

    def __init__(self, parent, title="TestFrame"):
        super().__init__(parent, title=title)

        p = player.Player()

        con = sqlite3.connect("player.db")
        cur = con.cursor()

        p.loadFromDBbyID(cur, 120)

        # show the dialog
        pd = PlayerDialog(None, title="Spieler Dialog", player=p)
        pd.ShowModal()
        pd.Destroy


if __name__ == '__main__':
    app = wx.App()
    frame = TestFrame(None)
    frame.Show(True)
    app.MainLoop()

#!/usr/bin/python

from pathlib import Path
from random import randint
import sqlite3
import json
import pyglet


class Face(object):

    def __init__(self, head="", hair="", brows="", eyes="eyes", nose="nose", mouth="mouse"):
        self.head = ""
        self.hair = ""
        self.hairX = 0
        self.hairY = 0
        self.eyeBrows = ""
        self.eyes = ""
        self.nose = ""
        self.noseX = 0
        self.noseY = 0
        self.mouth = ""

def generate():
    imagesFile = Path.cwd() / "assets" / "facesImages.json"

    f = (open(imagesFile, "r"))
    images = json.load(f)

    # tint
    tintRi = str(randint(1, len(images["tints"])))
    tintKey = "tint" + tintRi
    noseKey = randint(0, len(images["tints"][tintKey]["nose"]) - 1)

    # hair
    hairRi = randint(0, len(images["hairs"]) - 1)

    tmpFace = Face()
    tmpFace.head = images["tints"][tintKey]["head"]
    tmpFace.hair = images["hairs"][hairRi]["image"]
    tmpFace.hairX = images["hairs"][hairRi]["x"]
    tmpFace.hairY = images["hairs"][hairRi]["y"]
    tmpFace.nose = images["tints"][tintKey]["nose"][noseKey]
    tmpFace.noseX = randint(-3, 3)
    tmpFace.noseY = randint(-3, 3)


    return tmpFace


class FaceWindow(pyglet.window.Window):

    def __init__(self):
        super(FaceWindow, self).__init__()

        f = generate()

        self.batch = pyglet.graphics.Batch()

        self.headGroup = pyglet.graphics.OrderedGroup(0)
        self.fgGroup = pyglet.graphics.OrderedGroup(1)

        self.createFace(f)

    def createFace(self, f):
        # the path of the images
        images = Path.cwd() / "assets"

        # calc the center
        center_x = self.width // 2
        center_y = self.height // 2

        # the head
        headImage = pyglet.image.load(images / f.head)
        headImage.anchor_x = headImage.width // 2
        headImage.anchor_y = headImage.height // 2        
        self.headSprite = pyglet.sprite.Sprite(headImage, batch=self.batch, x=center_x, y=center_y, group=self.headGroup)

        # the nose
        noseImage = pyglet.image.load(images / f.nose)
        noseImage.anchor_x = noseImage.width // 2
        noseImage.anchor_y = noseImage.height // 2
        self.noseSprite = pyglet.sprite.Sprite(noseImage, batch=self.batch, x=center_x+f.noseX, y=center_y+f.noseY, group=self.fgGroup)

        # the hair
        hairImage = pyglet.image.load(images / f.hair)
        hairImage.anchor_x = hairImage.width // 2
        hairImage.anchor_y = hairImage.height // 2

        self.hairSprite = pyglet.sprite.Sprite(hairImage, batch=self.batch, x=center_x+f.hairX, y=center_y+f.hairY, group=self.fgGroup)

    def on_draw(self):
        self.clear()
        self.batch.draw()
        

if __name__ == "__main__":

    window = FaceWindow()
    pyglet.app.run()
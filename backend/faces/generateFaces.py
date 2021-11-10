#!/usr/bin/python

from pathlib import Path
from random import randint
import sqlite3
import json
import pyglet


class Face(object):

    def __init__(self):
        self.id = None
        self.head = ""
        self.hair = ""
        self.hairX = 0
        self.hairY = 0
        self.brows = ""
        self.browsLX = 0
        self.browsLY = 0
        self.browsRX = 0
        self.browsRY = 0
        self.eyes = ""
        self.eyesLX = 0
        self.eyesLY = 0
        self.eyesRX = 0
        self.eyesRY = 0
        self.nose = ""
        self.noseX = 0
        self.noseY = 0
        self.mouth = ""
        self.mouthX = 0
        self.mouthY = 0

    def saveToDB(self, con, cur, id):
        sql = ""
        data = None

        # this is a new entry
        if id is None:
            sql = """
                INSERT INTO Faces
                (
                head, hair, hairX, hairY, brows, browsLX, browsLY, browsRX, browsRY,
                eyes, eyesLX, eyesLY, eyesRX, eyesRY, nose, noseX, noseY, mouth, mouthX, mouthY
                )
                VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
            """

            data = (
                self.head, self.hair, self.hairX, self.hairY, self.brows, self.browsLX, self.browsLY, self.browsRX,
                self.browsRY, self.eyes, self.eyesLX, self.eyesLY, self.eyesRX, self.eyesRY, self.nose, self.noseX,
                self.noseY, self.mouth, self.mouthX, self.mouthY
            )

        # this is an update
        else:
            sql = """
                UPDATE Faces SET
                head = ?, hair = ?, hairX = ?, hairY = ?, brows = ?, browsLX = ?, browsLY = ?,
                browsRX = ?, browsRY = ?, eyes = ?, eyesLX = ?, eyesLY = ?, eyesRX = ?, eyesRY = ?,
                nose = ?, noseX = ?, noseY = ?, mouth = ?, mouthX = ?, mouthY = ?,
                WHERE id = ?;
            """

            data = (
                self.head, self.hair, self.hairX, self.hairY, self.brows, self.browsLX, self.browsLY, self.browsRX,
                self.browsRY, self.eyes, self.eyesLX, self.eyesLY, self.eyesRX, self.eyesRY, self.nose, self.noseX,
                self.noseY, self.mouth, self.mouthX, self.mouthY, self.id
            )

        try:
            cur.execute(sql, data)
            con.commit()

        except con.Error as error:
            print("Failed to save face", error)


    def print(self):
        print(self.head)
        print(self.hair)

def generate():
    tmpFace = Face()
    
    imagesFile = Path.cwd() / "assets" / "facesImages.json"

    f = (open(imagesFile, "r"))
    images = json.load(f)

    # tint, head and nose
    tintRi = str(randint(1, len(images["tints"])))
    tintKey = "tint" + tintRi
    noseKey = randint(0, len(images["tints"][tintKey]["nose"]) - 1)
    tmpFace.head = images["tints"][tintKey]["head"]
    tmpFace.nose = images["tints"][tintKey]["nose"][noseKey]
    tmpFace.noseX = randint(-3, 3)
    tmpFace.noseY = randint(-3, 3) - 10

    # hair and brows
    hairRi = randint(0, len(images["hairs"]) - 1)
    counter = 0
    for h in images["hairs"]:
        if counter == hairRi:
            hairColor = h
        counter += 1
    hairKey = randint(0, len(images["hairs"][hairColor]["hair"]) - 1)

    tmpFace.hair = images["hairs"][hairColor]["hair"][hairKey]["image"]
    tmpFace.hairX = images["hairs"][hairColor]["hair"][hairKey]["x"]
    tmpFace.hairY = images["hairs"][hairColor]["hair"][hairKey]["y"]

    browKey = randint(0, len(images["hairs"][hairColor]["brows"]) - 1)
    tmpFace.brows = images["hairs"][hairColor]["brows"][browKey]
    tmpFace.browsLX = randint(-4, 4) - 30
    tmpFace.browsLY = randint(-4, 4) + 30
    tmpFace.browsRX = randint(-4, 4) + 30
    tmpFace.browsRY = randint(-4, 4) + 30

    # the eyes
    eyeKey = randint(0, len(images["eyes"]) - 1)
    tmpFace.eyes = images["eyes"][eyeKey]
    tmpFace.eyesLX = randint(-4, 4) - 30
    tmpFace.eyesLY = randint(-4, 4) + 10
    tmpFace.eyesRX = randint(-4, 4) + 30
    tmpFace.eyesRY = randint(-4, 4) + 10

    # the mouth
    mouthKey = randint(0, len(images["mouth"]) - 1)
    tmpFace.mouth = images["mouth"][mouthKey]
    tmpFace.mouthX = randint(-5, 5)
    tmpFace.mouthY = randint(-5, 5) - 40
    return tmpFace

def generate_faces():
    path = Path.cwd() / "names" / "assets" / "names"
    db = Path.cwd().parent / "player.db"

    # create db
    con = sqlite3.connect(db)
    cur = con.cursor()
    cur.execute(
        """
            CREATE TABLE IF NOT EXISTS "faces" (
            "id"    INTEGER,
            "head"  TEXT,
            "hair"  TEXT,
            "hairX" INTEGER,
            "hairY" INTEGER,
            "brows" TEXT,
            "browsLX" INTEGER,
            "browsLY" INTEGER,
            "browsRX" INTEGER,
            "browsRY" INTEGER,
            "eyes" TEXT,
            "eyesLX" INTEGER,
            "eyesLY" INTEGER,
            "eyesRX" INTEGER,
            "eyesRY" INTEGER,
            "nose" TEXT,
            "noseX" INTEGER,
            "noseY" INTEGER,
            "mouth" TEXT,
            "mouthX" INTEGER,
            "mouthY" INTEGER,
            PRIMARY KEY("id")
            )
        """
    )
    con.commit()

    for i in range(800):
        face = generate()
        face.saveToDB(con, cur, None)


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

        # the brows
        leftBrowsImage = pyglet.image.load(images / f.brows)
        leftBrowsImage.anchor_x = leftBrowsImage.width // 2
        leftBrowsImage.anchor_y = leftBrowsImage.height // 2
        self.browsSpriteLeft = pyglet.sprite.Sprite(leftBrowsImage, batch=self.batch, x=center_x+f.browsLX, y=center_y+f.browsLY, group=self.fgGroup)
        rightBrowsImage = leftBrowsImage.get_texture().get_transform(True)
        rightBrowsImage.anchor_x = rightBrowsImage.width // 2
        rightBrowsImage.anchor_y = rightBrowsImage.height // 2
        self.browsSpriteRight = pyglet.sprite.Sprite(rightBrowsImage, batch=self.batch, x=center_x+f.browsRX, y=center_y+f.browsRY, group=self.fgGroup)

        # the eyes
        eyeImage = pyglet.image.load(images / f.eyes)
        eyeImage.anchor_x = eyeImage.width // 2
        eyeImage.anchor_y = eyeImage.height // 2
        self.eyeSpriteLeft = pyglet.sprite.Sprite(eyeImage, batch=self.batch, x=center_x+f.eyesLX, y=center_y+f.eyesLY, group=self.fgGroup)
        self.eyeSpriteRight = pyglet.sprite.Sprite(eyeImage, batch=self.batch, x=center_x+f.eyesRX, y=center_y+f.eyesRY, group=self.fgGroup)

        # the mouth
        mouthImage = pyglet.image.load(images / f.mouth)
        mouthImage.anchor_x = mouthImage.width // 2
        mouthImage.anchor_y = mouthImage.height // 2
        self.mouthSprite = pyglet.sprite.Sprite(mouthImage, batch=self.batch, x=center_x+f.mouthX, y=center_y+f.mouthY, group=self.fgGroup)


    def on_draw(self):
        self.clear()
        self.batch.draw()
        

if __name__ == "__main__":

    generate_faces()
    #window = FaceWindow()
    #pyglet.app.run()
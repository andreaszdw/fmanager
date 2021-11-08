#!/usr/bin/python

from pathlib import Path
from random import randint
import sqlite3
import json


class face(object):

    def __init__(self, face="", hair="", brows="", eyes="eyes", nose="nose", mouth="mouse"):
        self.face = ""
        self.hair = ""
        self.eyeBrows = ""
        self.eyes = ""
        self.nose = ""
        self.mouth = ""

def generate():
    imagesFile = Path.cwd() / "assets" / "facesImages.json"

    f = (open(imagesFile, "r"))
    images = json.load(f)

    print(len(images["heads"]))

    for h in images["heads"]:
        

if __name__ == "__main__":

    generate()
#!/usr/bin/python

from pathlib import Path
import sqlite3


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

    def loadFromDBbyID(self, cur, id):
        sql = """
            SELECT * FROM faces WHERE id={};
        """.format(id)

        cur.execute(sql)
        p = cur.fetchone()

        if p:
            self.id = id
            self.head = p[1]
            self.hair = p[2]
            self.hairX = p[3]
            self.hairY = p[4]
            self.brows = p[5]
            self.browsLX = p[6]
            self.browsLY = p[7]
            self.browsRX = p[8]
            self.browsRY = p[9]
            self.eyes = p[10]
            self.eyesLX = p[11]
            self.eyesLY = p[12]
            self.eyesRX = p[13]
            self.eyesRY = p[14]
            self.nose = p[15]
            self.noseX = p[16]
            self.noseY = p[17]
            self.mouth = p[18]
            self.mouthX = p[19]
            self.mouthY = p[20]

    def print(self):
        print(self.head)
        print(self.hair)
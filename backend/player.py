#!/usr/bin/env python3

'''
    player class
'''
import sqlite3

class Player(object):

    def __init__(self):
        self.id = None
        self.name = "Empty"
        self.age = 0
        self.contract = 0
        self.salary = 0
        self.imageFile = "Empty"
        self.foot = 0
        self.position = "Empty"
        self.fitness = 8
        self.speed = 8
        self.stamina = 8
        self.passing = 8
        self.header = 8
        self.shot = 0
        self.tackle = 0
        self.tactic = 0
        self.potential = 0
        self.rating = 0
        self.experience = 0

    def loadFromDBbyID(self, cur, id):
        sql = """
            SELECT * FROM Player WHERE id={};
        """.format(id)

        cur.execute(sql)
        p = cur.fetchone()

        if p:
            self.id = id
            self.name = p[0]
            self.age = p[1]
            self.contract = p[2]
            self.salary = p[3]
            self.imageFile = p[4]
            self.foot = p[5]
            self.position = p[6]
            self.fitness = p[7]
            self.speed = p[8]
            self.stamina = p[9]
            self.passing = p[10]
            self.header = p[11]
            self.shot = p[12]
            self.tackle = p[13]
            self.tactic = p[14]
            self.potential = p[15]
            self.rating = p[16]
            self.experience = p[17]

    def saveToDB(self, con, cur, id):

        sql = ""
        data = None

        # this is a new entry
        if id is None:
            sql = """
                INSERT INTO Player
                (
                name, age, contract, salary, imageFile, foot,
                position, fitness, speed, stamina, passing,
                header, shot, tackle, tactic, potential, rating, experience
                )
                VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
            """

            data = (
                self.name, self.age, self.contract, self.salary,
                self.imageFile, self.foot, self.position, self.fitness,
                self.speed, self.stamina, self.passing, self.header,
                self.shot, self.tackle, self.tactic, self.potential,
                self.rating, self.experience
            )

        # this is an update
        else:
            sql = """
                UPDATE Player SET
                name = ?, age = ?, contract = ?, salary = ?, imageFile = ?,
                foot = ?, position = ?, fitness = ?, speed = ?, stamina = ?,
                passing = ?, header = ?, shot = ?, tackle = ?, tactic = ?,
                potential = ?, rating = ?, experience = ?
                WHERE id = ?;
            """

            data = (
                self.name, self.age, self.contract, self.salary,
                self.imageFile, self.foot, self.position, self.fitness,
                self.speed, self.stamina, self.passing, self.header,
                self.shot, self.tackle, self.tactic, self.potential,
                self.rating, self.experience, self.id
            )

        try:
            cur.execute(sql, data)
            con.commit()

        except con.Error as error:
            print("Failed to save player", error)

    def print(self):
        print("ID:             {}".format(self.id))
        print("Name:           {}".format(self.name))
        print("Alter:          {}".format(self.age))
        print("Vertrag:        {}".format(self.contract))
        print("Gehalt:         {}".format(self.salary))
        print("Bild-Datei:     {}".format(self.imageFile))
        print("Fuss:           {}".format(self.foot))
        print("Position:       {}".format(self.position))
        print("Fitness:        {}".format(self.fitness))
        print("Schnelligkeit:  {}".format(self.speed))
        print("Ausdauer:       {}".format(self.stamina))
        print("Passen:         {}".format(self.passing))
        print("Kopfball:       {}".format(self.header))
        print("Schuss:         {}".format(self.shot))
        print("Zweikampf:      {}".format(self.tackle))
        print("Taktik:         {}".format(self.tactic))
        print("Potential:      {}".format(self.potential))
        print("Rating:         {}".format(self.rating))
        print("Erfahrung:      {}".format(self.experience))


if __name__ == '__main__':
    player = Player()

    con = sqlite3.connect("player.db")
    cur = con.cursor()

    player.loadFromDBbyID(cur, 3)

    player.name = "August Oyster"

    player.print()

    player.saveToDB(con, cur, player.id)

#!/usr/bin/env python3

'''
    player class
'''
import sqlite3

class Player(object):

    def __init__(self):
        self.id = None
        self.name = None
        self.country = None
        self.age = 0
        self.contract = 0
        self.salary = 0
        self.image_id = None
        self.foot = 0
        self.position = None
        self.fitness = 0
        self.maxFitness = 1.0
        self.stamina = 0
        self.maxStamina = 1.0
        self.speed = 0
        self.maxSpeed = 0
        self.passing = 0
        self.maxPassing = 0
        self.header = 0
        self.maxHeader = 0
        self.shot = 0
        self.maxShot = 0
        self.tackle = 0
        self.maxTackle = 0
        self.tactic = 0
        self.maxTactic = 0
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
            self.country = p[1]
            self.age = p[2]
            self.contract = p[3]
            self.salary = p[4]
            self.image_id = p[5]
            self.foot = p[6]
            self.position = p[7]
            self.fitness = p[8]
            self.maxFitness = p[9]
            self.speed = p[10]
            self.maxSpeed = p[11]
            self.stamina = p[12]
            self.maxStamina = p[13]
            self.passing = p[14]
            self.maxPassing = p[15]
            self.header = p[16]
            self.maxHeader = p[17]
            self.shot = p[18]
            self.maxShot = p[19]
            self.tackle = p[20]
            self.maxTackle = p[21]
            self.tactic = p[22]
            self.maxTactic = p[23]
            self.potential = p[24]
            self.rating = p[25]
            self.experience = p[26]

    def saveToDB(self, con, cur, id):

        sql = ""
        data = None

        # this is a new entry
        if id is None:
            sql = """
                INSERT INTO Player
                (
                name, country, age, contract, salary, image_id, foot,
                position, fitness, maxFitness, speed, maxSpeed,
                stamina, maxStamina, passing, maxPassing, 
                header, maxHeader, shot, maxShot, tackle, maxTackle,
                tactic, maxTactic, potential, rating, experience
                )
                VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
            """

            data = (
                self.name, self.country, self.age, self.contract, self.salary,
                self.image_id, self.foot, self.position, self.fitness, self.maxFitness,
                self.speed, self.maxSpeed, self.stamina, self.maxStamina, self.passing, 
                self.maxPassing, self.header, self.maxHeader, self.shot, self.maxShot,
                self.tackle, self.maxTackle,self.tactic, self.maxTactic, self.potential,
                self.rating, self.experience
            )

        # this is an update
        else:
            sql = """
                UPDATE Player SET
                name = ?, country = ?, age = ?, contract = ?, salary = ?, image_id = ?,
                foot = ?, position = ?, fitness = ?, maxFitness, speed = ?,
                maxSpeed = ?, stamina = ?, maxStamina = ?, passing = ?,
                maxPassing = ?,header = ?, maxHeader = ?, shot = ?, maxShot = ?,
                tackle = ?, maxTackle = ?, tactic = ?, maxTactic = ?, potential = ?,
                rating = ?, experience = ?
                WHERE id = ?;
            """

            data = (
                self.name, self.country, self.age, self.contract, self.salary, self.image_id,
                self.foot, self.position, self.fitness, self.maxFitness, self.speed,
                self.maxSpeed, self.stamina, self.maxStamina, self.passing, 
                self.maxPassing, self.header, self.maxHeader, self.shot, self.maxShot,
                self.tackle, self.maxTackle,self.tactic, self.maxTactic, self.potential,
                self.rating, self.experience, self.id
            )

        try:
            cur.execute(sql, data)
            con.commit()

        except con.Error as error:
            print("Failed to save player", error)

    def print(self):
        print("ID:                 {}".format(self.id))
        print("Name:               {}".format(self.name))
        print("Land:               {}".format(self.country))
        print("Alter:              {}".format(self.age))
        print("Vertrag:            {}".format(self.contract))
        print("Gehalt:             {}".format(self.salary))
        print("Bild-Datei:         {}".format(self.image_id))
        print("Fuss:               {}".format(self.foot))
        print("Position:           {}".format(self.position))
        print("Fitness:            {}".format(self.fitness))
        print("Fitness (m):        {}".format(self.maxFitness))
        print("Schnelligkeit:      {}".format(self.speed))
        print("Schnelligkeit (m):  {}".format(self.maxSpeed))
        print("Ausdauer:           {}".format(self.stamina))
        print("Ausdauer (m):       {}".format(self.maxStamina))
        print("Passen:             {}".format(self.passing))
        print("Passen (m):         {}".format(self.maxPassing))
        print("Kopfball:           {}".format(self.header))
        print("Kopfball (m):       {}".format(self.maxHeader))
        print("Schuss:             {}".format(self.shot))
        print("Schuss (m):         {}".format(self.maxShot))
        print("Zweikampf:          {}".format(self.tackle))
        print("Zweikampf (m):      {}".format(self.maxTackle))
        print("Taktik:             {}".format(self.tactic))
        print("Taktik (m):         {}".format(self.maxTactic))
        print("Potential:          {}".format(self.potential))
        print("Rating:             {}".format(self.rating))
        print("Erfahrung:          {}".format(self.experience))


if __name__ == '__main__':
    player = Player()

    con = sqlite3.connect("player.db")
    cur = con.cursor()

    player.loadFromDBbyID(cur, 3)

    player.name = "August Oyster"

    player.print()

    player.saveToDB(con, cur, player.id)

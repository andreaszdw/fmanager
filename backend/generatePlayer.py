#!/usr/bin/python

from pathlib import Path
from random import randint
from player import Player
import sqlite3

def generate_players():

    path = Path.cwd() / "assets" / "names"
    db = Path.cwd() / "player.db"

    # create db
    con = sqlite3.connect(db)
    cur = con.cursor()
    cur.execute(
        """
            CREATE TABLE IF NOT EXISTS "player" (
            "id"    INTEGER,
            "name"  TEXT,
            "country"   TEXT,
            "age"   INTEGER,
            "contract"  INTEGER,
            "salary"    INTEGER,
            "imageFile" TEXT,
            "foot"  TEXT,
            "position"  INTEGER,
            "fitness"   REAL,
            "maxFitness"    REAL,
            "speed" INTEGER,
            "maxSpeed"  INTEGER,
            "stamina"   INTEGER,
            "maxStamina"    INTEGER,
            "passing"   INTEGER,
            "maxPassing"    REAL,
            "header"    REAL,
            "maxHeader" REAL,
            "shot"  REAL,
            "maxShot"   REAL,
            "tackle"    REAL,
            "maxTackle" REAL,
            "tactic"    REAL,
            "maxTactic" REAL,
            "potential" REAL,
            "rating"    REAL,
            "experience"    INTEGER,
            PRIMARY KEY("id")
            )
        """
    )
    con.commit()

    players_list = path / "names"

    no = 800 # the number of players
    
    # the age from to
    age = (17, 29)

    # the number of player types
    # per team 3 goal, 8 defender, 9 midfileder, 5 attacker
    goal = 96
    defender = 256
    midfield = 288
    attacker = 160

    # which foot
    right_foot = 70 # 0 - 70
    left_foot = 90 # 71 - 90
    # the rest is both_foot
    
    # open file, read list, remove whitespace and split string    
    file = open(players_list, "r", encoding="UTF-8") # utf-8
    lines = file.readlines()
    lines = [line.rstrip() for line in lines] # remove whitespace characters
    lines = [line.split(" - ") for line in lines]

    # if no == "all", make list for complete list
    if no == "all":
        no = len(lines)

    # new player list
    players = list()

    for n in range(no):
        # pick one randomly and append in player list
        i = randint(0, len(lines) - 1)
        players.append(lines[i])
        del lines[i] # delete from names list, so there are no duplicates

    counter = 0
    for p in players:
        np = Player()
        np.name = p[0]
        np.country = p[1]
        np.age = randint(age[0], age[1])
        
        # calc the foot        
        foot = randint(0, 99)
        if foot < right_foot:
            t_foot = "r"
        if foot > right_foot and foot < left_foot:
            t_foot = "l"
        if foot > left_foot:
            t_foot = "b"
        np.foot = t_foot

        # position
        if counter < goal:
            np.position = "g"

        if counter > goal and counter < goal + defender:
            np.position = "d"

        if counter > goal + defender and counter < goal + defender + midfield:
            np.position = "m"

        if counter > goal + defender + midfield:
            np.position = "a"

        np.fitness = randint(3, 10) / 10

        np.maxStamina = randint(3, 10) / 10
        np.stamina = randint(2, np.maxStamina * 10) / 10

        np.maxSpeed = randint(3, 10) / 10
        np.speed = randint(2, np.maxSpeed * 10) / 10

        np.maxPassing = randint(3, 10) / 10
        np.passing = randint(2, np.maxPassing * 10) / 10

        np.maxHeader = randint(3, 10) / 10
        np.header = randint(2, np.maxHeader * 10) / 10

        np.maxShot = randint(3, 10) / 10
        np.shot = randint(2, np.maxShot * 10) / 10

        np.maxTackle = randint(3, 10) / 10
        np.tackle = randint(2, np.maxTackle * 10) / 10

        np.maxTactic = randint(3, 10) / 10
        np.tactic = randint(2, np.maxTactic * 10) / 10

        tmpMax = np.maxFitness + np.maxStamina + np.maxSpeed + np.maxPassing + np.maxHeader + np.maxShot + np.maxTackle + np.maxTactic
        tmpValues = np.fitness + np.stamina + np.speed + np.passing + np.header + np.shot + np.tackle + np.tactic
        np.potential = round(tmpMax / 8, 1)
        np.rating = round(tmpValues / 8, 1)

        np.saveToDB(con, cur, None)

        counter += 1
        
        np.print()
        print(" ")

    return players


if __name__ == "__main__":

    players = generate_players()
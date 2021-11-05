#!/usr/bin/python

from pathlib import Path
from random import randint
from player import Player

def generate_players():

    path = Path.cwd() / "assets" / "names"    
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

    # which foot, percentage
    right_foot = 70
    left_foot = 90
    
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

        counter += 1
        
        np.print()
        print(" ")

    return players


if __name__ == "__main__":

    players = generate_players()
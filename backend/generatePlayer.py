#!/usr/bin/python

from pathlib import Path
from random import randint
from player import Player

def generate_players():

    path = Path.cwd() / "assets" / "names"    
    players_list = path / "names"

    no = "all"
    
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

    for p in players:
        np = Player()
        np.name = p[0]
        np.country = p[1]
        np.print()
        print(" ")

    return players


if __name__ == "__main__":

    players = generate_players()
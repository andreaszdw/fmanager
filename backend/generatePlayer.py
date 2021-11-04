#!/usr/bin/python

from random import randint
from player import Player
from math import floor


class main():

    def __init__(self, no):

        self.no = no

        age_min_max = (17, 28)
        image = "empty"
        country_mix = (
            (60, "DE"),
            (10, "BR"),
            (15, "NL"),
            (30, "AT"))

        pos_mix = (
            (0.1, "k"),
            (0.3, "d"),
            (0.4, "m"),
            (0.2, "a"))

        self.d_names = self.generate_names()

        for n in self.names:
            p = Player()
            p.name = n
            p.age = randint(17, 28)
            p.image = image

    def generate_names(self):

        names = list()

        # read the file into list
        file_fn = open(self.first_list, "r", encoding="UTF-8") # utf-8
        f_lines = file_fn.readlines()
        f_lines = [line.rstrip() for line in f_lines] # remove whitespace characters
        n_f = len(f_lines) # the number of names

        file_ln = open(self.last_list, "r", encoding="UTF-8")
        l_lines = file_ln.readlines()
        l_lines = [line.strip() for line in l_lines]
        n_l =  len(l_lines)

        for no in range(0, self.no):
            first = f_lines[randint(0, n_f - 1)]
            last = l_lines[randint(0, n_l - 1)]
            names.append(first + " " + last)

        return names


if __name__ == "__main__":

    main(100)

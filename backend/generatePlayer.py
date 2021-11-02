#!/usr/bin/python

from random import randint


class main():

    def __init__(self):
        self.names = self.generate_names(100, "vornamen_d", "nachnamen_d")


    def generate_names(self, no=100, first_list="vornamen_d", last_list="nachnamen_d"):
        # names to generate
        # no_names = "max"
        no_names = no

        # files of first and lastnames
        first_names = first_list
        last_names = last_list
        names = list()

        # read the file into list
        file_fn = open(first_names, "r", encoding="UTF-8") # utf-8
        f_lines = file_fn.readlines()
        f_lines = [line.rstrip() for line in f_lines] # remove whitespace characters
        n_f = len(f_lines) # the number of names

        file_ln = open(last_names, "r", encoding="UTF-8")
        l_lines = file_ln.readlines()
        l_lines = [line.strip() for line in l_lines]
        n_l =  len(l_lines)

        if no_names == "max":
            no_names = n_l * n_f
            print(no_names)

        for no in range(0, no_names):
            first = f_lines[randint(0, n_f - 1)]
            last = l_lines[randint(0, n_l - 1)]
            names.append(first + " " + last)

        return names


if __name__ == "__main__":

    main()

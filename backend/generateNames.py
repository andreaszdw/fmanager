#!/usr/bin/python

from pathlib import Path
from random import randint

def generate_names(no, first, last, save=None):

        names = list()

        # read the file into list
        file_fn = open(first, "r", encoding="UTF-8") # utf-8
        f_lines = file_fn.readlines()
        f_lines = [line.rstrip() for line in f_lines] # remove whitespace characters
        n_f = len(f_lines) # the number of names

        file_ln = open(last, "r", encoding="UTF-8")
        l_lines = file_ln.readlines()
        l_lines = [line.strip() for line in l_lines]
        n_l =  len(l_lines)

        for no in range(0, no):
            first = f_lines[randint(0, n_f - 1)]
            last = l_lines[randint(0, n_l - 1)]
            names.append(first + " " + last)

        if save != None:
        	f = open(save, "w", encoding="UTF-8")
        	for n in names:
        		f.write(n + "\n")
        	f.close()

        return names


if __name__ == "__main__":

	path = Path.cwd() / "assets" / "names"

	first = path / "NL_first"
	last = path / "NL_last"

	save = path / "NL_names"

	names = generate_names(100, first, last, save)

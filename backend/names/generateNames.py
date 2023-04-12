#!/usr/bin/python

from pathlib import Path
from random import randint


def generate_names(no, first, last, nation, save=None):

    names = list()

    # read the file into list
    file_fn = open(first, "r", encoding="UTF-8")  # utf-8
    f_lines = file_fn.readlines()
    # remove whitespace characters
    f_lines = [line.rstrip() for line in f_lines]
    n_f = len(f_lines)  # the number of names

    file_ln = open(last, "r", encoding="UTF-8")
    l_lines = file_ln.readlines()
    l_lines = [line.strip() for line in l_lines]
    n_l = len(l_lines)

    for no in range(0, no):
        first = f_lines[randint(0, n_f - 1)]
        last = l_lines[randint(0, n_l - 1)]
        names.append(first + " " + last)

    # remove duplicates
    len(names) != len(set(names))

    if save is not None:
        f = open(save, "w", encoding="UTF-8")
        for n in names:
            f.write(n + " - " + nation + "\n")
        f.close()

    print(str(len(names)) + " Namen erstellt")

    return names


if __name__ == "__main__":

    path = Path.cwd() / "assets" / "names"

    no = 100
    first = path / "GB-ENG_first"
    last = path / "GB-ENG_last"
    nation = "GB-ENG"

    save = path / "GB-ENG_names"

    names = generate_names(no, first, last, nation, save)

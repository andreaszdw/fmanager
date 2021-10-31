#!/usr/bin/python

import sys
import getopt


help = '''
    Folgende Argumente:

        -n Anzahl der Spieler
'''

class main():

    def __init__(self, argv):
        if len(argv) == 0:
            print(help)

        opts, arg = getopt.getopt(argv, "n:o", [])
        for opt, arg in opts:
            if opt == "-n":
                print(arg)


if __name__ == "__main__":

    main(sys.argv[1:])

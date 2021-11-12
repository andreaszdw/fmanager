#!/usr/bin/env python3

'''
	Team class
'''


class Team(object):

	def __init__(self):

		self.player = []

	def addPlayer(self, player):

		self.player.appedn(player)
		
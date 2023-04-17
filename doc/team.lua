-- --------------------------------------------------------
--
-- team.lua
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------
local class = require("30log")

local team = class()

-- --------------------------------------------------------
--
-- constructor
--
-- --------------------------------------------------------
function team:init()
	-- this is a list of the players
	self.players = {}
end

-- --------------------------------------------------------
--
--  add player
--
-- --------------------------------------------------------
function team:addPlayer(p)
	table.insert(self.players, p)
end

-- --------------------------------------------------------
--
-- remove player
--
-- --------------------------------------------------------
function team:removePlayer(p)
	for k, v in next, self.players do
		if v == p then
			table.remove(k, self.players)
		end
	end
end

-- --------------------------------------------------------
return team
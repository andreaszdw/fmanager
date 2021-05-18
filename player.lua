-- --------------------------------------------------------
--
-- player.lua
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------

local player = {}

-- --------------------------------------------------------
--
-- constructor
--
-- --------------------------------------------------------
function player:new()

	local o = {
		name = name or "",
		age = age or 17, -- this is the normal starting age
		-- position skills - this is a star system
		keeper = keeper or 1,
		defender = defender or 1,
		midfielder = midfielder or 1,
		attacker = attacker or 1,
		-- sport skills - this is a percentage system
		fitness = fitness or 0.5,
		speed = speed or 0.5,
		stamina = stamina or 0.5,
		-- football skills - percentage
		passing = passing or 0.5,
		header = header or 0.5,
		shot = shot or 0.5,
		tackle = tackle or 0.5,
		tactic = tactic or 0.5,
		-- potential/rating - percentage
		potential = potential or 0.8, -- this is the possible rating
		rating = 0.3 -- rating
	}
	setmetatable(o, self)
	self.__index = self
	return o
end

-- --------------------------------------------------------
return player
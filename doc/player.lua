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
		name = name or "Egal Egal",
		age = age or 17, -- this is the normal starting age
		contract = contract or 3,
		salary = salary or 125000,
		imageFile = imageFile or "assets/images/player/BürgerLarsDietrich.png",
		foot = foot or "b",
		-- position 
		-- k = Keeper
		-- d = Defender
		-- m = Midfield
		-- a = Attacker
		position = position or "m",
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
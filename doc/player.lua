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
		fitness = fitness or 0.88,
		maxFitness = 1.0,
		stamina = stamina or 0.95,
		maxStamina = 1.0,
		-- football skills - percentage
		speed = speed or 0.65,
		maxSpeed = 0.95,
		passing = passing or 0.83,
		maxPassing = 0.9,
		header = header or 0.65,
		maxHeader = 0.7,
		shot = shot or 0.65,
		maxShot = 0.85,
		tackle = tackle or 0.35,
		maxTackle = 0.5,
		tactic = tactic or 0.85,
		maxTactic = 0.85,
		-- potential/rating - percentage
		potential = potential or 1.0, -- this is the possible rating
		rating = 0.5, -- rating
		experience = 0
	}
	setmetatable(o, self)
	self.__index = self
	return o
end

-- --------------------------------------------------------
--
-- load player from sqlite
--
-- --------------------------------------------------------
function player:loadFromDB(db, id)
	print("load")
end

-- --------------------------------------------------------
--
-- save player to sqlite
--
-- --------------------------------------------------------
function player:saveToDB(db, id)
	print("save")
end

-- --------------------------------------------------------
return player
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
		id = id or nil,
		name = name or "Egal Egal",
		age = age or 17, -- this is the normal starting age
		country = "DE",
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
		-- max... is the percentage, the player could reach
		fitness = fitness or 1.0,
		maxFitness = 1.0, -- this is always 1.0
		stamina = stamina or 1.0,
		maxStamina = 1.0, -- this is always 1.0
		-- football skills - percentage
		speed = speed or 1.0,
		maxSpeed = 1.0,
		passing = passing or 1.0,
		maxPassing = 1.0,
		header = header or 1.0,
		maxHeader = 1.0,
		shot = shot or 0.90,
		maxShot = 1.0,
		tackle = tackle or 0.9,
		maxTackle = 0.95,
		tactic = tactic or 0.2,
		maxTactic = 0.6,
		experience = 0
	}
	
	-- calc potential and rating
	tmpMax = o.maxFitness + o.maxStamina + o.maxSpeed + o.maxPassing + o.maxHeader + o.maxShot + o.maxTackle + o.maxTactic
	tmpValues = o.fitness + o.stamina + o.speed + o.passing + o.header + o.shot + o.tackle + o.tactic
	o.potential = tmpMax / 8
	o.rating = tmpValues / 8

	setmetatable(o, self)
	self.__index = self
	return o
end

-- --------------------------------------------------------
--
-- calc potential and rating of player
--
-- --------------------------------------------------------
function player:calcPotRat()
	tmpMax = self.maxFitness + self.maxStamina + self.maxSpeed + self.maxPassing + self.maxHeader + self.maxShot + self.maxTackle + self.maxTactic
	tmpValues = self.fitness + self.stamina + self.speed + self.passing + self.header + self.shot + self.tackle + self.tactic
	self.potential = tmpMax / 8
	self.rating = tmpValues / 8
end

-- --------------------------------------------------------
--
-- load player from sqlite
--
-- --------------------------------------------------------
function player:loadFromDB(db, id)
	print("load")
	self:calcPotRat()
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
-- --------------------------------------------------------
--
-- player.lua
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------
local class = require("30log")
local sqlite3 = require("sqlite3")

local player = class()

-- --------------------------------------------------------
--
-- constructor
--
-- --------------------------------------------------------
function player:init()

	self.id = id or nil
	self.name = name or "Empty Empty"
	self.age = age or 17 -- this is the normal starting age
	self.country = "DE"
	self.contract = contract or 3
	self.salary = salary or 125000
	self.imageFile = imageFile or "assets/images/player/BürgerLarsDietrich.png"
	self.foot = foot or "b"
	-- position 
	-- k = Keeper
	-- d = Defender
	-- m = Midfield
	-- a = Attacker
	self.position = position or "m"
	-- sport skills - this is a percentage system
	-- max... is the percentage, the player could reach
	self.fitness = fitness or 1.0
	self.maxFitness = 1.0 -- this is always 1.0
	self.stamina = stamina or 1.0
	self.maxStamina = 1.0 -- this is always 1.0
	-- football skills - percentage
	self.speed = speed or 0.5
	self.maxSpeed = 0.7
	self.passing = passing or 1.0
	self.maxPassing = 1.0
	self.header = header or 1.0
	self.maxHeader = 1.0
	self.shot = shot or 0.90
	self.maxShot = 1.0
	self.tackle = tackle or 0.9
	self.maxTackle = 0.95
	self.tactic = tactic or 0.2
	self.maxTactic = 0.5
	self.experience = 0
	
	-- calc potential and rating
	tmpMax = self.maxFitness + self.maxStamina + self.maxSpeed + self.maxPassing + self.maxHeader + self.maxShot + self.maxTackle + self.maxTactic
	tmpValues = self.fitness + self.stamina + self.speed + self.passing + self.header + self.shot + self.tackle + self.tactic
	self.potential = tmpMax / 8
	self.rating = tmpValues / 8
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

	local sql = [[SELECT * FROM Player WHERE id=]]..id..[[;]]

	function readPlayer(udata, cols, values, names)
		-- for i=1,cols do 
			-- print(i, names[i], values[i]) 
		--end
		self.id = values[1]
        self.name = values[2]
        self.country = values[3]
        self.age = values[4]
        self.contract = values[5]
        self.salary = values[6]
        self.image_id = values[7]
        self.foot = values[8]
        self.position = values[9]
        self.fitness = values[10]
        self.maxFitness = values[11]
        self.speed = values[12]
        self.maxSpeed = values[13]
        self.stamina = values[14]
        self.maxStamina = values[15]
        self.passing = values[16]
        self.maxPassing = values[17]
        self.header = values[18]
        self.maxHeader = values[19]
        self.shot = values[20]
        self.maxShot = values[21]
        self.tackle = values[22]
        self.maxTackle = values[23]
        self.tactic = values[24]
        self.maxTactic = values[25]
        self.potential = values[26]
        self.rating = values[17]
        self.experience = values[28]
        return sqlite3.OK
	end

	db:exec(sql, readPlayer)

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
--
-- print player
-- 
-- --------------------------------------------------------
function player:print()
	print("id: " .. self.id)
    print("name: " .. self.name)
    print("country: " .. self.country)
    print("age: " .. self.age)
    print("contract: " .. self.contract)
    print("salary: " .. self.salary)
    print("image_id: " .. self.image_id)
    print("foot: " .. self.foot)
    print("position: " .. self.position)
    print("fitness: " .. self.fitness)
    print("maxFitnes: " ..self.maxFitness)
    print("speed: " .. self.speed)
    print("maxSpeed: " .. self.maxSpeed)
    print("stamina: " .. self.stamina)
    print("maxStamina: " .. self.maxStamina)
    print("passing: " .. self.passing)
    print("maxPassing: " .. self.maxPassing)
    print("header: " .. self.header)
    print("maxHeader: " .. self.maxHeader)
    print("shot: " .. self.shot)
    print("maxShot: " .. self.maxShot)
    print("tackle: " .. self.tackle)
    print("maxTackle: " .. self.maxTackle)
    print("tactic: " .. self.tactic)
    print("maxTactic: ".. self.maxTactic)
    print("potential: " .. self.potential)
    print("rating: " .. self.rating)
    print("experience: " .. self.experience)
end

-- --------------------------------------------------------
return player
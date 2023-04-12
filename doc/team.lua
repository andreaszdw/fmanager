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

	self.keeper = {}
	self.defender = {}
	self.midfielder = {}
	self.attacker = {}
end

-- --------------------------------------------------------
return team
-- --------------------------------------------------------
--
-- club.lua
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------
local Class = require("30log")

local Club = Class()

-- --------------------------------------------------------
--
-- constructor
--
-- --------------------------------------------------------
function Club:init()

	self.name = name or "FC NRW"
	self.stadion = stadion
	self.coach = {}
	self.team = {}
	self.financial = {}
end

-- --------------------------------------------------------
return Club
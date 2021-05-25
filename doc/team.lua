-- --------------------------------------------------------
--
-- team.lua
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------

local team = {}

-- --------------------------------------------------------
--
-- constructor
--
-- --------------------------------------------------------
function club:new()

	local o = {
		keeper = {},
		defender = {},
		midfielder = {},
		attacker = {}
	}
	setmetatable(o, self)
	self.__index = self
	return o
end

-- --------------------------------------------------------
return club
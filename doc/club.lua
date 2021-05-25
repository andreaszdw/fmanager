-- --------------------------------------------------------
--
-- club.lua
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------

local club = {}

-- --------------------------------------------------------
--
-- constructor
--
-- --------------------------------------------------------
function club:new()

	local o = {
		name = name or "FC NRW",
		stadion = stadion,
		coach = {},
		team = {},
		financial = {}
	}
	setmetatable(o, self)
	self.__index = self
	return o
end

-- --------------------------------------------------------
return club
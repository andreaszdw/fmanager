-- --------------------------------------------------------
--
-- draw/face.lua
--
-- andreaszdw@googlemail.com
--
-- --------------------------------------------------------
local sqlite3 = require("sqlite3")

local face = {}

-- --------------------------------------------------------
--
-- constructor
--
-- --------------------------------------------------------
function face:new(parent, x, y, scale)

	local o = {
		parent = parent,
		x = x or 0,
		y = y or 0,
		scale = scale or 1,
	    id = id,
        head = "tint4_head.png",
        hair = "brown2Man1.png",
        hairX = 2,
        hairY = 49,
        brows = "brown2Brow2.png",
        browsLX = -32,
        browsLY = 34,
        browsRX = 33,
        browsRY = 31,
        eyes = "eyePine_small.png",
        eyesLX = -34,
        eyesLY = 9,
        eyesRX = 31,
        eyesRY = 14,
        nose = "tint4Nose3.png",
        noseX = -3,
        noseY = -11,
        mouth = "mouth_teethUpper.png",
        mouthX = 3,
        mouthY = -44,
        group = display.newGroup(),
        path = "assets\\images\\faces\\"
	}

	parent:insert(o.group)

	setmetatable(o, self)
	self.__index = self
	return o
end

-- --------------------------------------------------------
--
-- loadFromDB
--
-- --------------------------------------------------------
function face:loadFromDB(db, id)

	local sql = [[SELECT * FROM Faces WHERE id=]]..id..[[;]]

	function readFace(udata, cols, values, names)
		self.id = values[1]
        self.head = values[2]
        self.hair = values[3]
        self.hairX = values[4]
        self.hairY = values[5]
        self.brows = values[6]
        self.browsLX = values[7]
        self.browsLY = values[8]
        self.browsRX = values[9]
        self.browsRY = values[10]
        self.eyes = values[11]
        self.eyesLX = values[12]
        self.eyesLY = values[13]
        self.eyesRX = values[14]
        self.eyesRY = values[15]
        self.nose = values[16]
        self.noseX = values[17]
        self.noseY = values[18]
        self.mouth = values[19]
        self.mouthX = values[20]
        self.mouthY = values[21]
	end

	db:exec(sql, readFace)
end

-- --------------------------------------------------------
--
-- draw
-- 
-- --------------------------------------------------------
function face:draw(x, y, scale)
	self.x = x or self.x
	self.y = y or self.y
	self.scale = scale or self.scale

	local headImage = display.newImage(self.group, self.path .. self.head)

	local hairImage = display.newImage(self.group, self.path .. self.hair)
	hairImage.x = 0 + self.hairX
	hairImage.y = 0 - self.hairY

	local browImage = self.path .. self.brows
	local leftBrowImage = display.newImage(self.group, browImage)
	leftBrowImage.x = 0 + self.browsLX
	leftBrowImage.y = 0 - self.browsLY

	local rightBrowImage = display.newImage(self.group, browImage)
	rightBrowImage:scale(-self.scale, self.scale)
	rightBrowImage.x = 0 + self.browsRX
	rightBrowImage.y = 0 - self.browsRY 

	local eyeImage = self.path .. self.eyes
	local leftEyeImage = display.newImage(self.group, eyeImage)
	leftEyeImage.x = 0 + self.eyesLX
	leftEyeImage.y = 0 - self.eyesLY

	local rightEyeImage = display.newImage(self.group, eyeImage)
	rightEyeImage.x = 0 + self.eyesRX
	rightEyeImage.y = 0 - self.eyesRY

	local noseImage = display.newImage(self.group, self.path .. self.nose)
	noseImage.x = 0 + self.noseX
	noseImage.y = 0 - self.noseY

	local mouthImage = display.newImage(self.group, self.path .. self.mouth)
	mouthImage.x = 0 + self.mouthX
	mouthImage.y = 0 - self.mouthY

	self.group:scale(self.scale, self.scale)

	self.group.x = self.x
	self.group.y = self.y
end

-- --------------------------------------------------------
return face
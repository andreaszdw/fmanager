local de = {
	welcome = "Willkommen!",
	back = "Zurück",
	player = "Spieler",
	newPlayer = "Neuer Spieler",
	quit = "Beenden",
	age = "Alter",
	contract = "Vertrag",
	salary = "Gehalt",
	years = "Jahre",
	digitGrouping = 3,
	groupingSeparator = ".",
	decimalSeparator = ",",
	currencySign = "€",
	foot = "Fuss",
	keeper = "Torwart",
	defender = "Verteidiger",
	midfielder = "Mittelfeld",
	attacker = "Stürmer",
	position = "Position",
	name = "Name",
	left = "links",
	right = "rechts",
	both = "links/rechts",
	fitness = "Fitness",
	skills = "Eigenschaften",
	football = "Fussballerische",
	physical = "Körperliche",
	speed = "Schnelligkeit",
	stamina = "Ausdauer",
	passing = "Pass",
	header = "Kopfball",
	shot = "Schuss",
	tackle = "Zweikampf",
	tactic = "Taktik",
	experience = "Erfahrung"
}

local default = {
	welcome = "Welcome!",
	back = "Back",
	player = "Player",
	newPlayer = "New Player",
	quit = "Quit",
	age = "Age",
	contract = "Contract",
	salary = "Salary",
	years = "Years",
	digitGrouping = 3,
	groupingSeparator = ",",
	decimalSeparator = ".",
	currencySign = "$",
	foot = "Foot",
	keeper ="Keeper",
	defender = "Defender",
	midfielder = "Midfield",
	attacker = "Attacker",
	position = "Position",
	name = "Name",
	left = "left",
	right = "right",
	both = "left/right",
	fitness = "Fitness",
	skills = "Skills",
	physical = "Physical",
	football = "Football",
	speed = "Speed",
	stamina = "Stamina",
	passing = "Passing",
	header = "Header",
	shot = "Shot",
	tackle = "Tackling",
	tactic = "Tactic",
	experience = "Experience"
}

local i18n = {}

-- --------------------------------------------------------
-- get the correct language
--
function i18n.getStrings()
	local lang = system.getPreference("locale", "country")

	if lang == "DE" then 
		return de
	else
		return default
	end
end

-- --------------------------------------------------------
-- separate the digits, with the sep sign
-- 
local function digiSep(amount, sep)
	local formatted = amount
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1" .. sep .. "%2")
		if (k==0) then
  		break
  	end
  end
  return formatted
end

-- --------------------------------------------------------
-- round the amount
--
local function round(val, decimal)
	if (decimal) then
		return math.floor( (val * 10^decimal) + 0.5) / (10^decimal)
	else
		return math.floor(val+0.5)
	end
end

-- --------------------------------------------------------
-- format a number to currency, it will only return 
-- a string 
-- 
-- number:	decimal number to be formatted
-- decimal: int how many decimals
-- useSign: empty - now sign
-- 			pre - as prefix 
-- 			suf - as suffix
--
function i18n.currencyFormat(number, decimal, useSign)

	-- get the language
	local lang = system.getPreference("locale", "country")

	local useLang = ""
	if lang == "DE" then 
		useLang = de 
	else
		useLange = default 
	end

	local str_amount, formatted, famount, remain
	local decimal = decimal or 2 
	local negPrefix = "-"

    local gSep = useLang.groupingSeparator
    local dSep = useLang.decimalSeparator

    local neg_prefix = "-"

    famount = math.abs(round(number, decimal))
    famount = math.floor(famount)

    remain = round(math.abs(number) - famount, decimal)

	formatted = digiSep(famount, gSep)

	if (decimal > 0) then
    	remain = string.sub(tostring(remain),3)
    	formatted = formatted .. dSep .. remain ..
                	string.rep("0", decimal - string.len(remain))
  	end

  	if useSign == "pre" then 
  		formatted = useLang.currencySign .. " " .. formatted
  	elseif useSign == "suf" then 
  		formatted = formatted .. " " .. useLang.currencySign
  	else
  		formatted = formatted 
  	end

    return formatted
end

return i18n
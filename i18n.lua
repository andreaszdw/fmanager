local de = {}
de.welcome = "Willkommen!"
de.back = "Zurück"
de.player = "Spieler"
de.quit = "Beenden"
de.age = "Alter"
de.contract = "Vertrag"
de.salary = "Gehalt"
de.years = "Jahre"
de.digitGrouping = 3
de.groupingSeparator = "."
de.decimalSeparator = ","
de.currencySign = "€"
de.foot = "Fuss"
de.keeper = "Torwart"
de.name = "Name"


local default = {}
default.welcome = "Welcome!"
default.back = "Back"
default.player = "Player"
default.quit = "Quit"
default.age = "Age"
default.contract = "Contract"
default.salary = "Salary"
default.years = "Years"
default.digitGrouping = 3
default.groupingSeparator = ","
default.decimalSeparator = "."
default.currencySign = "$"
default.foot = "Fuss"
default.keeper ="Keeper"
default.name = "Name"

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
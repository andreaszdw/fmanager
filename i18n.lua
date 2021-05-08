local de = {}
de.welcome = "Willkommen!"
de.back = "Zurück"
de.player = "Spieler"
de.quit = "Beenden"
de.age = "Alter"
de.contract = "Vertrag"
de.salary = "Gehalt"
de.years = "Jahre"

local default = {}
default.welcome = "Welcome!"
default.back = "Back"
default.player = "Player"
default.quit = "Quit"
default.age = "Age"
default.contract = "Contract"
default.salary = "Salary"
default.years = "Years"

local i18n = {}

function i18n.getStrings()
	local lang = system.getPreference("locale", "country")

	if lang == "DE" then 
		return de
	else
		return default
	end
end

return i18n
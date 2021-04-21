local de = {}
de.welcome = "Willkommen!"
de.back = "Zurück"
de.player = "Spieler"

local default = {}
default.welcome = "Welcome!"
default.back = "Back"
default.player = "Player"

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
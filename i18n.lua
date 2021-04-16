local de = {}
de.welcome = "Willkommen!"

local default = {}
default.welcome = "Welcome!"

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
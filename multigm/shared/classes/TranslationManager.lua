-- ****************************************************************************
-- *
-- *  PROJECT:     	vRoleplay
-- *  FILE:        	shared/classes/TranslationManager.lua
-- *  PURPOSE:     	Class to manage translations
-- *
-- ****************************************************************************
TranslationManager = inherit(Singleton)

function TranslationManager:constructor()
	self.m_Translations = {}
	self.m_AddonTranslations = {}

	-- Load standard translations
	self:loadTranslation("en")
end

function TranslationManager:loadTranslation(locale, poFile)
	if not poFile then
		local path = ("files/translation/%s/%s.po"):format(locale, SERVER and "server" or "client")
		if fileExists(path) then
			self.m_Translations[locale] = POParser:new(path)
			outputDebug("Locale \'"..locale.."\' has been loaded!")
			return true
		end
	else
		if not fileExists(poFile) then return end

		if not self.m_AddonTranslations[locale] then
			self.m_AddonTranslations[locale] = {}
		end

		local poParser = POParser:new(poFile)
		if poParser then
			table.insert(self.m_AddonTranslations[locale], poParser)
			return true;
		end
	end
	return false
end

function TranslationManager:translate(message, locale)
	if locale == "de" then
		return message
	end

	if not self.m_Translations[locale] and not self.m_AddonTranslations[locale] then
		outputDebugString("The translation ("..locale..") has not been loaded yet")
		return message
	end

	if self.m_Translations[locale] or self.m_AddonTranslations[locale] then
		local translatedMsg = self.m_Translations[locale]:translate(message)
		if  translatedMsg then
			return translatedMsg
		else
			for i, poParser in ipairs(self.m_AddonTranslations[locale]) do
				local translatedMsg = poParser:translate(message)
				if translatedMsg then
					return translatedMsg
				end
			end

			outputDebug("There's a missing translation. Please update the .po files. ("..locale..")")
			outputDebug("Missing string: "..message)
			return message
		end

		return translatedMsg
	end

	return message
end

if SERVER then
	function _(message, player, ...)
		if not player then outputServerLog(debug.traceback()) end
		return TranslationManager:getSingleton():translate(message, player:getLocale()):format(...)
	end
else
	function _(message, ...)
		return TranslationManager:getSingleton():translate(message, localPlayer:getLocale()):format(...)
	end
end

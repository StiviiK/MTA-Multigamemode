-- ****************************************************************************
-- *
-- *  PROJECT:     vMultigamemode
-- *  SOURCE FROM: vRoleplay (Jusonex + sbx320)
-- *  FILE:        client/classes/GUI/MessageBoxs/InfoBox.lua
-- *  PURPOSE:     Warning box class
-- *
-- ****************************************************************************
WarningBox = inherit(MessageBox)

function WarningBox:getImagePath()
	return "res/images/MessageBoxes/Warning.png"
end

function WarningBox:getSoundPath()
	return "res/audio/Message.mp3"
end

addEvent("warningBox", true)
addEventHandler("warningBox", root, function(...) WarningBox:new(...) end)

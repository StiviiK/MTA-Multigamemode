-- ****************************************************************************
-- *
-- *  PROJECT:     vMultigamemode
-- *  SOURCE FROM: vRoleplay (Jusonex + sbx320)
-- *  FILE:        client/classes/GUI/MessageBoxs/InfoBox.lua
-- *  PURPOSE:     Error box class
-- *
-- ****************************************************************************
ErrorBox = inherit(MessageBox)

function ErrorBox:getImagePath()
	return "res/images/MessageBoxes/Error.png"
end

function ErrorBox:getSoundPath()
	return "res/audio/Message.mp3"
end

addEvent("errorBox", true)
addEventHandler("errorBox", root, function(...) ErrorBox:new(...) end)

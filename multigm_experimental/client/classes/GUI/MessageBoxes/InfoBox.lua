-- ****************************************************************************
-- *
-- *  PROJECT:     vMultigamemode
-- *  SOURCE FROM: vRoleplay (Jusonex + sbx320)
-- *  FILE:        client/classes/GUI/MessageBoxs/InfoBox.lua
-- *  PURPOSE:     Info box class
-- *
-- ****************************************************************************
InfoBox = inherit(MessageBox)

function InfoBox:getImagePath()
	return "res/images/MessageBoxes/Info.png"
end

function InfoBox:getSoundPath()
	return "res/audio/Message.mp3"
end

addEvent("infoBox", true)
addEventHandler("infoBox", root, function(...) InfoBox:new(...) end)

-- ****************************************************************************
-- *
-- *  PROJECT:     vMultigamemode
-- *  SOURCE FROM: vRoleplay (Jusonex + sbx320)
-- *  FILE:        client/classes/GUI/MessageBoxs/InfoBox.lua
-- *  PURPOSE:     Success box class
-- *
-- ****************************************************************************
SuccessBox = inherit(MessageBox)

function SuccessBox:getImagePath()
	return "res/images/MessageBoxes/Success.png"
end

function SuccessBox:getSoundPath()
	return "res/audio/Success.mp3"
end

addEvent("successBox", true)
addEventHandler("successBox", root, function(...) SuccessBox:new(...) end)

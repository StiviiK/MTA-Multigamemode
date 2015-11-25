-- ****************************************************************************
-- *
-- *  PROJECT:     vMultigamemode
-- *  SOURCE FROM: vRoleplay (Jusonex + sbx320)
-- *  FILE:        client/classes/GUIElements/VRPFont.lua
-- *  PURPOSE:     Not actually a GUI Element but useful for proper font sizes
-- *
-- ****************************************************************************

-- This rescales our font to look good on a certain pixel height
function VRPFont(height)
	local fontsize = math.floor(height/2)
	if not getCache("VRPFont")[fontsize] then
		__CACHE["VRPFont"][fontsize] = dxCreateFont("res/fonts/Segoe/segoeui.ttf", fontsize)
	end

	return getCache("VRPFont")[fontsize]
end

-- This gets the text width for a font which is 'height' pixels high
function VRPTextWidth(text, height)
	return dxGetTextWidth(text, 1, VRPFont(height))
end


-- FontAwesome
local FontAwesomes = {}
function FontAwesome(height)
	local fontsize = math.floor(height/2)
	if not getCache("FontAwesome")[fontsize] then
		__CACHE["FontAwesome"][fontsize] = dxCreateFont("res/fonts/FontAwesome.otf", fontsize)
	end

	return getCache("FontAwesome")[fontsize]
end

FontAwesomeSymbols = {
	CartPlus = "";
	Windows = "";
	Chrome = "";
	Facebook = "";
	Heart = "";
	Info = "";
	Lock = "";
	User = "";
	Gamepad = "";
	Bug = "";
	WhatsApp = "";
}

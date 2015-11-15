-- ****************************************************************************
-- *
-- *  PROJECT:     vMultigamemode
-- *  SOURCE FROM: vRoleplay (Jusonex + sbx320)
-- *  FILE:        client/classes/Color.lua
-- *  PURPOSE:     Static color "pseudo-class"
-- *
-- ****************************************************************************

Color = {
	Clear         = {0, 0, 0, 0   },
	Black         = {0,     0,   0},
	White         = {255, 255, 255},
	Grey          = {0x23, 0x23, 0x23, 230},
	Red           = {178,  35,  33},
	Yellow        = {255, 255,   0},
	Green         = {0,  125,   0},
	Blue          = {0,     0, 255},
	DarkBlue      = {0,    32,  63},
	DarkBlueAlpha = {0,32,  63, 200},
	DarkLightBlue = {0, 50, 100, 255},
	Brown         = {189, 109, 19},
	BrownAlpha    = {189, 109, 19, 180},
	LightBlue     = {6, 163, 212},
	Orange        = {254, 138, 0},
	LimeGreen     = {65, 163, 23},
}

for k, v in pairs(Color) do
	Color[k] = tocolor(unpack(v))
end

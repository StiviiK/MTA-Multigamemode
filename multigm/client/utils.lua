function getElementBehindCursor(worldX, worldY, worldZ)
    local hit, hitX, hitY, hitZ, element = processLineOfSight(getCamera():getPosition(), worldX, worldY, worldZ, false, true, true, true, false)
    return element
end

function fontHeight(font, size)
	return dxGetFontHeight(size, font) * 1.75
end
function fontWidth(text, font, size)
	return dxGetTextWidth(text, size or 1, font or "default")
end

function textHeight(text, lineWidth, font, size)
	--[[
	Breaks words. Lines are automatically broken between words if a word would
	extend past the edge of the rectangle specified by the pRect parameter.
	A carriage return/line feed sequence also breaks the line.
	]]
	local start = 1
	local height = dxGetFontHeight(size, font)
	for pos = 1, text:len() do
		if dxGetTextWidth(text:sub(start, pos), size, font) > lineWidth or text:sub(pos, pos) == "\n" then
			local fh = dxGetFontHeight(size, font)
			height = height + fh
			start = pos - 1
		end
	end
	return height
end

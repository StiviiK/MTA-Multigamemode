-- ****************************************************************************
-- *
-- *  PROJECT:     vMultigamemode
-- *  SOURCE FROM: vRoleplay (Jusonex + sbx320)
-- *  FILE:        client/classes/GUI/GUIImage.lua
-- *  PURPOSE:     GUI image class
-- *
-- ****************************************************************************
GUIImage = inherit(GUIElement)
inherit(GUIColorable, GUIImage)

function GUIImage:constructor(posX, posY, width, height, path, parent)
	self.m_Image = path

	GUIElement.constructor(self, posX, posY, width, height, parent)
	GUIColorable.constructor(self, Color.White)
end

function GUIImage:drawThis()
	dxSetBlendMode("modulate_add")
	if self.m_Image then
		dxDrawImage(math.floor(self.m_AbsoluteX), math.floor(self.m_AbsoluteY), self.m_Width, self.m_Height, self.m_Image, self.m_Rotation or 0, self.m_RotationCenterOffsetX or 0, self.m_RotationCenterOffsetY or 0, self.m_Color or 0)
	end
	dxSetBlendMode("blend")
end

function GUIImage:setRotation(rotation, rotationCenterOffsetX, rotationCenterOffsetY)
	assert(type(rotation) == "number", "Bad argument #1 @ GUIImage.setRotation")

	self.m_Rotation = rotation
	self.m_RotationCenterOffsetX = rotationCenterOffsetX
	self.m_RotationCenterOffsetY = rotationCenterOffsetY

	self:anyChange()
	return self
end

function GUIImage:setImage(path)
	self.m_Image = path
	self:anyChange()
	return self
end

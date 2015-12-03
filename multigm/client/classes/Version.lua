Version = inherit(Singleton)

function Version:constructor()
	self.m_VersionLabel = guiCreateLabel(screenWidth - 255, screenHeight - 30, 250, 18, "", false)
	guiSetAlpha(self.m_VersionLabel, 0.53)
	guiLabelSetHorizontalAlign(self.m_VersionLabel, "right")

	self:setRevision()
end

function Version:setVersion(versionString)
	guiSetText(self.m_VersionLabel, versionString)
end

function Version:setRevision()
	self:setVersion(VERSION_LABEL)
end

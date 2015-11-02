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
	if BUILD == "development" then
		VERSION_LABEL = ("%s %sdev"):format(PROJECT_NAME, VERSION)
	elseif BUILD == "unstable" then
		VERSION_LABEL = ("%s %s unstable"):format(PROJECT_NAME, VERSION)
	else
		VERSION_LABEL = ("%s %s"):format(PROJECT_NAME, VERSION)
	end

	self:setVersion(VERSION_LABEL)
end

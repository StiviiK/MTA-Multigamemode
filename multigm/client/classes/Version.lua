Version = inherit(Singleton)
addEvent("versionReceive", true)

function Version:constructor()
	self.m_VersionLabel = guiCreateLabel(screenWidth - 255, screenHeight - 30, 250, 18, "", false)
	guiSetAlpha(self.m_VersionLabel, 0.53)
	guiLabelSetHorizontalAlign(self.m_VersionLabel, "right")

	addEventHandler("versionReceive", root,
		function(version)
			self:setRevision(version)
		end
	)
end

function Version:setVersion(versionString)
	guiSetText(self.m_VersionLabel, versionString)
end

function Version:setRevision(commit)
	GIT_HASH = commit

	if BUILD == "development" then
		VERSION_LABEL = ("%s %sdev %s"):format(PROJECT_NAME, VERSION, GIT_HASH:sub(1,7))
	elseif BUILD == "unstable" then
		VERSION_LABEL = ("%s %s unstable"):format(PROJECT_NAME, VERSION)
	else
		VERSION_LABEL = ("%s %s"):format(PROJECT_NAME, VERSION)
	end

	self:setVersion(VERSION_LABEL)
end

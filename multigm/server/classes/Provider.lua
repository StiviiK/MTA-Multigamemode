Provider = inherit(Singleton)
local DOWNLOAD_SPEED = 0.1 * 1024 * 1024
if DEBUG then
  --DOWNLOAD_SPEED = 1000000000
end

function Provider:constructor()
  addRemoteEvents{"onClientRequestFile", "onClientDownlaodComplete"}
  addEventHandler("onClientRequestFile", root, bind(Provider.onClientRequestFile, self))
  addEventHandler("onClientDownlaodComplete", root, bind(Provider.onFileDownloadComplete, self))
  addEventHandler("onPlayerQuit", root, bind(Provider.onPlayerDisconnect, self))

  --self.m_FilesInstant = {}
  self.m_FilesOnDemand = {}
  self.m_ActiveDL = {}

  self.m_UpdatePulse = TimedPulse:new(500)
  self.m_UpdatePulse:registerHandler(bind(Provider.updateProgress, self))
end

function Provider:destructor()
  delete(self.m_UpdatePulse)
end

function Provider:offerFile(file, type)
  if not fileExists(file) then return DOWNLOAD_ERROR_INVALID_FILE end

  local fileHandle = File(file)
  local size = fileHandle:getSize()
  local data = fileHandle:read(size)
  local md5 = md5(data)
  fileHandle:close()

  if type == PROVIDER_ON_DEMAND then
    self.m_FilesOnDemand[file] = {
      data = data;
      size = size;
      md5 = md5;
    }

    return
  end
end

function Provider:updateProgress()
  for k, v in pairs(self.m_ActiveDL) do
		if isElement(v.player) then
			local handle = v.handle
			local status = getLatentEventStatus(v.player, handle)

			if status and status.percentComplete < 100 then
				v.player:triggerEvent("onFileProgressUpdate", resourceRoot, k, status)
			end
		end
	end
end

function Provider:onClientRequestFile(file, fileHash) -- this function can only be called when type = PROVIDER_ON_DEMAND
  if not self.m_FilesOnDemand[file] then
    client:triggerEvent("onFileDonwloadStart", resourceRoot, DOWNLOAD_ERROR_UNKOWN_FILE, file)
    return
  end
  if fileHash == self.m_FilesOnDemand[file].md5 then
    client:triggerEvent("onFileDonwloadStart", resourceRoot, file, file, self.m_FilesOnDemand[file].md5, self.m_FilesOnDemand[file].size)
    client:triggerEvent("onFileReceive", resourceRoot, file, true)
    return
  end

  local Id = #self.m_ActiveDL + 1
  client:triggerLatentEvent("onFileReceive", DOWNLOAD_SPEED, resourceRoot, Id, self.m_FilesOnDemand[file].data)

	self.m_ActiveDL[Id] = {
    player = client;
    handle = getLatentEventHandles(client)[#getLatentEventHandles(client)]
  }
  client:triggerEvent("onFileDonwloadStart", resourceRoot, Id, file, self.m_FilesOnDemand[file].md5, self.m_FilesOnDemand[file].size)
end

function Provider:onFileDownloadComplete(Id)
  self.m_ActiveDL[Id] = nil
end

function Provider:onPlayerDisconnect()
  for Id, data in pairs(self.m_ActiveDL) do
    if data.player == source then
      cancelLatentEvent(data.player, data.handle)
      self.m_ActiveDL[Id] = nil
    end
  end
end

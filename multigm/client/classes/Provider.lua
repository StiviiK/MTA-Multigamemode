-- ****************************************************************************
-- *
-- *  PROJECT:     vMultigamemode
-- *  FILE:        client/classes/Provider.lua
-- *  PURPOSE:     Clientside-Provider class
-- *
-- ****************************************************************************
Provider = inherit(Singleton)

function Provider:constructor()
  addRemoteEvents{"onFileReceive", "onFileDonwloadStart", "onFileProgressUpdate"}
  addEventHandler("onFileReceive", root, bind(Provider.onFileReceive, self))
  addEventHandler("onFileDonwloadStart", root, bind(Provider.onFileDonwloadStart, self))
  addEventHandler("onFileProgressUpdate", root, bind(Provider.onProgessUpdate, self))

  self.m_Files = {}
  self.m_RequestedFiles = {}
end

function Provider:destructor()
end

function Provider:requestFile(file, callback, callbackargs)
  if self.m_RequestedFiles[file] then return end
  self.m_LoadingBar = LoadingBar:new("Starting Download...", callback, callbackargs)
  self.m_RequestedFiles[file] = true


  local hash = ""
  if fileExists(file) then
    local fileHandle = File(file)
    hash = md5(fileHandle:read(fileHandle:getSize()))
    fileHandle:close()
  end
  triggerServerEvent("onClientRequestFile", resourceRoot, file, hash)
end

function Provider:onFileDonwloadStart(Id, path, md5, size)
  if Id == DOWNLOAD_ERROR_UNKOWN_FILE then
    delete(self.m_LoadingBar)
    self.m_RequestedFiles[path] = false

    outputDebug("FILE NOT FOUND.")
    return
  end

  self.m_Files[Id] = {path = path, md5 = md5, size = size, loadingBar = self.m_LoadingBar}
  self.m_Files[Id].loadingBar:setText(("Downloading '%s' (0 B/%s)"):format(path, sizeFormat(size)))
end

function Provider:onFileReceive(Id, data)
  if type(Id) == "string" then
    if data == true then
      triggerServerEvent("onClientDownlaodComplete", resourceRoot, Id)

      delete(self.m_Files[Id].loadingBar)

      self.m_Files[Id] = nil
      self.m_RequestedFiles[Id] = nil
      return
    end
  end

  local file = self.m_Files[Id]
  if not file then return end
  if file.md5 ~= md5(data) then --[[return problem]] end

  if fileExists(file.path) then fileDelete(file.path) end
  local fileHandle = fileCreate(file.path)
  fileHandle:write(data)
  fileHandle:close()

  triggerServerEvent("onClientDownlaodComplete", resourceRoot, Id)

  if file.path:find(".data") then
    Package.load(file.path)
  end

  delete(file.loadingBar)
  self.m_Files[Id] = nil
  self.m_RequestedFiles[file.path] = nil
end

function Provider:onProgessUpdate(Id, status)
  self.m_Files[Id].loadingBar:setText(("Downloading '%s' (%s/%s)"):format(self.m_Files[Id].path, sizeFormat(math.floor((self.m_Files[Id].size/100)*status.percentComplete)), sizeFormat(self.m_Files[Id].size)))
end

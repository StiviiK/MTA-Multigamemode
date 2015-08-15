Updater = {
	localName = "update/update.rpf";
	localMD5  = false;
	localSize = 0;
}
 
function Updater.check()
	outputDebugString("[UPDATER] Checking for Updates...")

    local files = {"meta.xml"}
    local xml = xmlLoadFile("meta.xml")
    for k, v in ipairs(xmlNodeGetChildren(xml)) do
        if xmlNodeGetName(v) == "script" or xmlNodeGetName(v) == "file" or xmlNodeGetName(v) == "transferfile" or xmlNodeGetName(v) == "metafile" then
			files[#files+1] = xmlNodeGetAttribute(v, "src")
		end
	end
       
    -- Create Data Package
    Package.save(Updater.localName, files)
	Updater.getHash()
	
	outputDebugString("[UPDATER] Local md5: "..Updater.localMD5)
	outputDebugString("[UPDATER] Remote md5: "..Updater.localMD5)
	outputDebugString("[UPDATER] No updates found!")
end
 
function Updater.download()
end

function Updater.getHash()
	local fh = fileOpen(Updater.localName)
	Updater.localMD5 = md5(fileRead(fh, fileGetSize(fh)))
	fileClose(fh)
end
 
function Updater.unpack(file)
	if not fileExists(file) then return end
       
	-- Unpack the Update
	Package.load(file)
       
	-- Restart the resource
	restartResource(getThisResource())
end

addEventHandler("onResourceStart", resourceRoot,
	function()
		delay(Updater.unpack, "update/update.rpf")
	end
)
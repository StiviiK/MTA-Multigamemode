Updater = {}
 
function Updater.check()
    local files = {"meta.xml"}
    local xml = xmlLoadFile("meta.xml")
    for k, v in pairs(xmlNodeGetChildren(xml)) do
        if xmlNodeGetName(v) == "script" or xmlNodeGetName(v) == "file" or xmlNodeGetName(v) == "transferfile" or xmlNodeGetName(v) == "metafile" then
			files[#files+1] = xmlNodeGetAttribute(v, "src")
		end
	end
       
    -- Create Data Package and offer it (On-Demand)
    Package.save("update/update.rpf", files)
end
 
function Updater.download()
end
 
function Updater.unpack(file)
	if not fileExists(file) then return end
       
	-- Unpack the Update
	Package.load(file)
       
	-- Restart the resource
	restartResource(getThisResource())
end

Updater.check()
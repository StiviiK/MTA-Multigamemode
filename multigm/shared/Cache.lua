__CACHE = {}

function registerCache(type)
  __CACHE[type] = {}
end

function getCache(type)
  return __CACHE[type]
end

function clearCache(type)
  if (not type) or (__CACHE[type] == nil) then
    for i in pairs(__CACHE) do
      clearCache(i)
    end

    return
  end

  __CACHE[type] = {}
end



-- register cache
registerCache("function")

if SERVER then
  --registerCache("")
end
if CLIENT then
  registerCache("font")
end

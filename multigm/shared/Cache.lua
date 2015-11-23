__CACHE = {}

function registerCache(type, timeout)
  if getCache(type) then
    return false
  end
  __CACHE[type] = {}

  if timeout then
    setTimer(clearCache, timeout, 1, type)
  end
end

function getCache(type)
  return __CACHE[type]
end

function clearCache(type)
  if not type then
    for i in pairs(__CACHE) do
      clearCache(i)
    end

    collectgarbage()
    return
  end

  __CACHE[type] = {}
  collectgarbage()
end



-- Cache init
if SERVER then
end
if CLIENT then
  -- Register font cache
  registerCache("VRPFont")
  registerCache("FontAwesome")
end

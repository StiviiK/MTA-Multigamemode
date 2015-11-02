local __MAP = {}

function __MAP.onCreate()
end

function __MAP.onDestroy()
  __MAP.destroy()
end

function __MAP.onPlayerJoin()
  __MAP.create()
end

function __MAP.onPlayerLeft()
  __MAP.destroy()
end


-- Extra functions
function __MAP.create()
  for i=0,20000 do
    removeWorldModel(i, 10000, 0, 0, 0)
  end
  setOcclusionsEnabled(false)
  setWaterLevel(-1000)
  setWaterColor(0, 200, 200, 150)
  __MAP.m_Water = {
    createWater(-2998, 1750, 50, 2998, 1750, 50, -2998, 2998, 50, 2998, 2998, 50);
    createWater(-2998, -2998, 50, -356, -2998, 50, -2998, 1750, 50, -356, 1750, 50);
    createWater(-356, -2998, 50, 2998, -2998, 50, -356, 800, 50, 2998, 800, 50);
    createWater(700, 1150, 50, 2998, 1150, 50, 700, 1750, 50, 2998, 1750, 50);
    createWater(811, 800, 50, 2998, 800, 50, 811, 1150, 50, 2998, 1150, 50);
    createWater (357, 1420, 63, 418, 1400, 63, 355, 1515, 63, 423, 1515, 63);
    createWater (-103, 1600, 76, -34, 1600, 76, -103, 1700, 76, -34, 1700, 76);
  }
end

function __MAP.destroy()
  for i=0,20000 do
    restoreWorldModel(i, 10000, 0, 0, 0)
  end
  setOcclusionsEnabled(true)
  resetWaterLevel()
  resetWaterColor()
  for i, v in pairs(__MAP.m_Water) do
    destroyElement(v)
  end
end


-- Return it
return __MAP

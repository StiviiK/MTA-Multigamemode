local Sweeper = inherit(Object)

function Sweeper:constructor(Id, owner, vehicle)
  self.m_Id = Id
  self.m_Owner = owner
  self.m_Vehicle = vehicle
  self.m_Weapon = SuperS.Sweeper.Weapon:new(self, 23)
end

function Sweeper:destructor()
  SuperS.SweeperManager:getSingleton():removeRef(self)
  if self.m_Weapon then
    delete(self.m_Weapon)
  end
end

function Sweeper:getId()
  return self.m_Id
end

function Sweeper:getVehicle()
  return self.m_Vehicle
end

function Sweeper:startFire(...)
  self.m_Weapon:startFire(...)
end

function Sweeper:stopFire(...)
  self.m_Weapon:stopFire(...)
end

function renderWall()
    local x,y,w,h=-2301.47265625,697,800,800
    local r,g,b,a=255,0,0,200
    local s=10
	dxSetBlendMode("modulate_add")
    for z=0,130,4 do
        dxDrawLine3D(x,y,z,x,y+h,z,tocolor(r,g,b,a),s,false)
        dxDrawLine3D(x,y+h,z,x+w,y+w,z ,tocolor(r,g,b,a),s,false)
        dxDrawLine3D(x+w,y+w,z,x+w,y,z ,tocolor(r,g,b,a),s,false)
        dxDrawLine3D(x+w,y,z,x,y,z ,tocolor(r,g,b,a),s,false)
    end
		-- 4 krasse Linien am Ende
		dxDrawLine3D(x,y,0,x,y,130,tocolor(r,g,b,a),15,false)
        dxDrawLine3D(x,y+h,0,x,y+h,130,tocolor(r,g,b,a),15,false)
        dxDrawLine3D(x+w,y,0,x+w,y,130,tocolor(r,g,b,a),15,false)
        dxDrawLine3D(x+w,y+h,0,x+w,y+h,130,tocolor(r,g,b,a),15,false)
	dxSetBlendMode("blend")
end
addEventHandler("onClientPreRender",getRootElement(),renderWall)


-- "Export" to SuperS
SuperS.Sweeper = Sweeper

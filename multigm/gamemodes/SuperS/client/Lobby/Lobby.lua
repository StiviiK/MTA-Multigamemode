local Lobby = inherit(Singleton)

function Lobby:constructor()
  self.m_JoinMarker = Marker(Vector3(-1921.119, 992.935, 45.430), "corona", 1.0, fromcolor(SuperS:getInstance():getColor()))
  addEventHandler("onClientMarkerHit", self.m_JoinMarker, bind(self.onJoinMarkerHit, self))
end

function Lobby:destructor()
end

function Lobby:updateDimension()
  self.m_JoinMarker:setDimension(SuperS:getInstance():getDimension())
end

function Lobby:onJoinMarkerHit(hitElement, matchingDimension)
  if hitElement == localPlayer and matchingDimension then
    fadeCamera(false, 1)
    triggerServerEvent("sweeperJoinGame", hitElement, core:get("SuperS", "SweeperTexture", false))
  end
end

-- "Export" to SuperS
SuperS.Lobby = Lobby

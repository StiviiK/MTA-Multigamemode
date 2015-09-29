-- ****************************************************************************
-- *
-- *  PROJECT:     vMultigamemode
-- *  FILE:        client/classes/LocalPlayer.lua
-- *  PURPOSE:     LocalPlayer class
-- *
-- ****************************************************************************
LocalPlayer = inherit(Player)

function LocalPlayer:constructor()
end

function LocalPlayer:destructor()
end

-- Short getters
function LocalPlayer:getId() return self:getPrivateSync("Id") end
function LocalPlayer:isLoggedIn() return self:getId() ~= nil end
function LocalPlayer:getRank() return self:getPrivateSync("Rank") end
function Player:getPlayTime() return math.floor(self:getPrivateSync("LastPlayTime") + (getTickCount() - self.m_JoinTime)/1000/60) end

GameRooms = inherit(Object)

function GameRooms:virtual_constructor()
  self.m_Rooms = {}
end

function GameRooms:virtaul_destructor()
  for i, room in pairs(self.m_Rooms) do
    self:removeRoom(room.id)
  end

  self.m_Rooms = nil
end

function GameRooms:getRoomFromId(Id)
  return self.m_Rooms[Id]
end

function GameRooms:addRoom(name, maxplayers)
  local Id = table.push(self.m_Rooms, {name = name, maxplayers = maxplayers or -1, players = {}})
  self.m_Rooms[Id].id = Id

  return Id
end

function GameRooms:removeRoom(Id)
  if self.m_Rooms[Id] then
    for i, player in pairs(self.m_Rooms[Id].players) do
      v:removeFromRoom(Id, player)
    end

    self.m_Rooms[Id] = nil
  end
end

function GameRooms:addToRoom(Id, player)
  -- Todo
end

function GameRooms:removeFromRoom(Id, player)
  -- Todo
end

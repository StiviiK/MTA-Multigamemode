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

function GameRooms:newRoom(name)
  local Id = #self.m_Rooms + 1
  self.m_Rooms[Id] = {id = Id, name = name, players = {}}

  return Id
end

function GameRooms:removeRoom(Id)
  if self.m_Rooms[Id] then
    for i, player in pairs(self.m_Rooms[Id].players) do
      v:removePlayer(Id, player)
    end

    self.m_Rooms[Id] = nil
  end
end

function GameRooms:addPlayer()
  -- Todo
end

function GameRooms:removePlayer()
  -- Todo
end

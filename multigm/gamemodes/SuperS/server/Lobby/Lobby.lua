local Lobby = inherit(Singleton)
addRemoteEvents{"sweeperJoinGame"}

function Lobby:constructor()
  addEventHandler("sweeperJoinGame", root, bind(self.joinSweeperGame, self))
end

function Lobby:destructor()
end

function Lobby:joinSweeperGame(sweeperTexture)
  SuperS.Sweeper:new(client, sweeperTexture)
  fadeCamera(client, true, 1)
end


-- "Export" to SuperS
SuperS.Lobby = Lobby

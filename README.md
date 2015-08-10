# MTA SanAndreas 1.5+ - Multigamemode
This is a new Version of my old Multigamemode, this version will be more efficient than the old version.
Feel free to fork this repository and Support me, with my Work :)

## Milestones
  - [x] Completely OpenSource
  - [ ] First stable-build

## Features 
Upcoming features:
  - [x] Completely ObjectOrientated
  - [x] uses the LUA-Classlib (by sbx320)
  - [ ] Lobby-System (OpenWorld-Lobby)
  - [x] Easy implementation of Gamemodes
  - [ ] Auto-Updater
  - [ ] Other features comming soon...

## Scripting Informations
#### Edit offline Players
```lua
local offlinePlayer, isOffline = DatabasePlayer.get(1) -- Get the offline Player with Id=1
if isOffline then -- only load when he is offline
  offlinePlayer:load() -- Load the Data
end  

-- Do your stuff
print(offlinePlayer:getMoney()) --> our value from the Database
offlinePlayer:setMoney(12) --> change money
  
-- delete the instance (also saving)
if isOffline then -- only delete when he is offline (otherwise it will cause problems :P)
  delete(offlinePlayer)
end
```

#### Creating a Gamemode
gamemodes\Gamemode1\server\constants.lua
```lua
Gamemode1 = inherit(Gamemode)
Gamemode1.ms_Settings = {}

function Gamemode1:getSetting(key)
  return self.ms_Settings[key]
end
```

[server\classes\Gamemode\GamemodeManager.lua#L5](https://github.com/StiviiK/vMultigamemode/blob/develop/multigm/server/classes/Gamemode/GamemodeManager.lua#L5)
```lua
local Gamemodes = {
  Lobby:new("Lobby", "This is the Lobby.")
  Gamemode1:new("Gamemode1", "This is my Gamemode")
}
```
On Clientside, it's the same way.

## Developers
  - Stefan K. - "StiviK"

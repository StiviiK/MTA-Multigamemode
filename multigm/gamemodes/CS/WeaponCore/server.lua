WeaponsCore = inherit(Singleton)

function WeaponsCore:constructor()
self.Weapons = {
["Primary"]   		  = false,
["Secondary"] 	 	  = false,
["Granate1"]  	 	  = false,
["Granate2"]  	      = false,
["Granate3"] 		  = false,
["Bomb"]     	      = false,
["Defusekit"]         = false,
["Kevlar"]    		  = false,
["KevlarWithHelm"]    = false
}

self.WeaponsList = {
["Primary"]   		  = {["AK-47"]        = {["Slot"] = 5 , ["WeaponID"] = 30}	},
["Secondary"] 	 	  = {["Desert Eagle"] = {["Slot"] = 2 , ["WeaponID"] = 24}	},
["Granate1"]  	 	  = false,
["Granate2"]  	      = false,
["Granate3"] 		  = false,
["Bomb"]     	      = false,
["Defusekit"]         = false,
["Kevlar"]    		  = false,
["KevlarWithHelm"]    = false
}

self.WeaponSlots = {
[1] = "Primary",
[2] = "Secondary",
[3] = "Granate1",
[4] = "Granate2",
[5] = "Granate3",
[6] = "Bomb",
[7] = "Defusekit",
[8] = "Kevlar",
[9] = "KevlarWithHelm"
}
end

function WeaponsCore:destructor()
		for i = 1,9 do
			unbindKey ( player, tostring(i), "down", self.SwitchWeapon_func )
		end
end

function WeaponsCore:givePlayerWeapon(player,category,Weapon)
	if not player.Weapons then
	self.SwitchWeapon_func = function(...) self:SwitchWeapon(...) end
		player.Weapons = self.Weapons

		for i = 1,9 do
			bindKey ( player, tostring(i), "down", self.SwitchWeapon_func )
		end
		 
	end
	
	player.Weapons[category] = Weapon
	
	local Slot 	   = self.WeaponsList[category][Weapon]["Slot"]
	local WeaponId = self.WeaponsList[category][Weapon]["WeaponID"]
	outputChatBox("WeaponId:"..WeaponId)
	giveWeapon ( player, WeaponId, 200 )
end

function WeaponsCore:takePlayerWeapon(player,category)
	local CurrentWeapon = player.Weapons[category]
	local Slot 	  	    = self.WeaponsList[category][CurrentWeapon]["Slot"]
	local WeaponId      = self.WeaponsList[category][CurrentWeapon]["WeaponID"]
	
	player.Weapons[category] = false
    takeWeapon( player, WeaponId, 200 )
end

function WeaponsCore:takePlayerAllWeapons(player)
	for id, category in ipairs(player.Weapons) do
	
	local CurrentWeapon = player.Weapons[category]
	local Slot 	  	    = self.WeaponsList[category][CurrentWeapon]["Slot"]
	local WeaponId      = self.WeaponsList[category][CurrentWeapon]["WeaponID"]
		player.Weapons[category] = false
		takeWeapon( player, WeaponId, 200 )
	end
end

function WeaponsCore:SwitchWeapon(player, key, keyState)
	outputChatBox(tostring(player.Weapons[self.WeaponSlots[tonumber(key)]])) 
	local Category = self.WeaponSlots[tonumber(key)]
	local PlayerWeaponName = player.Weapons[Category]
	outputChatBox("PlayerWeaponName: "..tostring(PlayerWeaponName))
	local Slot = self.WeaponsList[Category][PlayerWeaponName]["Slot"]
	setPedWeaponSlot ( player, tonumber(Slot) )
end



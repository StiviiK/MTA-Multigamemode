CNR_DOWNLOAD_FILE = "gamemodes/CnR/cnr.data"
CNR_DIM = 4
-- TODO: REMOVE THIS; GAMEMODE REQUIRES MAJOR REWORK -> READ DIM FROM GAMEMODE!
CNR_Fraction_Name = {
[1] = "Cops",
[2] = "Robbers"
}

CNR_Fraction_ID = {
["Cops"] = 1,
["Robbers"] = 2
}

CNR_LootDeliveryPoints = {
[1] = {["x"] = 0,["y"] = 0,["z"] = 0},
[2] = {["x"] = 20,["y"] = 0,["z"] = 0},
[3] = {["x"] = 20,["y"] = 20,["z"] = 0}
}


CNR_Fraction_Color= {
[1] = {0,0,255},
[2] = {255,0,0}
}

CNR_Cops =    CNR_Fraction_ID["Cops"]
CNR_Robbers = CNR_Fraction_ID["Robbers"]

CNR_Extra_Dimension = {
[1] = 8881,
[2] = 8882,
[3] = 8883,
[4] = 8884
}

CNR_Spawns_Hospital = {
{["Pos"] = Vector3(1181.9976806641,-1323.4655761719,13.58145236969) ,["Rot"] = Vector3(-0,0,269.85369873047),["Int"] = 0},---LS Mitte
{["Pos"] = Vector3(2026.7784423828,-1421.6859130859,16.9921875)     ,["Rot"] = Vector3(-0,0,133.86575317383),["Int"] = 0}---LS GS
}

CNR_Arrest_Fine = {
--Multiplikator--
["High"] = 3,
["Medium"] = 2,
["Low"] = 1
}

CNR_Arrest_Cops_Pay = {
["High"]   = 100,
["Medium"] = 200,
["Low"]    = 300
}

CNR_Cops = {
{["Skin"] = 163,["Weapons"] = {3,22}},
{["Skin"] = 164,["Weapons"] = {3,22}},
{["Skin"] = 165,["Weapons"] = {3,22}},
{["Skin"] = 166,["Weapons"] = {3,22}},
{["Skin"] = 265,["Weapons"] = {3,22}},
{["Skin"] = 266,["Weapons"] = {3,22}},
{["Skin"] = 267,["Weapons"] = {3,22}},
{["Skin"] = 280,["Weapons"] = {3,22}},
{["Skin"] = 281,["Weapons"] = {3,22}},
{["Skin"] = 282,["Weapons"] = {3,22}},
{["Skin"] = 283,["Weapons"] = {3,22}},
{["Skin"] = 284,["Weapons"] = {3,22}},
{["Skin"] = 285,["Weapons"] = {3,22}},
{["Skin"] = 286,["Weapons"] = {3,22}},
{["Skin"] = 287,["Weapons"] = {3,22}},
{["Skin"] = 288,["Weapons"] = {3,22}}
}


CNR_RobbersSkins = {
{["Skin"] = 105,["Weapons"] = {5,23}},
{["Skin"] = 107,["Weapons"] = {5,23}},
{["Skin"] = 102,["Weapons"] = {5,23}},
{["Skin"] = 103,["Weapons"] = {5,23}},
{["Skin"] = 104,["Weapons"] = {5,23}},
{["Skin"] = 108,["Weapons"] = {5,23}},
{["Skin"] = 109,["Weapons"] = {5,23}},
{["Skin"] = 110,["Weapons"] = {5,23}},
{["Skin"] = 114,["Weapons"] = {5,23}},
{["Skin"] = 115,["Weapons"] = {5,23}},
{["Skin"] = 116,["Weapons"] = {5,23}},
{["Skin"] = 111,["Weapons"] = {5,23}},
{["Skin"] = 112,["Weapons"] = {5,23}},
{["Skin"] = 113,["Weapons"] = {5,23}},
{["Skin"] = 125,["Weapons"] = {5,23}},
{["Skin"] = 126,["Weapons"] = {5,23}},
{["Skin"] = 127,["Weapons"] = {5,23}},
{["Skin"] = 272,["Weapons"] = {5,23}},
{["Skin"] = 120,["Weapons"] = {5,23}},
{["Skin"] = 163,["Weapons"] = {5,23}},
{["Skin"] = 124,["Weapons"] = {5,23}},
{["Skin"] = 118,["Weapons"] = {5,23}},
{["Skin"] = 117,["Weapons"] = {5,23}},
{["Skin"] = 120,["Weapons"] = {5,23}},
{["Skin"] = 121,["Weapons"] = {5,23}},
{["Skin"] = 122,["Weapons"] = {5,23}},
{["Skin"] = 123,["Weapons"] = {5,23}}
}

ShopItems = {
{["Name"] = "C4"		,["Price"] = 100		,["Description"] = "-----C4-----\n\n "},
{["Name"] = "Camera"	,["Price"] = 100		,["Description"] = "-----Camera-----\n\n "},
{["Name"] = "Pizza"		,["Price"] = 100		,["Description"] = "-----Pizza-----\n\n "},
{["Name"] = "Meidic-Kit",["Price"] = 100		,["Description"] = "-----Meidic-Kit-----\n\n "},
{["Name"] = "Test"		,["Price"] = 100		,["Description"] = "-----Test-----\n\n "}

}

 WeaponsList = {
{["Slot"] = 0,["Name"] = "Brass Knuckles"         , ["ModelID"]= 331, ["WeaponID"]= 1, ["Price"]= 100},

{["Slot"] = 1,["Name"] = "Golf Club"   		      , ["ModelID"]= 333, ["WeaponID"]= 2, ["Price"]= 100},
{["Slot"] = 1,["Name"] = "Nightstick"  		      , ["ModelID"]= 334, ["WeaponID"]= 3, ["Price"]= 100},
{["Slot"] = 1,["Name"] = "Knife"       		      , ["ModelID"]= 335, ["WeaponID"]= 4, ["Price"]= 100},
{["Slot"] = 1,["Name"] = "Baseball Bat"		      , ["ModelID"]= 336, ["WeaponID"]= 5, ["Price"]= 100},
{["Slot"] = 1,["Name"] = "Shovel"      		      , ["ModelID"]= 337, ["WeaponID"]= 6, ["Price"]= 100},
{["Slot"] = 1,["Name"] = "Pool Cue"    		      , ["ModelID"]= 338, ["WeaponID"]= 7, ["Price"]= 100},
{["Slot"] = 1,["Name"] = "Katana"     		      , ["ModelID"]= 339, ["WeaponID"]= 8, ["Price"]= 100},
{["Slot"] = 1,["Name"] = "Chainsaw"    			  , ["ModelID"]= 341, ["WeaponID"]= 9, ["Price"]= 100},

{["Slot"] = 2,["Name"] = "Pistol"                 , ["ModelID"]= 346, ["WeaponID"]= 22, ["Price"]= 100},
{["Slot"] = 2,["Name"] = "Silenced Pistol" 		  , ["ModelID"]= 347, ["WeaponID"]= 23, ["Price"]= 100},
{["Slot"] = 2,["Name"] = "Desert Eagle"     	  , ["ModelID"]= 348, ["WeaponID"]= 24, ["Price"]= 100},

{["Slot"] = 3,["Name"] = "Shotgun"                , ["ModelID"]= 349, ["WeaponID"]= 25, ["Price"]= 100},
{["Slot"] = 3,["Name"] = "Sawn-Off Shotgun"       , ["ModelID"]= 350, ["WeaponID"]= 26, ["Price"]= 100},
{["Slot"] = 3,["Name"] = "SPAZ-12 Combat Shotgun" , ["ModelID"]= 351, ["WeaponID"]= 27, ["Price"]= 100},

{["Slot"] = 4,["Name"] = "Uzi"					  , ["ModelID"]= 352, ["WeaponID"]= 28, ["Price"]= 100},
{["Slot"] = 4,["Name"] = "MP5"					  , ["ModelID"]= 353, ["WeaponID"]= 29, ["Price"]= 100},
{["Slot"] = 4,["Name"] = "TEC-9"				  , ["ModelID"]= 372, ["WeaponID"]= 32, ["Price"]= 100},

{["Slot"] = 5,["Name"] = "AK-47"				  , ["ModelID"]= 355, ["WeaponID"]= 30, ["Price"]= 100},
{["Slot"] = 5,["Name"] = "M4"					  , ["ModelID"]= 356, ["WeaponID"]= 31, ["Price"]= 100},

{["Slot"] = 6,["Name"] = "Country Rifle"		  , ["ModelID"]= 357, ["WeaponID"]= 33, ["Price"]= 100},
{["Slot"] = 6,["Name"] = "Sniper Rifle"           , ["ModelID"]= 358, ["WeaponID"]= 34, ["Price"]= 100},

{["Slot"] = 7,["Name"] = "Rocket Launcher"        , ["ModelID"]= 359, ["WeaponID"]= 35, ["Price"]= 100},
{["Slot"] = 7,["Name"] = "Heat-Seeking RPG"       , ["ModelID"]= 360, ["WeaponID"]= 36, ["Price"]= 100},
{["Slot"] = 7,["Name"] = "Flamethrower"           , ["ModelID"]= 361, ["WeaponID"]= 37, ["Price"]= 100},
{["Slot"] = 7,["Name"] = "Minigun"                , ["ModelID"]= 362, ["WeaponID"]= 38, ["Price"]= 100},

{["Slot"] = 8,["Name"] = "Grenade"                , ["ModelID"]= 342, ["WeaponID"]= 16, ["Price"]= 100},
{["Slot"] = 8,["Name"] = "Tear Gas"               , ["ModelID"]= 343, ["WeaponID"]= 17, ["Price"]= 100},
{["Slot"] = 8,["Name"] = "Molotov Cocktails"      , ["ModelID"]= 344, ["WeaponID"]= 18, ["Price"]= 100},
{["Slot"] = 8,["Name"] = "Satchel Charges"        , ["ModelID"]= 363, ["WeaponID"]= 39, ["Price"]= 100},

{["Slot"] = 9,["Name"] = "Spraycan"               , ["ModelID"]= 365, ["WeaponID"]= 41, ["Price"]= 100},
{["Slot"] = 9,["Name"] = "Fire Extinguisher"      , ["ModelID"]= 366, ["WeaponID"]= 42, ["Price"]= 100},
{["Slot"] = 9,["Name"] = "Camera"                 , ["ModelID"]= 367, ["WeaponID"]= 43, ["Price"]= 100},

{["Slot"] = 10,["Name"] = "Long Purple Dildo"     , ["ModelID"]= 321, ["WeaponID"]= 10, ["Price"]= 100},
{["Slot"] = 10,["Name"] = "Short tan Dildo"       , ["ModelID"]= 322, ["WeaponID"]= 11, ["Price"]= 100},
{["Slot"] = 10,["Name"] = "Vibrator"              , ["ModelID"]= 323, ["WeaponID"]= 12, ["Price"]= 100},
{["Slot"] = 10,["Name"] = "Flowers"               , ["ModelID"]= 325, ["WeaponID"]= 14, ["Price"]= 100},
{["Slot"] = 10,["Name"] = "Cane"                  , ["ModelID"]= 326, ["WeaponID"]= 15, ["Price"]= 100},

{["Slot"] = 11,["Name"] = "Night-Vision Goggles"  , ["ModelID"]= 368, ["WeaponID"]= 44, ["Price"]= 100},
{["Slot"] = 11,["Name"] = "Infrared Goggles"      , ["ModelID"]= 369, ["WeaponID"]= 45, ["Price"]= 100},
{["Slot"] = 11,["Name"] = "Parachute"             , ["ModelID"]= 371, ["WeaponID"]= 46, ["Price"]= 100},

{["Slot"] = 12,["Name"] = "Satchel Detonator"     , ["ModelID"]= 364, ["WeaponID"]= 40, ["Price"]= 100}

}

 WeaponSlot = {}
 WeaponSlot[0] = {1}
 WeaponSlot[1] = {2,3,4,5,6,7,8,9}
 WeaponSlot[2] = {10,11,12}
 WeaponSlot[3] = {13,14,15}
 WeaponSlot[4] = {16,17,18}
 WeaponSlot[5] = {19,20}
 WeaponSlot[6] = {21,22}
 WeaponSlot[7] = {23,24,25,26}
 WeaponSlot[8] = {27,28,29,30}
 WeaponSlot[9] = {31,32,33}
WeaponSlot[10] = {34,35,36,37,38}
WeaponSlot[11] = {39,40,41}
WeaponSlot[12] = {42}

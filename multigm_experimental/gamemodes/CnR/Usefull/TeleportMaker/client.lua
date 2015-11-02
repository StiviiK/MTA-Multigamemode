setDevelopmentMode(true)
local lp = getLocalPlayer()
local Teleports = {} 


local FirstCheck = false
local LastCheck = false

Pickups = {
{["Name"] = "Money (Wad of Cash)",["ID"] = 1212},
{["Name"] = "Health (heart)",["ID"] = 1240},
{["Name"] = "Armour",["ID"] = 1242},
{["Name"] = "Info icon",["ID"] = 1239},
{["Name"] = "House (blue)",["ID"] = 1272},
{["Name"] = "House (green)",["ID"] = 1273},
{["Name"] = "Money (dollar symbol)",["ID"] = 1274},
{["Name"] = "Adrenaline",["ID"] = 1241},
{["Name"] = "Bribe",["ID"] = 1247},
{["Name"] = "GTA III sign",["ID"] = 1248},
{["Name"] = "Bomb from GTA III",["ID"] = 1252},
{["Name"] = "Photo op",["ID"] = 1253},
{["Name"] = "Skull",["ID"] = 1254},
{["Name"] = "Blue t-shirt",["ID"] = 1275},
{["Name"] = "Save disk",["ID"] = 1277},
{["Name"] = "2 Skulls",["ID"] = 1313},
{["Name"] = "Tiki statue",["ID"] = 1276},
{["Name"] = "Parachute (with leg straps)",["ID"] = 1310},
{["Name"] = "Down arrow",["ID"] = 1318},
{["Name"] = "Drug bundle",["ID"] = 1279},
}



GUIEditor = {
    checkbox = {},
    window = {},
    button = {},
    combobox = {},
	edit = {},
	label = {}
}

    function TeleportMenu()
        GUIEditor.window[1] = guiCreateWindow(25, 181, 200, 384, "Teleport CREATOR", false)
        guiWindowSetSizable(GUIEditor.window[1], false)

        GUIEditor.button[1] = guiCreateButton(11, 50, 178, 70, "Save First Position", false, GUIEditor.window[1])
        GUIEditor.button[2] = guiCreateButton(10, 151, 178, 71, "Save Last Position", false, GUIEditor.window[1])
		GUIEditor.button[3] = guiCreateButton(10,356, 178, 40, "Create Teleport", false, GUIEditor.window[1])
        
        GUIEditor.combobox[1] = guiCreateComboBox(10, 232, 178, 125, "", false, GUIEditor.window[1])    
		GUIEditor.checkbox[1] = guiCreateCheckBox(27, 270, 129, 15, "Teleport in two ways", true, false, GUIEditor.window[1])
		
		  GUIEditor.label[1] = guiCreateLabel(27, 300, 171, 30, "Gehe hier Variable Name ein:",false,GUIEditor.window[1])
		    GUIEditor.edit[1] = guiCreateEdit(15, 320, 171, 25, "HierName",false, GUIEditor.window[1])    
		 
	for i = 1,#Pickups do
	guiComboBoxAddItem ( GUIEditor.combobox[1], Pickups[i]["Name"] )
	end
	guiComboBoxSetSelected ( GUIEditor.combobox[1], 18 )
		
		
		
		
				addEventHandler ( "onClientGUIClick", GUIEditor.button[1], function()--first
					Teleports["FistPos"]  = {getElementPosition(lp)}
					Teleports["FistRot"]  = {getElementRotation(lp)}
					Teleports["FistDim"]  = lp:getDimension()
					Teleports["FistInt"]  = lp:getInterior(lp)
					
					FirstCheck = true
					guiSetText(GUIEditor.button[1],"SET 1")
					guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FF29FD00")    

				end )

				addEventHandler ( "onClientGUIClick", GUIEditor.button[2], function()--last
					Teleports["LastPos"]  = {getElementPosition(lp)}
					Teleports["LastRot"]  = {getElementRotation(lp)}
					Teleports["LastDim"]  = lp:getDimension()
					Teleports["LastInt"]  = lp:getInterior(lp)

					LastCheck = true
					guiSetText(GUIEditor.button[2],"SET 2")
					guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FF29FD00")    

				end )

					addEventHandler ( "onClientGUIClick", GUIEditor.button[3], function()--first
								local ItemSelect = tonumber(guiComboBoxGetSelected(GUIEditor.combobox[1])+1)
									if LastCheck and FirstCheck then
									if ItemSelect == 0 then outputChatBox("select a item") return end
									
									 FirstCheck = false
									 LastCheck = false
									 Teleports["TwoWay"] = guiCheckBoxGetSelected ( GUIEditor.checkbox[1] )
									 Teleports["PickupModel"] = tonumber(Pickups[ItemSelect]["ID"])
									 
									
									
										
										Teleports["TeleportName"] = guiGetText(GUIEditor.edit[1])
									 
									  
									  
									triggerServerEvent("CreateTeleport", lp, Teleports)

									guiSetVisible ( GUIEditor.window[1], false )
									showCursor(false)
									else
												if LastCheck then
													outputChatBox("Please set First Position")
												else
													outputChatBox("Please set Last Position")
												end
									end
					end )

    end

addCommandHandler("teleport",TeleportMenu)









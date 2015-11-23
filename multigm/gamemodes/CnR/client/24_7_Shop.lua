Shop_GUI = inherit(GUIForm)
inherit(Singleton, Shop_GUI)


			
function Shop_GUI:constructor()

self.m_Width  = 400
self.m_Height = 500
self.m_X   	  = (screenWidth-self.m_Width)*0.5
self.m_Y 	  = (screenHeight-self.m_Height)*0.5


	GUIForm.constructor(self, self.m_X, self.m_Y, self.m_Width, self.m_Height)
	self.m_Window = GUIWindow:new(0, 0, self.m_Width, self.m_Height, "24/7", true, false,self)

	self.m_BuyItemGrid = GUIGridList:new(self.m_Width*0.02, self.m_Height*0.13, self.m_Width*0.5, self.m_Height*0.7, self.m_Window)
    self.m_BuyItemGrid:addColumn("ID", 0.12)
	self.m_BuyItemGrid:addColumn("Item", 0.5)
    self.m_BuyItemGrid:addColumn("Price", 0.5)
	for i = 1,#ShopItems do
	self.m_BuyItemGrid:addItem(i,ShopItems[i]["Name"], ShopItems[i]["Price"].."€")
	end
	self.m_BuyItemGrid.onSelectItem = function (item)
								local SelectedName = item:getColumnText(1)
								 self.m_BuyInfo:setText(ShopItems[SelectedName]["Description"])
							   end	

	
	self.m_BuyInfo = GUILabel:new(self.m_Width*0.54, self.m_Height*0.13, self.m_Width*0.45, 0, LOREM_IPSUM:sub(1, 296), self.m_Window)
	:setFont(VRPFont((self.m_Height*0.54)/10))
	:setAlignX("center")
	 self.m_Buy = VRPButton:new(self.m_Width*0.02 , self.m_Height*0.88, self.m_Width*0.45, self.m_Height*0.1, "Buy", true, self.m_Window)
	 :setBarColor(Color.Green)
	 
	 self.m_Buy.onLeftClick = function ()
	 
								local BuyID = self.m_BuyItemGrid:getSelectedItem():getColumnText(1)
									triggerServerEvent("BuyShopItem",lp,BuyID)
							   end
	 
	 self.m_Exit = VRPButton:new(self.m_Width*0.53, self.m_Height*0.88, self.m_Width*0.45, self.m_Height*0.1, "Exit", true, self.m_Window)
	 :setBarColor(Color.Red)

self.m_Exit.onLeftClick = function ()
							self:close()
							Cursor:hide()
						  end
end

function CopsnRobbers:ShopGUI_Event ()
self.ShopGUI_open_EventHandler  = function(...) self:ShopGUI_open(...) end
self.ShopGUI_close_EventHandler = function(...) self:ShopGUI_close(...) end

addRemoteEvents{"OpenShopGUI"}
addEventHandler("OpenShopGUI", root,  self.ShopGUI_open_EventHandler )

addRemoteEvents{"CloseShopGUI"}
addEventHandler("CloseShopGUI", root, self.ShopGUI_close_EventHandler)
end

function CopsnRobbers:ShopGUI_open ()
Shop_GUI:getSingleton():show()
Cursor:show()
end



function CopsnRobbers:ShopGUI_close ()
Shop_GUI:getSingleton():close()
Cursor:hide()
end

function CopsnRobbers:ShopGUI_destructor ()
Shop_GUI:getSingleton():destructor()
end




function CopsnRobbers:CreateMoneyDeliveryCheckpoint(Dim)
local RandomDeliveryPoint = math.random(1,#CNR_LootDeliveryPoints)
local x = CNR_LootDeliveryPoints[RandomDeliveryPoint]["x"]
local y = CNR_LootDeliveryPoints[RandomDeliveryPoint]["y"]
local z = CNR_LootDeliveryPoints[RandomDeliveryPoint]["z"]

if self.MoneyDeliveryCheckpoint or self.MoneyDeliveryCheckpointBlip then self:DestroyMoneyDeliveryCheckpoint(source) end
DebugOutPut("CreateMoneyDeliveryCheckpoint")
self.MoneyDeliveryCheckpoint 	 = createMarker ( x,y,z, "cylinder", 4, 255, 0, 0, 255 )
self.MoneyDeliveryCheckpoint:setDimension(Dim)
self.MoneyDeliveryCheckpointBlip = createBlip   ( x,y,z, 41 )
self.MoneyDeliveryCheckpointHandler = function(...) self:GivePlayerRobberyMoney(...) end
addEventHandler ( "onClientMarkerHit", self.MoneyDeliveryCheckpoint, self.MoneyDeliveryCheckpointHandler )
end

function CopsnRobbers:GivePlayerRobberyMoney(hitPlayer, matchingDimension)
	if getElementType( hitPlayer ) == "player" and matchingDimension then
		triggerServerEvent("givePlayerRobbedMoney",hitPlayer)
		self:DestroyMoneyDeliveryCheckpoint(hitPlayer)
	end
end

function CopsnRobbers:DestroyMoneyDeliveryCheckpoint(Robber)
DebugOutPut("DestroyMoneyDeliveryCheckpoint")
	if self.MoneyDeliveryCheckpoint or self.MoneyDeliveryCheckpointBlip then
		self.MoneyDeliveryCheckpoint:destroy()	
		self.MoneyDeliveryCheckpointBlip:destroy()	 
		self.MoneyDeliveryCheckpoint = false
		self.MoneyDeliveryCheckpointBlip = false
	end
end

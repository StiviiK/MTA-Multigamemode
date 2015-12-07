
function CopsnRobbers:addEventOnPlayerClickPed (ped)
ClickHandler:getSingleton():addElementMenu(self,Shop_GUI, ped)
end

function CopsnRobbers:removeEventOnPlayerClickPed (ped)
--ClickHandler:getSingleton():RemoveElementMenu(self,ped)
end










Shop_GUI = inherit(GUIForm)
inherit(Singleton, Shop_GUI)



function Shop_GUI:constructor(CNR_SELF)
self.m_Width  = 400
self.m_Height = 500
self.m_X   	  = (screenWidth-self.m_Width)*0.5
self.m_Y 	  = (screenHeight-self.m_Height)*0.5


	GUIForm.constructor(self, self.m_X, self.m_Y, self.m_Width, self.m_Height)
	self.m_Window = GUIWindow:new(0, 0, self.m_Width, self.m_Height, "24/7", true, false,self)

	self.m_BuyItemGrid = GUIGridList:new(self.m_Width*0.02, self.m_Height*0.13, self.m_Width*0.5, self.m_Height*0.7, self.m_Window):setColor(CNR_SELF:getColor())
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
									if self.m_BuyItemGrid:getSelectedItem() then
										local BuyID = self.m_BuyItemGrid:getSelectedItem():getColumnText(1)
										triggerServerEvent("BuyShopItem",lp,BuyID)
									end
							   end

	 self.m_Exit = VRPButton:new(self.m_Width*0.53, self.m_Height*0.88, self.m_Width*0.45, self.m_Height*0.1, "Exit", true, self.m_Window)
	 :setBarColor(Color.Red)

self.m_Exit.onLeftClick = function ()
							self:ShopGUI_close ()
						  end
 toggleAllControls(false)
end



function Shop_GUI:ShopGUI_open ()
self:getSingleton():show()
Cursor:show()
toggleAllControls(false)
end

function Shop_GUI:ShopGUI_close ()
self:getSingleton():close()
Cursor:hide()
toggleAllControls(true)
end


function CopsnRobbers:ShopGUI_Event ()
Shop_GUI:new(self):close()
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
toggleAllControls(false)
end



function CopsnRobbers:ShopGUI_close ()
Shop_GUI:getSingleton():close()
Cursor:hide()
toggleAllControls(true)
end

function CopsnRobbers:ShopGUI_destructor ()
Shop_GUI:getSingleton():destructor()
end

Shop_GUI = inherit(GUIForm)
inherit(Singleton, Shop_GUI)

function RandomString(length)
           length = length or 1
                if length < 1 then return nil end
                local array = {}
                for i = 1, length do
                        array[i] = string.char(math.random(32, 126))
                end
                return table.concat(array)
end
  
function Shop_GUI:constructor()
self.m_X   	  = 200
self.m_Y 	  = 0
self.m_Width  = 300
self.m_Height = 400

	self.m_Window = GUIWindow:new(self.m_X, self.m_Y, self.m_Width, self.m_Height, "24/7", true, true)

	self.m_BuyItemGrid = GUIGridList:new(self.m_Width*0.02, self.m_Height*0.13, self.m_Width*0.5, self.m_Height*0.7, self.m_Window)
    self.m_BuyItemGrid:addColumn("Item", 0.5)
    self.m_BuyItemGrid:addColumn("Price", 0.5)
	for i = 1,20 do
	self.m_BuyItemGrid:addItem("CAMERA", math.random(1,9999))
	end
		

	
	self.m_BuyInfo = GUILabel:new(self.m_Width*0.54, self.m_Height*0.13, self.m_Width*0.45, 0, LOREM_IPSUM:sub(1, 296), self.m_Window)
	:setFont(VRPFont((self.m_Height*0.54)/10))
	
	 self.m_Buy = VRPButton:new(self.m_Width*0.02 , self.m_Height*0.88, self.m_Width*0.45, self.m_Height*0.1, "Buy", true, self.m_Window)
	 :setBarColor(Color.Green)
	 
	 self.m_Buy.onLeftClick = function ()
	 
							outputChatBox("Buy"..tostring(self.m_BuyItemGrid:getSelectedItem():getColumnText(1)))
						  end
	 
	 self.m_Exit = VRPButton:new(self.m_Width*0.53, self.m_Height*0.88, self.m_Width*0.45, self.m_Height*0.1, "Exit", true, self.m_Window)
	 :setBarColor(Color.Red)

self.m_Exit.onLeftClick = function ()
							self.m_Window:delete()
						  end
end
bindKey("g","down",function()
-- showChat ( false )
showPlayerHudComponent("all",false)
Shop_GUI:new()
end)

Shop = {}


function Shop:constructor(CNR_SELF,Shop_Int,Shop_Dim,SellerPed_Pos,SellerPed_Skin,SellerPed_Rot,BuyMarker_Pos,BuyMarker_Size,BuyMarker_Color)
self.Shop_Int = Shop_Int
self.Shop_Dim = Shop_Dim

self.SellerPed_Pos  = SellerPed_Pos
self.SellerPed_Skin = SellerPed_Skin
self.SellerPed_Rot  = SellerPed_Rot

self.BuyMarker_Pos   = BuyMarker_Pos
self.BuyMarker_Size  = BuyMarker_Size
self.BuyMarker_Color = BuyMarker_Color


self.MarkerHitHandler = function(player,dim) self:OnMarkerHit(player,dim) end
self.MarkerLeaveHandler = function(player,dim) self:OnMarkerLeave(player,dim) end

self:CreateSellerPed()
self:CreateBuyMarker()
end

function Shop:destructor()
self.SellerPed:destroy()
self.BuyMarker:destroy()
removeEventHandler( "onMarkerHit", self.BuyMarker, self.MarkerHitHandler )
end

function Shop:CreateSellerPed()
self.SellerPed =  createPed ( self.SellerPed_Skin, self.SellerPed_Pos )
self.SellerPed:setDimension(self.Shop_Dim )
self.SellerPed:setInterior(self.Shop_Int )
self.SellerPed:setRotation(0,0,self.SellerPed_Rot)
end

function Shop:CreateBuyMarker()
self.BuyMarker =  createMarker ( self.BuyMarker_Pos, "cylinder", self.BuyMarker_Size, self.BuyMarker_Color[1], self.BuyMarker_Color[2], self.BuyMarker_Color[3], self.BuyMarker_Color[4] )
self.BuyMarker:setDimension(self.Shop_Dim )
self.BuyMarker:setInterior(self.Shop_Int )

addEventHandler( "onMarkerHit"  , self.BuyMarker, self.MarkerHitHandler )
addEventHandler( "onMarkerLeave", self.BuyMarker, self.MarkerLeaveHandler )
end



function Shop:OnMarkerHit(player,dim)
player:triggerEvent("OpenShopGUI",player)
end

function Shop:OnMarkerLeave(player,dim)
player:triggerEvent("CloseShopGUI",player)
player:triggerEvent("CloseShopGUI",player)
end

function BuyShopItem (BuyID)
local u_Money        = getPlayerMoney(source)
local BuyItemPrice   = ShopItems[BuyID]["Price"]
local BuyItemName    = ShopItems[BuyID]["Name"]

	if (u_Money - BuyItemPrice) >= 0 then
		takePlayerMoney(source,BuyItemPrice)
		outputChatBox("Shop Item Kaufen:"..BuyItemName)
		outputChatBox("Hier noch item geben einfügen",getRootElement(),255,0,0)
		playSoundFrontEnd(source,46)
	else
		DebugOutPut("zu wenig geld")
	end

-----------CNR_DEBUG---------------
--DebugOutPut(("%s Weapon:%s Ammo:%s"):format(source:getName(),WeaponID,WeaponAmmo))
-----------------------------------
end
addRemoteEvents{"BuyShopItem"}
addEventHandler("BuyShopItem", root, BuyShopItem)
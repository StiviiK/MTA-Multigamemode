Shop = {}
Shop.ID = 0
function Shop:constructor(CNR_SELF,Shop_Int,Shop_Dim,SellerPed_Pos,SellerPed_Skin,SellerPed_Rot,Blip_Pos)
self.Shop_Int = Shop_Int
self.Shop_ID = Shop.ID+1
self.Shop_Dim = Shop_Dim
self.CNR_SELF = CNR_SELF
self.SellerPed_Pos  = SellerPed_Pos
self.SellerPed_Skin = SellerPed_Skin
self.SellerPed_Rot  = SellerPed_Rot
self.PedRespawnTime = 5000
self.ColEnter =		    function(...) self:OnPlayerEnterCol(...) end
self.ColLeave =			function(...) self:OnPlayerLeaveCol(...) end
self.PedWastedEvent =	function(...) self:OnPedWasted(...)      end

-- self.ShopBlip = createBlip(Blip_Pos,36)

self:CreateSellerPed()
end

function Shop:destructor()
removeEventHandler ( "onPedWasted", self.SellerPed, self.PedWastedEvent )
removeEventHandler ( "onColShapeHit", self.SellerPedCol, self.ColEnter )
removeEventHandler ( "onColShapeHit", self.SellerPedCol, self.ColLeave )
self.SellerPed:destroy()
end

function Shop:CreateSellerPed()
DebugOutPut("CreateSellerPed",0,255,0)
self.SellerPed    =  createPed ( self.SellerPed_Skin, self.SellerPed_Pos )
enew(self.SellerPed,PedRobberySystem,self)
self.SellerPed:setDimension(self.Shop_Dim )
self.SellerPed:setInterior(self.Shop_Int )
self.SellerPed:setRotation(0,0,self.SellerPed_Rot)
self.SellerPed:setFrozen(true)

self.SellerPedCol =  createColSphere ( self.SellerPed_Pos, 5 )
self.SellerPedCol:setDimension(self.Shop_Dim )
addEventHandler ( "onPedWasted", self.SellerPed, self.PedWastedEvent )
addEventHandler ( "onColShapeHit", self.SellerPedCol, self.ColEnter )
addEventHandler ( "onColShapeLeave", self.SellerPedCol, self.ColLeave )
end

function Shop:OnPlayerEnterCol(thePlayer, matchingDimension)
	if matchingDimension then
		triggerClientEvent(thePlayer,"addEventOnPlayerClickPed",thePlayer,self.SellerPed)
	end
end

function Shop:OnPlayerLeaveCol(thePlayer, matchingDimension)
	if matchingDimension then
		triggerClientEvent(thePlayer,"removeEventOnPlayerClickPed",thePlayer,self.SellerPed)
	end
end

function Shop:OnPedWasted ()
DebugOutPut("Shop:OnPedWasted")
local ShopSelf = self
setTimer(function() ShopSelf:destructor() ShopSelf:CreateSellerPed() end,self.PedRespawnTime,1)
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


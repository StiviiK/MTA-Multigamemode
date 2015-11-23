Shop = {}

-------------Interio überprüfung einfügen
function Shop:constructor(CNR_SELF,Shop_Int,Shop_Dim,SellerPed_Pos,SellerPed_Skin,SellerPed_Rot,Blip_Pos)
self.Shop_Int = Shop_Int
self.Shop_Dim = Shop_Dim
self.CNR_SELF = CNR_SELF
self.SellerPed_Pos  = SellerPed_Pos
self.SellerPed_Skin = SellerPed_Skin
self.SellerPed_Rot  = SellerPed_Rot

self.OnPedClickHandler = function(...) self:OnPedClick(...) end
self.OnPlayerTargetPedHandler = function(...) self:OnPlayerTargetPed(...) end
self.OnPedDiedHandler = function(...) self:OnPedDied(...) end

self:CreateSellerPed()
self.CanBeRobbed = true
self.AfterRobbTime = 15000
self.HowLongAimOnPedToRob = 1000
self.RespawnPedTime = 10000
self.WaitForMoney = 10000
self.RobTimer = false
self.WantedsForKillPed = 2
self.WantedsForRobbingShop = 2
self.RobbedMoney = 2000

self.ShopBlip = createBlip(Blip_Pos,36)
end

function Shop:destructor()
removeEventHandler( "onElementClicked", self.SellerPed, self.OnPedClickHandler )
removeEventHandler ( "onPlayerTarget", getRootElement(), self.OnPlayerTargetPedHandler )
removeEventHandler("onPedWasted", self.SellerPed, self.OnPedDiedHandler)
self.SellerPed:destroy()
end

function Shop:CreateSellerPed()
DebugOutPut("CreateSellerPed",0,255,0)
self.SellerPed =  createPed ( self.SellerPed_Skin, self.SellerPed_Pos )
self.SellerPed:setDimension(self.Shop_Dim )
self.SellerPed:setInterior(self.Shop_Int )
self.SellerPed:setRotation(0,0,self.SellerPed_Rot)
self.SellerPed:setFrozen(true)
addEventHandler( "onElementClicked"  , self.SellerPed, self.OnPedClickHandler )
addEventHandler ( "onPlayerTarget",getRootElement(), self.OnPlayerTargetPedHandler )
addEventHandler("onPedWasted", self.SellerPed, self.OnPedDiedHandler)
self.CanBeRobbed = true
end

function Shop:OnPedDied(  totalAmmo,  killer,  killerWeapon,  bodypart,  stealth  )
self.CanBeRobbed = false
self.CNR_SELF:GivePlayerWanteds(killer,self.WantedsForKillPed)

--self.WantedsForKillPed
self.RespawnTimer = setTimer(function()
	
							 self:RestartShopPed ()
							
							 end,self.RespawnPedTime,1)

end

function Shop:RestartShopPed ()
self:destructor()
self:CreateSellerPed()
end


function Shop:OnPlayerTargetPed( targetElem  )
local Robber = source
local isPlayerAiming = getControlState ( Robber, "aim_weapon" )

	if targetElem and targetElem == self.SellerPed and isPlayerAiming and self.CanBeRobbed then

	local WeapSlot 	     = getPedWeaponSlot ( source )
	local AllowedWeaponSlot = {2,3,4,5,6}
	DebugOutPut("test:"..tostring(AllowedWeaponSlot[tonumber(WeapSlot)]).."| WeapSlot:"..tonumber(WeapSlot))
		if AllowedWeaponSlot[WeapSlot]  then


		if isTimer(self.RobTimer) then killTimer(self.RobTimer) self.RobTimer = false end
		self.RobTimer = setTimer(
		function() 
			if Robber and getControlState ( Robber, "aim_weapon" ) then 
			self:StartRob(Robber) 
			else
			if isTimer(self.RobTimer) then killTimer(self.RobTimer) self.RobTimer = false end
			end 
		end,self.HowLongAimOnPedToRob,1)
		
		end
	end
end

function Shop:StartRob(Robber)
	if self.CanBeRobbed then
		self.CanBeRobbed = false
		self.CNR_SELF:GivePlayerWanteds(Robber,self.WantedsForRobbingShop)
		setTimer(function() self.CanBeRobbed = true self:RestartShopPed () DebugOutPut("RESTART: CanBeRobbed") end,self.AfterRobbTime,1)
		setTimer(function() self:GiveRobLoot(Robber) end,self.WaitForMoney,1)
		----Animation----
		setPedAnimation( self.SellerPed, "SHOP", "SHP_Rob_React",4,false,true)
		setTimer(function() setPedAnimation( self.SellerPed, "SHOP", "SHP_Serve_End",4,true,true)    end,1000,1)
		setTimer(function() setPedAnimation( self.SellerPed, "SHOP", "SHP_Rob_GiveCash",4,false) end,self.WaitForMoney-2000,1)
		

		DebugOutPut("Start Rob")
	end
end

function Shop:GiveRobLoot(Robber)
local money
if isPedDead(self.SellerPed) then outputChatBox("Robbing Failed Ped Died") return end
	if tonumber(getElementData(Robber,"RobbedMoney")) then
		 money = tonumber(getElementData(Robber,"RobbedMoney"))+self.RobbedMoney
	else
		 money = self.RobbedMoney
	end
setElementData(Robber,"RobbedMoney", money)
outputChatBox("Bringe das Geld in Sicherheit begebe dich zum ....")

triggerClientEvent(Robber,"CreateMoneyDeliveryCheckpoint",Robber,self.CNR_SELF:getDimension())
end



function Shop:OnPedClick( theButton, theState, thePlayer )
    if theButton == "left" and theState == "down" and source == self.SellerPed then
		thePlayer:triggerEvent("OpenShopGUI",thePlayer)
	end
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




function givePlayerRobbedMoney ()
local RobbedMoney = tonumber(getElementData(source,"RobbedMoney"))
givePlayerMoney(source,RobbedMoney)
setElementData( source,"RobbedMoney", 0)
end
addRemoteEvents{"givePlayerRobbedMoney"}
addEventHandler("givePlayerRobbedMoney", root, givePlayerRobbedMoney)

function CopsnRobbers:CreateAmmunationShops ()
------Ammunation Shop 1 ------------
local Shop_Int        = 4
local Shop_Dim        = 4
local SellerPed_Pos   = Vector3(295.5,-82.716300964355,1001.515625)
local SellerPed_Skin  = 1
local SellerPed_Rot   = 0
local BuyMarker_Pos   = Vector3(295.5,-80,1000.5)
local BuyMarker_Size  = 1.5 
local BuyMarker_Color = {255,255,0,100}
local Weapon_Pos      = {295.5,-81.5,1001.8}
local LookMatrix      = {295.54571533203 , -80.03190612793 , 1002.8734130859 , 297.32876586914 , -159.05169677734 , 941.61419677734}

self.AmmuationShop1 = new(WeaponShop,self,Shop_Int,Shop_Dim,SellerPed_Pos,SellerPed_Skin,SellerPed_Rot,BuyMarker_Pos,BuyMarker_Size,BuyMarker_Color,Weapon_Pos,LookMatrix)

end

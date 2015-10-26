function CopsnRobbers:CreateShops ()
------ Shop 1 ------------
local Shop_Int        = 4
local Shop_Dim        = 4
local SellerPed_Pos   = Vector3(295.5,-82.716300964355,1001.515625)
local SellerPed_Skin  = 1
local SellerPed_Rot   = 0
local BuyMarker_Pos   = Vector3(295.5,-80,1000.5)
local BuyMarker_Size  = 1.5 
local BuyMarker_Color = {255,255,0,100}



self.Shop1 = new(Shop,self,Shop_Int,Shop_Dim,SellerPed_Pos,SellerPed_Skin,SellerPed_Rot,BuyMarker_Pos,BuyMarker_Size,BuyMarker_Color)

end

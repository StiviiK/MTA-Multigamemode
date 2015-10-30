function CopsnRobbers:CreateShops ()
------ Shop 1 ------------
local Shop_Int        = 18
local Shop_Dim        = 4
local SellerPed_Pos   = Vector3(-28.114866256714,-91.648895263672,1003.546875)
local SellerPed_Skin  = 1
local SellerPed_Rot   = 0
local BuyMarker_Pos   = Vector3(-28.024250030518,-89.679550170898,1002.7)
local BuyMarker_Size  = 1 
local BuyMarker_Color = {255,255,0,100}



self.Shop1 = new(Shop,self,Shop_Int,Shop_Dim,SellerPed_Pos,SellerPed_Skin,SellerPed_Rot,BuyMarker_Pos,BuyMarker_Size,BuyMarker_Color)

end

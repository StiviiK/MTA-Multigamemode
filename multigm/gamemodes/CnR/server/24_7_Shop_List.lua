function CopsnRobbers:CreateShops ()
------ Shop 1 ------------
local Shop_Int        = 18
local Shop_Dim        = self:getDimension()
local SellerPed_Pos   = Vector3(-26.99,-91.5,1003,546)
local SellerPed_Skin  = 1
local SellerPed_Rot   = 0

local Blip_Pos   = Vector3(1316,-899,40)

self.Shop1 = new(Shop,self,Shop_Int,Shop_Dim,SellerPed_Pos,SellerPed_Skin,SellerPed_Rot,Blip_Pos)

TeleportList["Shop1"] = new(Teleports,Vector3(1315.5208740234,-897.89642333984,39.578125),Vector3(0,0,358.49523925781),0,4,Vector3(-30.959457397461,-91.998641967773,1003.546875),Vector3(0,0,179.48039245605),18,4,true,1318)
 

end





--StartPos,StartRot,StartInt,StartDim,EndPos,EndRot,EndInt,EndDim,twoway,model
TeleportList = {}

function CopsnRobbers:CreateTeleports ()

 TeleportList["LSPD_Eingang"] = new(Teleports,Vector3(1555.4998779297,-1675.7,16.1953125),Vector3(0,0,270),0,self:getDimension(),Vector3(246.8,62.325183868408,1003.640625),Vector3(0,0,185.36302185059),6,self:getDimension(),true,1318)

  TeleportList["LSPD_Garage"] = new(Teleports,Vector3(246.42230224609,87.710479736328,1003.640625),Vector3(0,0,1.7713385820389),6,self:getDimension(),Vector3(1524.486328125,-1677.8879394531,6.21875),Vector3(0,0,92.012161254883),0,self:getDimension(),true,1318)
 
end
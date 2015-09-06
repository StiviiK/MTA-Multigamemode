TEST_Hologramm = inherit(Object)

function TEST_Hologramm:constructor()
  self.m_RenderTarget = dxCreateRenderTarget(1, 1)
  addEventHandler("onClientRender", root, bind(self.drawThis, self))
end

function TEST_Hologramm:destructor()
end

function TEST_Hologramm:drawThis()
  outputDebug("draw")
  for i = 1, 10000, 1 do
    dxDrawMaterialLine3D(Vector3(0, 0, 3 + i*0.001), Vector3(10, 10, 3 + i*0.001), self.m_RenderTarget, (Vector3(0, 0, 3) + Vector3(10, 10, 3)):getLength(), tocolor(255, 255, 255, 255), Vector3(10, 10, 4))
  end
end

--TEST_Hologramm:new()

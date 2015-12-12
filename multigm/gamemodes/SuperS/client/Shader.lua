local Shader = inherit(Object)

function Shader:constructor(filePath)
  self.m_FilePath = filePath
  self.m_Shader = dxCreateShader(self.m_FilePath)
  self.m_Texture = false

  if not self.m_Shader then
    outputDebug("Could not create Shader, deleting Instance...")
    delete(self)
  end
end

function Shader:destructor()
  if self.m_Texture then
    destroyElement(self.m_Texture)
  end
  if self.m_Shader then
    destroyElement(self.m_Shader)
  end
end

function Shader:setTexture(filePath)
  self.m_Texture = dxCreateTexture(filePath)
  if not self.m_Texture then
    -- ERROR
  end
end

function Shader:applyShaderValue(key, value)
  local value = value or self.m_Texture
  dxSetShaderValue(self.m_Shader, key, value)
end

function Shader:applyToWorldTexture(worldTex)
  engineApplyShaderToWorldTexture(self.m_Shader, worldTex)
end

-- "Export" to SuperS
SuperS.Shader = Shader

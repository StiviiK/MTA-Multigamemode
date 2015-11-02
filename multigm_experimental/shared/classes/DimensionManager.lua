DimensionManager = inherit(Singleton)

function DimensionManager:constructor()
    self.m_Dimensions = {
      [1] = true, -- reserved
      [2] = true, -- reserved
      [PRIVATE_DIMENSION_SERVER] = true, -- reserved
    }
end

function DimensionManager:getFreeDimension()
    local dim = 0
	repeat
 		dim = dim + 1
 	until not self.m_Dimensions[dim]

 	self.m_Dimensions[dim] = true
    return dim
end

function DimensionManager:freeDimension(dim)
    self.m_Dimensions[dim] = nil
end

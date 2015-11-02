MTAElement = inherit(Object)
registerElementClass("ped", MTAElement)
registerElementClass("object", MTAElement)
registerElementClass("pickup", MTAElement)
registerElementClass("marker", MTAElement)
registerElementClass("colshape", MTAElement)

function MTAElement:constructor()
	self.m_Data = {}
end

function MTAElement:virtual_constructor()
	MTAElement.constructor(self)
end

function MTAElement:setData(key, value, sync)
	self.m_Data[key] = value

	if sync then
		setElementData(self, key, value)
	end
end

function MTAElement:getData(key)
	return self.m_Data[key]
end

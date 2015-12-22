Animation.FontSize = inherit(Animation)

-- Move the gui element
function Animation.FontSize:constructor(guielement, time, type, s, ts)
	self.m_Element = guielement
	self.m_Time = time
	self.m_Size = s
	self.m_TSize = ts
  self.m_Font = type
	self.m_Start = getTickCount()
	self.m_fnPreRender = bind(Animation.FontSize.preRender, self)
	addEventHandler("onClientPreRender", root, self.m_fnPreRender)
end

function Animation.FontSize:destructor()
	removeEventHandler("onClientPreRender", root, self.m_fnPreRender)
end

function Animation.FontSize:preRender()
	local progress = (getTickCount() - self.m_Start) / self.m_Time
	if progress >= 1 then
		if self.onFinish then
			self.onFinish(self)
		end
		self.m_Element:setFont(self.m_Font(self.m_TSize))
		delete(self)
	else
		local size = self.m_Size + (self.m_TSize - self.m_Size) * progress
    outputDebug(size)
		self.m_Element:setFont(self.m_Font(size))
	end
end

Root = inherit(MTAElement)

function Root:new(...)
  return enew(Element("root"), self, ...)
end

function Root:constructor()
end

function Root:destructor()
  for i, v in pairs(self:getChildren()) do
    if isElement(v) then
      destroyElement(v)
    end
  end
end

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

function Root:getAllByType(type, startAt)
  local elements = {}
  for i, v in pairs(Element.getAllByType(type or "player", startAt or self)) do
    if v:getParent() == self then
      table.insert(elements, v)
    end
  end
  return elements
end

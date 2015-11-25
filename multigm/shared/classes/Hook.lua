Hook = inherit(Object)

function Hook:constructor()
    self.m_Functions = {}
end

function Hook:register(hookFunc)
    return table.push(self.m_Functions, hookFunc)
end

function Hook:remove(hookFunc)
  local idx = table.find(self.m_Functions, hookFunc)
  if idx then
    return table.remove(self.m_Functions, idx)
  end
  return false  
end

function Hook:call(...)
    for k, hookFunc in pairs(self.m_Functions) do
        if hookFunc(...) then
            return true
        end
    end
end

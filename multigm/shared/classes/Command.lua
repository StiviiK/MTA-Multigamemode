Command = inherit(Object)
Command.Map = {}

function Command.get(cmd)
  return Command.Map[cmd]
end

function Command:new(cmd, ...)
  if Command.Map[cmd] then
    for _, func in pairs({...}) do
      Command.Map[cmd]:addFunction(func)
    end
    return Command.Map[cmd]
  end

  Command.Map[cmd] = new(self, cmd, ...)
  return Command.Map[cmd]
end

function Command:constructor(cmd, ...)
  self.m_CommandName = cmd
  self.m_Functions = {...}
  self.m_Handler = bind(Command.handleCommand, self)

  addCommandHandler(self.m_CommandName, self.m_Handler)
end

function Command:destructor()
  removeCommandHandler(self.m_CommandName, self.m_Handler)
  Command.Map[self.m_CommandName] = nil
end

function Command:addFunction(func)
  if table.find(self.m_Functions, func) then return false end
  self.m_Functions[#self.m_Functions + 1] = func
end

function Command:removeFunction(func)
  local idx = table.find(self.m_Functions, func)
  if idx then
    self.m_Functions[idx] = nil
  end
end

function Command:handleCommand(...)
  for _, func in pairs(self.m_Functions) do
    func(...)
  end
end

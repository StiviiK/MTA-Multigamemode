RPC = inherit(Singleton)
RPC.Map = {}

--[[
TODO:
 - Implement Token System, each class has it own RPC Token
 - So nobody else can easily trigger an Event -> AntiCheat
 - Each event requires an valid token, otherwise it gets not triggerd
 - Only CLIENT!
]]

function RPC:constructor()
  --[[
  self.m_Logger = Logger:new()
  self.m_Logger:setPrefix("RPC")
  self.m_Logger:setName("RPC.log")
  --]]

  addEvent("RPC_CALL", true)
  addEventHandler("RPC_CALL", root, bind(self.onCall, self))
end

function RPC:registerFunc(rpcName, func)
  if not RPC.Map[rpcName] then RPC.Map[rpcName] = Hook:new() end
  RPC.Map[rpcName]:register(func)
end

function RPC:removeFunc(rpcName, func)
  if RPC.Map[rpcName] then
    RPC.Map[rpcName]:remove(func)
  end
end

function RPC:call(rpcName, ...)
  local args = {...}
  local arg1 = root
  local arg2 = rpcName
  if type(arg2) ~= "string" then
    arg1 = arg2
    arg2 = args[1]
    table.remove(args, 1)
  end
  outputDebug(("RPC:call(%s->%s)"):format(tostring(arg2), tostring(arg1:getType() == "player" and arg1:getName() or "root")))

  if SERVER then
    triggerClientEvent(arg1, "RPC_CALL", root, arg2, unpack(args))
  else
    triggerServerEvent("RPC_CALL", root, arg2, unpack(args))
  end

  --[[
  self.m_Logger:log(TODO)
  ]]
end

function RPC:callCustom(rpcName, client, ...)
  return self:call(client, rpcName, ...)
end

function RPC:onCall(rpcName, ...)
  outputDebug(("RPC:onCall(%s, %s)"):format(rpcName, source:getType() == "player" and source:getName() or (SERVER and client:getName() or "SERVER")))

  if RPC.Map[rpcName] then
    if SERVER then
      _G["client"] = client -- TODO: TEST IT! (Hacky :P)

      RPC.Map[rpcName]:call(client, ...)

      _G["client"] = nil
    else
      RPC.Map[rpcName]:call(...)
    end
  else
    outputDebug(("Unregistered RPC Call: %s!"):format(rpcName))
  end
end

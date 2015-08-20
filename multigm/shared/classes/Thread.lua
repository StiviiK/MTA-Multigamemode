Thread = inherit(Object)
Thread.Map = {}
Thread.Piority = {
  ["highest"] = 50;
  ["high"] = 150;
  ["middle"] = 250;
  ["low"] = 500;
}

function Thread:constructor(func)
  self.m_Id = table.push(Thread.Map, self)
  self.m_Func = func
  self.m_Piority = THREAD_PIORITY_LOW
  self.ms_Thread = false
  self.ms_Timer = false
end

function Thread:destructor()
  Thread.Map[self:getId()] = nil
  self.ms_Thread = nil

  if isTimer(self.ms_Timer) then
    killTimer(self.ms_Timer)
  end
end

function Thread:start(...)
  self.ms_Thread = coroutine.create(self.m_Func)
  self:resume(...)

  self.ms_Timer = setTimer(function()
    if self:getStatus() == COROUTINE_STATUS_SUSPENDED then
      self:resume()
    elseif self:getStatus() == COROUTINE_STATUS_DEAD then
      delete(self)
    end
  end, Thread.Piority[self:getPiority()], -1)
end

function Thread:resume(...)
  return coroutine.resume(self:getThread(), ...)
end

function Thread.pause()
  return coroutine.yield()
end

function Thread:getStatus()
  return coroutine.status(self:getThread())
end

function Thread:getId()
  return self.m_Id
end

function Thread:getPiority()
  return self.m_Piority
end

function Thread:getThread()
  return self.ms_Thread
end

function Thread:setPiority(piority)
  self.m_Piority = piority
end

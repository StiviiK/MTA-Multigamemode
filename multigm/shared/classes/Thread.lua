Thread = inherit(Object)
Thread.Map = {}

function Thread:constructor(func)
  self.m_Id = table.push(Thread.Map, self)
  self.m_Func = func
  self.m_Piority = THREAD_PIORITY_LOW
  self.ms_Thread = false
  self.ms_Timer = false
  self.m_Yields = 0
  self.ms_StartTime = 0
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
  self.ms_StartTime = getTickCount()
  self:resume(...)

  self.ms_Timer = setTimer(function()
    if self:getStatus() == COROUTINE_STATUS_SUSPENDED then
      self:resume()
      self.m_Yields = self.m_Yields + 1
    elseif self:getStatus() == COROUTINE_STATUS_DEAD then
      delete(self)
    end
  end, self:getPiority(), -1)
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

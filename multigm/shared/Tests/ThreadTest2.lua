-- Test with OOP
local class = inherit(Object)

function class:constructor()
  self.m_Test = math.random(1, 10000)

  self.m_Thread = Thread:new(bind(self.loop, self))
end

function class:loop()
  counter = 0

  print("OOP Value: "..self.m_Test)
  for i = 1, 100000 do
    --print(i)

    counter = counter + 1
    if counter == 1000 then
      print("OOP Value: "..self.m_Test)
      print("STOP!")
      counter = 0

      Thread.pause()
    end
  end
end

local test = class:new()
test.m_Thread:start()

local test2 = class:new()
test2.m_Thread:start()

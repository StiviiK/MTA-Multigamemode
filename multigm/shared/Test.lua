local thisThread
local withThread = false

local lel = function (a, b, c)
  print(a, b, c)

  local counter = 0
  for i = 1, 100000 do
    print(i)

    counter = counter + 1
    if counter == 1000 then
      print("STOP!")
      counter = 0

      if withThread then
        Thread.pause()
      end
    end
  end
end

addCommandHandler("testThread", function (cmd, play, arg)
  if arg == "true" then
    withThread = true
  else
    withThread = false
  end

  if withThread then
    outputDebug("Running Loop with Thread")
    local start = getTickCount()

    -- With Threads
    thisThread = Thread:new(lel, 1, 12, 23)
    --thisThread:setPiority(THREAD_PIORITY_HIGHEST)
    thisThread:start()

    outputDebug(("Server executed this after %sms."):format(getTickCount()-start))
    outputDebug("The Server can while running the loop, do other stuff.")
  else
    outputDebug("Running Loop without Thread")
    local start = getTickCount()

    -- Without Threads
    lel(1, 12, 23)

    outputDebug(("Server executed this after %sms."):format(getTickCount()-start))
    outputDebug("The Server cannot while running the loop, do other stuff.")
  end
end)

local x,y = 200, 400
local screenX, screenY = guiGetScreenSize()
myRenderTarget = dxCreateRenderTarget( x,y )

function Test__GUI ()

GM = CS_Deathmath:getInstance()
 if myRenderTarget and GM then
            dxSetRenderTarget( myRenderTarget ) 
             local i = 50			
             dxDrawRectangle ( 0, 0, x,y, tocolor(255,255,255,100) ) 
			  --tostring()
			 dxDrawText("GameStatus = "..tostring(GM:getSyncInfo("GameStatus")), 0, 0, x, i, tocolor ( 0, 0, 0, 255 ), 1.02, "arial","center","center" )
			 if lp.Weapons then
			 dxDrawText ("Primary  = "..tostring(lp.Weapons["Primary"]), 0, 0, x, i*2, tocolor ( 0, 0, 0, 255 ), 1.02, "arial","center","center" )
			 end
			 -- dxDrawText ("TEST", 0, 0, x, i*3, tocolor ( 0, 0, 0, 255 ), 1.02, "arial","center","center" )
			 -- dxDrawText ("TEST", 0, 0, x, i*4, tocolor ( 0, 0, 0, 255 ), 1.02, "arial","center","center" )
			 -- dxDrawText ("TEST", 0, 0, x, i*5, tocolor ( 0, 0, 0, 255 ), 1.02, "arial","center","center" )
			 -- dxDrawText ("TEST", 0, 0, x, i*6, tocolor ( 0, 0, 0, 255 ), 1.02, "arial","center","center" )
			 -- dxDrawText ("TEST", 0, 0, x, i*7, tocolor ( 0, 0, 0, 255 ), 1.02, "arial","center","center" )
			 -- dxDrawText ("TEST", 0, 0, x, i*8, tocolor ( 0, 0, 0, 255 ), 1.02, "arial","center","center" )
            dxSetRenderTarget()                  

        end
dxDrawImage ( screenX-x, screenY/2-y/2, x,y, myRenderTarget )   
end

function RealTimeRechner (Time1)
Time2 = getRealTime()
local hours1   = Time1.Time.hour
local minutes1 = Time1.Time.minute
local second1  = Time1.Time.second

local hours2   = Time2.hour
local minutes2 = Time2.minute
local second2  = Time2.second

local x = Time1.Countdown/1000-(second2-second1)
if x < 0 then x = 0 end
return x
end

-- addEventHandler ( "onClientRender", root, Test__GUI )
-- local MiniMap = {};
-- local hillRadar = createRadarArea ( 0, 0, 100, -140, 0, 255, 0, 175 )
-- local lp = getLocalPlayer()
-- local sw,sh = guiGetScreenSize()


-- function MiniMap:constructor()
-- self.x = 30
-- self.y = 300---self.RadarH+sh-30
-- self.MapUrl = "gamemodes/CnR/Usefull/Minimap/gtamap.png"
-- self.RadarW = 200
-- self.RadarH = 150
-- self.ZoomWert = 2
-- self.MapSizeX =   3000
-- self.MapSizeY =   3000
-- self.RenderTargetMap = dxCreateRenderTarget( self.MapSizeX, self.MapSizeY )
-- self.RenderTargetFenster = dxCreateRenderTarget( self.MapSizeX, self.MapSizeY )
-- self.RenderTargetBlip = dxCreateRenderTarget( self.MapSizeX, self.MapSizeY )
-- self.RenderTargetArea = dxCreateRenderTarget( self.MapSizeX, self.MapSizeY )

-- self.visible = true

-- self.MapSizeDifferenzX = self.MapSizeX / 3000
-- self.MapSizeDifferenzY = self.MapSizeY / 3000

-- self:Map()
  
-- end


-- function MiniMap:show()
-- self.visible = true
-- addEventHandler("onClientRender", getRootElement(), function() self:render() end);
-- end

-- function MiniMap:hide()
-- self.visible = false
-- removeEventHandler("onClientRender", getRootElement(), function() self:render() end);
-- end

	



		
-- function MiniMap:Map()
-- dxSetRenderTarget( self.RenderTargetMap )	
	-- dxDrawImage ( 0,0, self.MapSizeX, self.MapSizeY, self.MapUrl )
-- dxSetRenderTarget()
-- end	
		
		
-- function MiniMap:render()

	--if self.visible then

	
    -- local x,y = getElementPosition(lp)
	-- local _, _, RotZ = getElementRotation(lp)
	-- local cam = getCamera()
	-- local _, _, camRotZ = getElementRotation(cam)
	-- local phyta = 2--math.sqrt((self.RadarW)^2+(self.RadarH)^2)*2

 

-- dxSetRenderTarget( self.RenderTargetFenster )

-- dxDrawImageSection(


	-- 0,--posX
	-- 0,--posY
 -- self.MapSizeX,--width 
 -- self.MapSizeY,--height
-- (self.MapSizeX/self.MapSizeDifferenzX)+(x) -(self.RadarW)/2,--u
-- (self.MapSizeY/self.MapSizeDifferenzY)-(y) -(self.RadarH)/2,--v 
 -- self.RadarW*self.ZoomWert, --usize
 -- self.RadarH*self.ZoomWert, --vsize
 


-- self.MapUrl)

-- dxSetRenderTarget() 

-- dxDrawImage ( 400,400, 300, 200, self.RenderTargetFenster )
--end	
-- end



-- local test = new(MiniMap)
-- test:show()

-- bindKey("z","down",function()

-- test:show()

-- end) 



-- bindKey("u","down",function()

-- test:hide()

-- end) 
LoadingScreen_Menu = inherit(GUIForm)
inherit(Singleton, LoadingScreen_Menu)

function LoadingScreen_Menu:constructor()
GUIForm.constructor(self, 0, 0, screenWidth, screenHeight)
self.Rectangle = GUIRectangle:new(0, 0, screenWidth, screenHeight,tocolor(255,0,255,255) ,self)		
self.Label = GUILabel:new(0, 0, screenWidth, screenHeight, "Map is Loading", self)
:setAlignX("center")  
:setAlignY("center")  
end

function LoadingScreen_Menu:Remove()
delete(self)
end

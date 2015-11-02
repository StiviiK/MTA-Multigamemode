ReportABug = inherit(GUIForm)

function ReportABug:constructor()
  GUIForm.constructor(self, 0, screenHeight - screenHeight*0.035, screenWidth*0.1, screenHeight*0.03)

  GUIRectangle:new(0, 0, self.m_Width, self.m_Height, tocolor(0, 0, 0, 200), self)
end

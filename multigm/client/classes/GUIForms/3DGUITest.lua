GUI3DTest = inherit(GUIForm3D)

function GUI3DTest:constructor()
	GUIForm3D.constructor(self, Vector3(1730.011, -1670.068, 26), Vector3(0, 0, 43.5), Vector2(10, 3.5), Vector2(1000, 1000), 50)
	--GUIForm3D.constructor(self, Vector3(110.85, 1024.1, 23.3), Vector3(0, 0, 0), Vector2(21.5, 16), Vector2(1000, 1000), 100)
end

function GUI3DTest:onStreamIn(surface)
	local self = {}
    self.m_Background = GUIImage:new(0, 0, surface.m_Width, surface.m_Height, "res/images/backgrounds/lobby/lobby-bg.jpg", surface)
end

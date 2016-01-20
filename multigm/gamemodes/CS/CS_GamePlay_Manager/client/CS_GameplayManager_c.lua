CS_GamePlayManager = inherit(Object)

function CS_GamePlayManager:constructor()
  addRemoteEvents{"CS_onStartWarmUp","onFirstRound","NextRound"}
  
  addEventHandler("CS_onStartWarmUp", root, bind(CS_GamePlayManager.onStartWarmUp, self))
  addEventHandler("CS_onFirstRound", root, bind(CS_GamePlayManager.onFirstRound, self))
  addEventHandler("CS_NextRound", root, bind(CS_GamePlayManager.NextRound, self))
end

function CS_GamePlayManager:destructor()

end

function CS_GamePlayManager:onStartWarmUp()

end

function CS_GamePlayManager:onFirstRound()

end

function CS_GamePlayManager:NextRound()

end

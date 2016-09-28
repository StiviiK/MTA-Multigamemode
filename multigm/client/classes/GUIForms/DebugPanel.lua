DebugPanel = inherit(GUIForm)
inherit(Singleton, DebugPanel)
inherit(GUIMovable, DebugPanel)
addRemoteEvents{"receivePerformanceStats"}

function DebugPanel:constructor()
    GUIForm.constructor(self, screenWidth/2-300, screenHeight/2-230, 600, 460)

    -- Events
    self.m_PerformanceData = {
        SERVER = {
            luaTimings  = {arg1 = "-", arg2 = "-", arg3 = "-"};
            luaMemory   = {arg1 = "-", arg2 = "-", arg3 = "-", arg4 = "-"};
            --libMemory   = {arg1 = "-", arg2 = "-", arg3 = "-", arg4 = "-"};
            --packetUsage = {arg1 = "-", arg2 = "-", arg3 = "-", arg4 = "-", arg5 = "-", arg6 = "-", arg7 = "-"};
        };
        CLIENT = {
            luaTimings  = {arg1 = "-", arg2 = "-", arg3 = "-"};
            luaMemory   = {arg1 = "-", arg2 = "-", arg3 = "-", arg4 = "-"};
            --libMemory   = {arg1 = "-", arg2 = "-", arg3 = "-", arg4 = "-"};
            --packetUsage = {arg1 = "-", arg2 = "-", arg3 = "-", arg4 = "-", arg5 = "-", arg6 = "-", arg7 = "-"};
        }
    }
    self.m_Labels = {
        SERVER = {
            luaTimings  = {};
            luaMemory   = {};
            --libMemory   = {};
            --packetUsage = {};
        };
        CLIENT = {
            luaTimings  = {};
            luaMemory   = {};
            --libMemory   = {};
            --packetUsage = {};
        }
    }
    addEventHandler("receivePerformanceStats", root, bind(self.updatePerformanceData, self))

    -- Movearea
    --[[
    self.m_MoveLabel = GUIElement:new(550, 0, self.m_Width - 550 - 28, 30, self)
    self.m_MoveLabel.onLeftClickDown = function () self:startMoving() end
    self.m_MoveLabel.onLeftClick = function () self:stopMoving() end
    --]]

    --Tabpanel
    self.m_TabPanel = GUITabPanel:new(0, 0, self.m_Width, self.m_Height, self)
    self.m_TabPanel.onTabChanged = bind(self.TabPanel_TabChanged, self)
    self.m_CloseButton = GUILabel:new(self.m_Width-28, 0, 28, 28, "[x]", self):setFont(VRPFont(35))
    self.m_CloseButton.onLeftClick = function() self:close() end
    self.m_CloseButton.onHover = function () self.m_CloseButton:setColor(Color.Orange) end
    self.m_CloseButton.onUnhover = function () self.m_CloseButton:setColor(Color.White) end

    -- General
    local tabGeneral = self.m_TabPanel:addTab(_"Allgemein")
    self.m_TabGeneral = tabGeneral
    GUILabel:new(self.m_Width*0.02, self.m_Height*0.016, self.m_Width*0.265, self.m_Height*0.12, _"Allgemein", tabGeneral)

    -- Players
    local tabPlayers = self.m_TabPanel:addTab(_"Spieler")
    self.m_TabPlayers = tabPlayers
    GUILabel:new(self.m_Width*0.02, self.m_Height*0.016, self.m_Width*0.185, self.m_Height*0.12, _"Spieler", tabPlayers)
    self.m_PlayersGrid = GUIGridList:new(self.m_Width*0.02, self.m_Height*0.136, self.m_Width*0.525, self.m_Height*0.77, tabPlayers)
    self.m_PlayersGrid:addColumn(_"Id", 0.1)
    self.m_PlayersGrid:addColumn(_"Name", 0.3)
    self.m_PlayersGrid:addColumn(_"Gamemode", 0.6)
    self.m_PlayersGrid.onSelectItem = function () end

    -- Gamemodes
    local tabGamemodes = self.m_TabPanel:addTab(_"Gamemodes")
    self.m_TabGamemodes = tabGamemodes
    GUILabel:new(self.m_Width*0.02, self.m_Height*0.016, self.m_Width*0.33, self.m_Height*0.12, _"Gamemodes", tabGamemodes)
    GUILabel:new(self.m_Width*0.02, self.m_Height*0.12, self.m_Width*0.96, self.m_Height*0.06, _"(Doppelklick auf ein Gamemode für detailliertere Informationen.)", tabGamemodes)
    self.m_GamemodesGrid = GUIGridList:new(self.m_Width*0.02, self.m_Height*0.2, self.m_Width*0.525, self.m_Height*0.71, tabGamemodes)
    self.m_GamemodesGrid:addColumn(_"Id", 0.1)
    self.m_GamemodesGrid:addColumn(_"Name", 0.5)
    self.m_GamemodesGrid:addColumn(_"Spieler", 0.4)
    self.m_GamemodesGrid.onSelectItem = function (item) end


    -- Performance
    local tabPerformance = self.m_TabPanel:addTab(_"Performance")
    self.m_TabPerformance = tabPerformance
    GUILabel:new(self.m_Width*0.02, self.m_Height*0.016, self.m_Width*0.335, self.m_Height*0.12, _"Performance", tabPerformance)

    -- Server Performance
    GUILabel:new(self.m_Width*0.02, self.m_Height*0.12, self.m_Width*0.1, self.m_Height*0.07, _"Server", tabPerformance)

    -- Row LUA-Timings
    GUILabel:new(self.m_Width*0.02, self.m_Height*0.19, self.m_Width*0.25, self.m_Height*0.06, _"LUA-Timings:", tabPerformance)
    self.m_Labels["SERVER"]["luaTimings"] = {
        arg1 = GUILabel:new(self.m_Width*0.3, self.m_Height*0.19, self.m_Width*0.4, self.m_Height*0.06, "-", tabPerformance);
        arg2 = GUILabel:new(self.m_Width*0.3, self.m_Height*0.23, self.m_Width*0.4, self.m_Height*0.06, "-", tabPerformance);
        arg3 = GUILabel:new(self.m_Width*0.3, self.m_Height*0.27, self.m_Width*0.4, self.m_Height*0.06, "-", tabPerformance);
    }
    GUILabel:new(self.m_Width*0.48, self.m_Height*0.19, self.m_Width*0.4, self.m_Height*0.06, _"(Name)", tabPerformance);
    GUILabel:new(self.m_Width*0.48, self.m_Height*0.23, self.m_Width*0.4, self.m_Height*0.06, _"(CPU)", tabPerformance);
    GUILabel:new(self.m_Width*0.48, self.m_Height*0.27, self.m_Width*0.4, self.m_Height*0.06, _"(Time)", tabPerformance);

    -- Row LUA-Memory
    GUILabel:new(self.m_Width*0.02, self.m_Height*0.33, self.m_Width*0.25, self.m_Height*0.06, _"LUA-Memory:", tabPerformance)
    self.m_CleanServerLabel = GUILabel:new(self.m_Width*0.02, self.m_Height*0.37, self.m_Width*0.4, self.m_Height*0.06, _"(cleanup)", tabPerformance):setColor(Color.Orange)
    self.m_CleanServerLabel.onHover = function () self.m_CleanServerLabel:setColor(Color.White) end
    self.m_CleanServerLabel.onUnhover = function () self.m_CleanServerLabel:setColor(Color.Orange) end
    self.m_CleanServerLabel.onLeftClick = function () triggerServerEvent("Event_CleanMemoryUp", localPlayer) end
    self.m_Labels["SERVER"]["luaMemory"] = {
        arg1 = GUILabel:new(self.m_Width*0.3, self.m_Height*0.33, self.m_Width*0.4, self.m_Height*0.06, "-", tabPerformance);
        arg2 = GUILabel:new(self.m_Width*0.3, self.m_Height*0.37, self.m_Width*0.4, self.m_Height*0.06, "-", tabPerformance);
        arg3 = GUILabel:new(self.m_Width*0.3, self.m_Height*0.41, self.m_Width*0.4, self.m_Height*0.06, "-", tabPerformance);
        arg4 = GUILabel:new(self.m_Width*0.3, self.m_Height*0.45, self.m_Width*0.4, self.m_Height*0.06, "-", tabPerformance);
    }
    GUILabel:new(self.m_Width*0.48, self.m_Height*0.33, self.m_Width*0.4, self.m_Height*0.06, _"(Name)", tabPerformance);
    GUILabel:new(self.m_Width*0.48, self.m_Height*0.37, self.m_Width*0.4, self.m_Height*0.06, _"(Change)", tabPerformance);
    GUILabel:new(self.m_Width*0.48, self.m_Height*0.41, self.m_Width*0.4, self.m_Height*0.06, _"(Current)", tabPerformance);
    GUILabel:new(self.m_Width*0.48, self.m_Height*0.45, self.m_Width*0.4, self.m_Height*0.06, _"(Max)", tabPerformance);

    -- Client Performance
    GUILabel:new(self.m_Width*0.02, self.m_Height*0.5, self.m_Width*0.1, self.m_Height*0.07, _"Client", tabPerformance)

    -- Row LUA-Timings
    GUILabel:new(self.m_Width*0.02, self.m_Height*0.57, self.m_Width*0.25, self.m_Height*0.06, _"LUA-Timings:", tabPerformance)
    self.m_Labels["CLIENT"]["luaTimings"] = {
        arg1 = GUILabel:new(self.m_Width*0.3, self.m_Height*0.57, self.m_Width*0.4, self.m_Height*0.06, "-", tabPerformance);
        arg2 = GUILabel:new(self.m_Width*0.3, self.m_Height*0.61, self.m_Width*0.4, self.m_Height*0.06, "-", tabPerformance);
        arg3 = GUILabel:new(self.m_Width*0.3, self.m_Height*0.65, self.m_Width*0.4, self.m_Height*0.06, "-", tabPerformance);
    }
    GUILabel:new(self.m_Width*0.48, self.m_Height*0.57, self.m_Width*0.4, self.m_Height*0.06, _"(Name)", tabPerformance);
    GUILabel:new(self.m_Width*0.48, self.m_Height*0.61, self.m_Width*0.4, self.m_Height*0.06, _"(CPU)", tabPerformance);
    GUILabel:new(self.m_Width*0.48, self.m_Height*0.65, self.m_Width*0.4, self.m_Height*0.06, _"(Time)", tabPerformance);

    -- Row LUA-Memory
    GUILabel:new(self.m_Width*0.02, self.m_Height*0.71, self.m_Width*0.25, self.m_Height*0.06, _"LUA-Memory:", tabPerformance)
    self.m_CleanClientLabel = GUILabel:new(self.m_Width*0.02, self.m_Height*0.75, self.m_Width*0.4, self.m_Height*0.06, _"(cleanup)", tabPerformance):setColor(Color.Orange)
    self.m_CleanClientLabel.onHover = function () self.m_CleanClientLabel:setColor(Color.White) end
    self.m_CleanClientLabel.onUnhover = function () self.m_CleanClientLabel:setColor(Color.Orange) end
    self.m_CleanClientLabel.onLeftClick = function () collectgarbage() end
    self.m_Labels["CLIENT"]["luaMemory"] = {
        arg1 = GUILabel:new(self.m_Width*0.3, self.m_Height*0.71, self.m_Width*0.4, self.m_Height*0.06, "-", tabPerformance);
        arg2 = GUILabel:new(self.m_Width*0.3, self.m_Height*0.75, self.m_Width*0.4, self.m_Height*0.06, "-", tabPerformance);
        arg3 = GUILabel:new(self.m_Width*0.3, self.m_Height*0.79, self.m_Width*0.4, self.m_Height*0.06, "-", tabPerformance);
        arg4 = GUILabel:new(self.m_Width*0.3, self.m_Height*0.83, self.m_Width*0.4, self.m_Height*0.06, "-", tabPerformance);
    }
    GUILabel:new(self.m_Width*0.48, self.m_Height*0.71, self.m_Width*0.4, self.m_Height*0.06, _"(Name)", tabPerformance);
    GUILabel:new(self.m_Width*0.48, self.m_Height*0.75, self.m_Width*0.4, self.m_Height*0.06, _"(Change)", tabPerformance);
    GUILabel:new(self.m_Width*0.48, self.m_Height*0.79, self.m_Width*0.4, self.m_Height*0.06, _"(Current)", tabPerformance);
    GUILabel:new(self.m_Width*0.48, self.m_Height*0.83, self.m_Width*0.4, self.m_Height*0.06, _"(Max)", tabPerformance);

    -- Settings
    local tabSettings= self.m_TabPanel:addTab(_"Einstellungen")
    self.m_TabSettings = tabSettings
    GUILabel:new(self.m_Width*0.02, self.m_Height*0.016, self.m_Width*0.345, self.m_Height*0.12, _"Einstellungen", tabSettings)
end

function DebugPanel:onShow()
    -- Update the Tabs


    self:TabPanel_TabChanged(self.m_TabGamemodes.TabIndex)
end

function DebugPanel:TabPanel_TabChanged(TabIndex)
    if TabIndex == self.m_TabGeneral.TabIndex then
    elseif TabIndex == self.m_TabPlayers.TabIndex then
        self:adjustPlayerTab()
    elseif TabIndex == self.m_TabGamemodes.TabIndex then
        self:adjustGamemodesTab()
    elseif TabIndex == self.m_TabPerformance.TabIndex then
        self:adjustPerformanceTab()
    elseif TabIndex == self.m_TabSettings.TabIndex then
    end
end

function DebugPanel:adjustPlayerTab()
    self.m_PlayersGrid:clear()
    for i, v in pairs(Element.getAllByType("player")) do
        local name = (v:getName():len() > 10 and v:getName():sub(1, 10).."...") or v:getName()
        self.m_PlayersGrid:addItem(v:getId(), name, v:getGamemode():getName())
    end
end

function DebugPanel:adjustGamemodesTab()
    self.m_GamemodesGrid:clear()
    for i, v in pairs(GamemodeManager.Map) do
        local item = self.m_GamemodesGrid:addItem(v:getId(), v:getName(), ("%d/%d"):format(v:getSyncInfo("CurrPlayers"), v:getSyncInfo("MaxPlayers")))
        item.onLeftDoubleClick = function () GamemodeInfo:new(v:getId())  end
        item.Gamemode = v
    end
end

function DebugPanel:adjustPerformanceTab()
    -- Update Server Data
    for type, _ in pairs(self.m_PerformanceData) do
        for name, tbl in pairs(self.m_PerformanceData[type]) do
            if self.m_Labels[type][name] then
                for index, v in pairs(tbl) do
                    if self.m_Labels[type][name][index] then
                        self.m_Labels[type][name][index]:setText(v)
                    end
                end
            end
        end
    end
end

function DebugPanel:updatePerformanceData(data)
    -- Update Server Data
    for index, tbl in pairs(data) do
        for argNum, value in pairs(tbl) do
            if self.m_PerformanceData["SERVER"][index][argNum] ~= value then
                self.m_PerformanceData["SERVER"][index][argNum] = value
            end
        end
    end

    -- Update Client Data
    local arg1, arg2, arg3 = Performance:getSingleton():getLUATimings()
    self.m_PerformanceData["CLIENT"]["luaTimings"] = {arg1 = arg1, arg2 = arg2, arg3 = arg3}
    local arg1, arg2, arg3, arg4 = Performance:getSingleton():getLUAMemory()
    self.m_PerformanceData["CLIENT"]["luaMemory"] = {arg1 = arg1, arg2 = arg2, arg3 = arg3, arg4 = arg4}

    if self:isVisible() then
        if self.m_TabPanel.m_CurrentTab == self.m_TabPerformance.TabIndex then
            self:adjustPerformanceTab()
        end
    end
end

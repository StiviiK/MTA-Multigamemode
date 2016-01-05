GamemodePedMouseMenu = inherit(GUIMouseMenu)

function GamemodePedMouseMenu:constructor(posX, posY, instance, CustomColor)
  GUIMouseMenu.constructor(self, posX, posY, 330, 1)

  self:addItem(_("Gamemode: %s", instance:getGamemode():getName()))

  self:addItem(_"Gamemode Infos",
    function ()
      GamemodeInfo:new(instance:getGamemode():getId())
    end
  )

  self:addItem(_"Gamemode beitreten",
    function ()
      --triggerServerEvent("Event_JoinGamemode", localPlayer, instance:getGamemode():getId())
      RPC:call("Event_JoinGamemode", instance:getGamemode():getId())
    end
  )

  if localPlayer:getRank() >= RANK.Administrator then
    self:addItem(_"Admin: Ped respawnen",
      function ()
        --triggerServerEvent("Event_RespawnGamemodePed", localPlayer, instance:getId())
        RPC:call("Event_RespawnGamemodePed", instance:getId())
        Cursor:hide()
      end
    )

    self:addItem(_"Admin: Ped löschen",
      function ()
        --triggerServerEvent("Event_DeleteGamemodePed", localPlayer, instance:getId())
        RPC:call("Event_DeleteGamemodePed", instance:getId())
        Cursor:hide()
      end
    )

    self:addItem(_"Developer: Gamemode deaktivieren",
      function ()
        QuestionBox:new(_"Möchtest du diesen Gamemode wirklich dauerhaft deaktivieren?".."\n".._"Diese Aktion kann nicht rückgängig gemacht werden!",
          function ()
            --triggerServerEvent("Event_DisableGamemode", localPlayer, instance:getGamemode():getId())
            RPC:call("Event_DisableGamemode", instance:getGamemode():getId())
          end
        )
      end
    )
  end

  -- Adjust color at the end!
  self:setColor(CustomColor or Color.Orange)
end

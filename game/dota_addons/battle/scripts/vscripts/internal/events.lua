--[[ Internal Event Handlers ]]

--[[
The overall game state has changed.
]]
function Battle:_OnGameRulesStateChange(keys)
  if Battle._reentrantCheck then
    return
  end

  local newState = GameRules:State_Get()

  if newState == DOTA_GAMERULES_STATE_WAIT_FOR_PLAYERS_TO_LOAD then
    DebugPrint('New State: DOTA_GAMERULES_STATE_WAIT_FOR_PLAYERS_TO_LOAD')
    self.bSeenWaitForPlayers = true

  elseif newState == DOTA_GAMERULES_STATE_INIT then
    DebugPrint('New State: DOTA_GAMERULES_STATE_INIT')
    --Timers:RemoveTimer("alljointimer")

  elseif newState == DOTA_GAMERULES_STATE_HERO_SELECTION then
    DebugPrint('New State: DOTA_GAMERULES_STATE_HERO_SELECTION')
    Battle:PostLoadPrecache()
    Battle:OnAllPlayersLoaded()
    
    if USE_CUSTOM_TEAM_COLORS_FOR_PLAYERS then
      DebugPrint('Using Custom Team Colors!')
      for i = 0, 9 do
        if PlayerResource:IsValidPlayer(i) then
          local color = TEAM_COLORS[PlayerResource:GetTeam(i)]
          PlayerResource:SetCustomPlayerColor(i, color[1], color[2], color[3])
        end
      end
    end

  elseif newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
    DebugPrint('New State: DOTA_GAMERULES_STATE_GAME_IN_PROGRESS')
    Battle:OnGameInProgress()
  end

  Battle._reentrantCheck = true
  Battle:OnGameRulesStateChange(keys)
  Battle._reentrantCheck = false
end

--[[
An NPC has spawned somewhere in game. This includes heroes.
]]
function Battle:_OnNPCSpawned(keys)
  if Battle._reentrantCheck then
    return
  end

  local npc = EntIndexToHScript(keys.entindex)

  if npc:IsRealHero() and npc.bFirstSpawned == nil then
    npc.bFirstSpawned = true
    Battle:OnHeroInGame(npc)
  end

  Battle._reentrantCheck = true
  Battle:OnNPCSpawned(keys)
  Battle._reentrantCheck = false
end

--[[
An entitiy died.
]]
function Battle:_OnEntityKilled(keys)
  if Battle._reentrantCheck then
    return
  end

  --[[ The Unit that was killed. ]]
  local killedUnit = EntIndexToHScript( keys.entindex_killed )
  --[[ The killing entity. ]]
  local killerEntity = nil

  if keys.entindex_attacker ~= nil then
    killerEntity = EntIndexToHScript( keys.entindex_attacker )
  end

  if killedUnit:IsRealHero() then 
    DebugPrint("KILLED, KILLER: " .. killedUnit:GetName() .. " -- " .. killerEntity:GetName())
    if END_GAME_ON_KILLS and GetTeamHeroKills(killerEntity:GetTeam()) >= KILLS_TO_END_GAME_FOR_TEAM then
      Battle:SetSafeToLeave( true )
      Battle:SetGameWinner( killerEntity:GetTeam() )
    end

    if SHOW_KILLS_ON_TOPBAR then
      Battle:GetGameModeEntity():SetTopBarTeamValue ( DOTA_TEAM_BADGUYS, GetTeamHeroKills(DOTA_TEAM_BADGUYS) )
      Battle:GetGameModeEntity():SetTopBarTeamValue ( DOTA_TEAM_GOODGUYS, GetTeamHeroKills(DOTA_TEAM_GOODGUYS) )
    end
  end

  Battle._reentrantCheck = true
  Battle:OnEntityKilled(keys)
  Battle._reentrantCheck = false
end

--[[
This function is called once when the player fully connects and becomes "ready"
during loading.
]]
function Battle:_OnConnectFull(keys)
  if Battle._reentrantCheck then
    return
  end

  Battle:_CaptureGameMode()

  local entIndex = keys.index + 1

  --[[ The Player entity of the joining user. ]]
  local ply = EntIndexToHScript(entIndex)
  
  local userID = keys.userid

  self.vUserIds = self.vUserIds or {}
  self.vUserIds[userID] = ply

  Battle._reentrantCheck = true
  Battle:OnConnectFull(keys)
  Battle._reentrantCheck = false
end
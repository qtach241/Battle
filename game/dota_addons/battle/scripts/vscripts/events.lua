--[[ Event Handlers ]]

--[[
A player leveled up
]]
function Battle:OnPlayerLevelUp(keys)
  DebugPrint('OnPlayerLevelUp')
  DebugPrintTable(keys)

  local player = EntIndexToHScript(keys.player)
  local level = keys.level
end

--[[
A channeled ability finished by either completing or being interrupted.
]]
function Battle:OnAbilityChannelFinished(keys)
  DebugPrint('OnAbilityChannelFinished')
  DebugPrintTable(keys)

  local abilityname = keys.abilityname
  local interrupted = keys.interrupted == 1
end

--[[
Clean up a player when they leave.
]]
function Battle:OnDisconnect(keys)
  DebugPrint('Player Disconnected: ' .. tostring(keys.userid))
  DebugPrintTable(keys)

  local name = keys.name
  local networkid = keys.networkid
  local reason = keys.reason
  local userid = keys.userid
end

--[[
The overall game state has changed.
]]
function Battle:OnGameRulesStateChange(keys)
  DebugPrint('GameRules State Changed')
  DebugPrintTable(keys)

  local newState = GameRules:State_Get()
end

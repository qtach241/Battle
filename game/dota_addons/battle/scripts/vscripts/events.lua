--[[ Event Handlers ]]

--[[
A player leveled up
]]
function Battle:OnPlayerLevelUp(keys)
  DebugPrint('Handling Player Level Up')
  DebugPrintTable(keys)

  local player = EntIndexToHScript(keys.player)
  local level = keys.level
end

--[[
A channelled ability finished by either completing or being interrupted.
]]
function Battle:OnAbilityChannelFinished(keys)
  DebugPrint('Handling Ability Channel Finished')
  DebugPrintTable(keys)

  local abilityname = keys.abilityname
  local interrupted = keys.interrupted == 1
end

--[[
Clean up a player when they leave.
]]
function Battle:OnDisconnect(keys)
  DebugPrint('Handling Player Disconnected: ' .. tostring(keys.userid))
  DebugPrintTable(keys)

  local name = keys.name
  local networkid = keys.networkid
  local reason = keys.reason
  local userid = keys.userid
end


--[[ 
NOTE: These 4 event handlers are invoked from internal event handlers of the same
name (preceded by an underscore character). 
]]

--[[
The overall game state has changed.
]]
function Battle:OnGameRulesStateChange(keys)
  DebugPrint('Handling Game Rules State Change')
  DebugPrintTable(keys)

  local newState = GameRules:State_Get()
end

--[[
An NPC has spawned somewhere in game. This includes heroes.
]]
function Battle:OnNPCSpawned(keys)
  DebugPrint('Handling NPC Spawned')
  DebugPrintTable(keys)

  local npc = EntIndexToHScript(keys.entindex)
end

--[[ 
An entity died.
]]
function Battle:OnEntityKilled( keys )
  DebugPrint('Handling Entity Killed')
  DebugPrintTable(keys)

  --[[ The Unit that was Killed. ]]
  local killedUnit = EntIndexToHScript( keys.entindex_killed )
  --[[ The Killing entity. ]]
  local killerEntity = nil

  if keys.entindex_attacker ~= nil then
    killerEntity = EntIndexToHScript( keys.entindex_attacker )
  end

  --[[ The ability/item used to kill, or nil if not killed by an item/ability. ]]
  local killerAbility = nil

  if keys.entindex_inflictor ~= nil then
    killerAbility = EntIndexToHScript( keys.entindex_inflictor )
  end

  --[[ This might always be 0 and therefore useless. ]]
  local damagebits = keys.damagebits

  --[[ Put code here to handle when an entity gets killed. ]]
end

--[[
This function is called once when the player fully connects and becomes "Ready" 
during Loading.
]]
function Battle:OnConnectFull(keys)
  DebugPrint('Handling Connect Full')
  DebugPrintTable(keys)
  
  local entIndex = keys.index+1
  --[[ The Player entity of the joining user. ]]
  local ply = EntIndexToHScript(entIndex)
  
  --[[ The Player ID of the joining player. ]]
  local playerID = ply:GetPlayerID()
end
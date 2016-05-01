--[[ 
Event Handlers. Each function corresponds to a hook of the same name (see 
ListenToGameEvent calls in internal/battle.lua.
]]

--[[
A player leveled up
]]
function Battle:OnPlayerLevelUp(keys)
  DebugPrint('Handling event: dota_player_gained_level')
  clog.info("EVENT", "Handling event: dota_player_gained_level")
  DebugPrintTable(keys)

  local player = EntIndexToHScript(keys.player)
  local level = keys.level
end

--[[
A channelled ability finished by either completing or being interrupted.
]]
function Battle:OnAbilityChannelFinished(keys)
  DebugPrint('Handling event: dota_ability_channel_finished')
  clog.info("EVENT", "Handling event: dota_ability_channel_finished")
  DebugPrintTable(keys)

  local abilityname = keys.abilityname
  local interrupted = keys.interrupted == 1
end

--[[ 
A player leveled up an ability.
]]
function Battle:OnPlayerLearnedAbility(keys)
  DebugPrint('Handling event: dota_player_learned_ability')
  clog.info("EVENT", "Handling event: dota_player_learned_ability")
  DebugPrintTable(keys)

  local player = EntIndexToHScript(keys.player)
  local abilityname = keys.abilityname
end

--[[
Clean up a player when they leave.
]]
function Battle:OnDisconnect(keys)
  DebugPrint('Handling event: player_disconnect: ' .. tostring(keys.userid))
  clog.info("EVENT", "Handling event: player_disconnect: " .. tostring(keys.userid))
  DebugPrintTable(keys)

  local name = keys.name
  local networkid = keys.networkid
  local reason = keys.reason
  local userid = keys.userid
end

--[[ 
An item was purchased by a player.
]]
function Battle:OnItemPurchased(keys)
  DebugPrint('Handling event: dota_item_purchased')
  clog.info("EVENT", "Handling event: dota_item_purchased")
  DebugPrintTable(keys)

  --[[ The playerID of the hero who is buying something. ]]
  local plyID = keys.PlayerID
  if not plyID then 
    return 
  end

  --[[ The name of the item purchased. ]]
  local itemName = keys.itemname 
  
  --[[ The cost of the item purchased. ]]
  local itemcost = keys.itemcost
end

--[[ 
An item was picked up off the ground.
]]
function Battle:OnItemPickedUp(keys)
  DebugPrint('Handling event: dota_item_picked_up')
  clog.info("EVENT", "Handling event: dota_item_picked_up")
  DebugPrintTable(keys)

  local unitEntity = nil
  if keys.UnitEntitIndex then
    unitEntity = EntIndexToHScript(keys.UnitEntitIndex)
  elseif keys.HeroEntityIndex then
    unitEntity = EntIndexToHScript(keys.HeroEntityIndex)
  end

  local itemEntity = EntIndexToHScript(keys.ItemEntityIndex)
  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local itemname = keys.itemname
end

--[[ 
A player last hit a creep, a tower, or a hero.
]]
function Battle:OnLastHit(keys)
  DebugPrint('Handling event: last_hit')
  clog.info("EVENT", "Handling event: last_hit")
  DebugPrintTable(keys)

  local isFirstBlood = keys.FirstBlood == 1
  local isHeroKill = keys.HeroKill == 1
  local isTowerKill = keys.TowerKill == 1
  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local killedEnt = EntIndexToHScript(keys.EntKilled)
end

--[[
A non-player entity (necro-book, chen creep, etc) used an ability.
]]
function Battle:OnNonPlayerUsedAbility(keys)
  DebugPrint('Handling event: dota_non_player_used_ability')
  clog.info("EVENT", "Handling event: dota_non_player_used_ability")
  DebugPrintTable(keys)

  local abilityname=  keys.abilityname
end

--[[ 
A player changed their name.
]]
function Battle:OnPlayerChangedName(keys)
  DebugPrint('Handling event: player_changename')
  clog.info("EVENT", "Handling event: player_changename")
  DebugPrintTable(keys)

  local newName = keys.newname
  local oldName = keys.oldName
end

--[[ 
A rune was activated by a player.
]]
function Battle:OnRuneActivated(keys)
  DebugPrint('Handling event: dota_rune_activated_server')
  clog.info("EVENT", "Handling event: dota_rune_activated_server")
  DebugPrintTable(keys)

  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local rune = keys.rune

  --[[ Rune Can be one of the following types
  DOTA_RUNE_DOUBLEDAMAGE
  DOTA_RUNE_HASTE
  DOTA_RUNE_HAUNTED
  DOTA_RUNE_ILLUSION
  DOTA_RUNE_INVISIBILITY
  DOTA_RUNE_BOUNTY
  DOTA_RUNE_MYSTERY
  DOTA_RUNE_RAPIER
  DOTA_RUNE_REGENERATION
  DOTA_RUNE_SPOOKY
  DOTA_RUNE_TURBO
  ]]
end

--[[ 
A player took damage from a tower.
]]
function Battle:OnPlayerTakeTowerDamage(keys)
  DebugPrint('Handling event: dota_player_take_tower_damage')
  clog.info("EVENT", "Handling event: dota_player_take_tower_damage")
  DebugPrintTable(keys)

  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local damage = keys.damage
end

--[[
A tree was cut down by tango, quelling blade, etc.
]]
function Battle:OnTreeCut(keys)
  DebugPrint('Handling event: tree_cut')
  clog.info("EVENT", "Handling event: tree_cut")
  DebugPrintTable(keys)

  local treeX = keys.tree_x
  local treeY = keys.tree_y
end

--[[ 
An entity somewhere has been hurt. This event triggers very frequently.
]]
function Battle:OnEntityHurt(keys)
  DebugPrint("Handling event: entity_hurt")
  clog.info("EVENT", "Handling event: entity_hurt")
  DebugPrintTable(keys)
  
  --[[ This might always be 0 and therefore useless. ]]
  local damagebits = keys.damagebits
  
  if keys.entindex_attacker ~= nil and keys.entindex_killed ~= nil then
    local entCause = EntIndexToHScript(keys.entindex_attacker)
    local entVictim = EntIndexToHScript(keys.entindex_killed)

    --[[ The ability/item used to damage, or nil if not damaged by an item/ability. ]]
    local damagingAbility = nil

    if keys.entindex_inflictor ~= nil then
      damagingAbility = EntIndexToHScript( keys.entindex_inflictor )
    end
  end
end

--[[ 
This function is called 1 to 2 times as the player connects initially but before 
they have completely connected. 
]]
function Battle:PlayerConnect(keys)
  DebugPrint('Handling event: player_connect')
  clog.info("EVENT", "Handling event: player_connect")
  DebugPrintTable(keys)
end

--[[
An ability was used by a player. 
]]
function Battle:OnAbilityUsed(keys)
  DebugPrint('Handling event: dota_player_used_ability')
  clog.info("EVENT", "Handling event: dota_player_used_ability")
  DebugPrintTable(keys)

  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local abilityname = keys.abilityname
end

--[[ 
A player picked a hero.
]]
function Battle:OnPlayerPickHero(keys)
  DebugPrint('Handling event: dota_player_pick_hero')
  clog.info("EVENT", "Handling event: dota_player_pick_hero")
  DebugPrintTable(keys)

  local heroClass = keys.hero
  local heroEntity = EntIndexToHScript(keys.heroindex)
  local player = EntIndexToHScript(keys.player)
end

--[[ 
A player killed another player in a multi-team context.
]]
function Battle:OnTeamKillCredit(keys)
  DebugPrint('Handling event: dota_team_kill_credit')
  clog.info("EVENT", "Handling event: dota_team_kill_credit")
  DebugPrintTable(keys)

  local killerPlayer = PlayerResource:GetPlayer(keys.killer_userid)
  local victimPlayer = PlayerResource:GetPlayer(keys.victim_userid)
  local numKills = keys.herokills
  local killerTeamNumber = keys.teamnumber
end

--[[ 
A player has reconnected to the game. This function can be used to repaint 
Player-based particles or change state as necessary. 
]]
function Battle:OnPlayerReconnect(keys)
  DebugPrint('Handling event: player_reconnected')
  clog.info("EVENT", "Handling event: player_reconnected")
  DebugPrintTable(keys)
end

--[[ This function is called whenever illusions are created and passes in which 
was/is the original entity.
]]
function Battle:OnIllusionsCreated(keys)
  DebugPrint('Handling event: dota_illusions_created')
  clog.info("EVENT", "Handling event: dota_illusions_created")
  DebugPrintTable(keys)

  local originalEntity = EntIndexToHScript(keys.original_entindex)
end

--[[
This function is called whenever an item is combined to create a new item.
]]
function Battle:OnItemCombined(keys)
  DebugPrint('Handling event: dota_item_combined')
  clog.info("EVENT", "Handling event: dota_item_combined")
  DebugPrintTable(keys)

  --[[ The playerID of the hero who is buying something. ]]
  local plyID = keys.PlayerID
  if not plyID then return end
  local player = PlayerResource:GetPlayer(plyID)

  --[[ The name of the item purchased. ]]
  local itemName = keys.itemname 
  
  --[[ The cost of the item purchased. ]]
  local itemcost = keys.itemcost
end

--[[
This function is called whenever an ability begins its PhaseStart phase (but 
before it is actually cast).
]]
function Battle:OnAbilityCastBegins(keys)
  DebugPrint('Handling event: dota_player_begin_cast')
  clog.info("EVENT", "Handling event: dota_player_begin_cast")
  DebugPrintTable(keys)

  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local abilityName = keys.abilityname
end

--[[
This function is called whenever a tower is killed.
]]
function Battle:OnTowerKill(keys)
  DebugPrint('Handling event: dota_tower_kill')
  clog.info("EVENT", "Handling event: dota_tower_kill")
  DebugPrintTable(keys)

  local gold = keys.gold
  local killerPlayer = PlayerResource:GetPlayer(keys.killer_userid)
  local team = keys.teamnumber
end

--[[ This function is called whenever a player changes their custom team 
selection during game setup.
]]
function Battle:OnPlayerSelectedCustomTeam(keys)
  DebugPrint('Handling event: dota_player_selected_custom_team')
  clog.info("EVENT", "Handling event: dota_player_selected_custom_team")
  DebugPrintTable(keys)

  local player = PlayerResource:GetPlayer(keys.player_id)
  local success = (keys.success == 1)
  local team = keys.team_id
end

--[[ 
This function is called whenever an NPC reaches its goal position/target.
]]
function Battle:OnNPCGoalReached(keys)
  DebugPrint('Handling event: dota_npc_goal_reached')
  clog.info("EVENT", "Handling event: dota_npc_goal_reached")
  DebugPrintTable(keys)

  local goalEntity = EntIndexToHScript(keys.goal_entindex)
  local nextGoalEntity = EntIndexToHScript(keys.next_goal_entindex)
  local npc = EntIndexToHScript(keys.npc_entindex)
end

--[[ 
This function is called whenever any player sends a chat message to team or All.
]]
function Battle:OnPlayerChat(keys)
  DebugPrint('Handling event: player_chat')
  clog.info("EVENT", "Handling event: player_chat")
  DebugPrintTable(keys)

  local teamonly = keys.teamonly
  local userID = keys.userid
  local playerID = self.vUserIds[userID]:GetPlayerID()

  local text = keys.text
end


--[[ 
NOTE: These 4 event handlers are invoked from internal event handlers of the same
name (preceded by an underscore character). 
]]

--[[
The overall game state has changed.
]]
function Battle:OnGameRulesStateChange(keys)
  DebugPrint('Handling event: game_rules_state_change')
  clog.info("EVENT", "Handling event: game_rules_state_change")
  DebugPrintTable(keys)

  local newState = GameRules:State_Get()
end

--[[
An NPC has spawned somewhere in game. This includes heroes.
]]
function Battle:OnNPCSpawned(keys)
  DebugPrint('Handling event: npc_spawned')
  clog.info("EVENT", "Handling event: npc_spawned")
  DebugPrintTable(keys)

  local npc = EntIndexToHScript(keys.entindex)
end

--[[ 
An entity died.
]]
function Battle:OnEntityKilled(keys)
  DebugPrint('Handling event: entity_killed')
  clog.info("EVENT", "Handling event: entity_killed")
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
  DebugPrint('Handling event: player_connect_full')
  clog.info("EVENT", "Handling event: player_connect_full")
  DebugPrintTable(keys)
  
  local entIndex = keys.index + 1
  --[[ The Player entity of the joining user. ]]
  local ply = EntIndexToHScript(entIndex)
  
  --[[ The Player ID of the joining player. ]]
  local playerID = ply:GetPlayerID()
end
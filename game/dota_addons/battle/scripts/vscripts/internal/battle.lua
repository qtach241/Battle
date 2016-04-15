--[[ Init ]]

function Battle:_InitGameMode()
  if Battle._reentrantCheck then
    return
  end

  --[[ Setup Rules ]]
  GameRules:SetHeroRespawnEnabled( ENABLE_HERO_RESPAWN )
  GameRules:SetUseUniversalShopMode( UNIVERSAL_SHOP_MODE )
  GameRules:SetSameHeroSelectionEnabled( ALLOW_SAME_HERO_SELECTION )
  GameRules:SetHeroSelectionTime( HERO_SELECTION_TIME )
  GameRules:SetPreGameTime( PRE_GAME_TIME)
  GameRules:SetPostGameTime( POST_GAME_TIME )
  GameRules:SetTreeRegrowTime( TREE_REGROW_TIME )
  GameRules:SetUseCustomHeroXPValues ( USE_CUSTOM_XP_VALUES )
  GameRules:SetGoldPerTick(GOLD_PER_TICK)
  GameRules:SetGoldTickTime(GOLD_TICK_TIME)
  GameRules:SetRuneSpawnTime(RUNE_SPAWN_TIME)
  GameRules:SetUseBaseGoldBountyOnHeroes(USE_STANDARD_HERO_GOLD_BOUNTY)
  GameRules:SetHeroMinimapIconScale( MINIMAP_ICON_SIZE )
  GameRules:SetCreepMinimapIconScale( MINIMAP_CREEP_ICON_SIZE )
  GameRules:SetRuneMinimapIconScale( MINIMAP_RUNE_ICON_SIZE )

  GameRules:SetFirstBloodActive( ENABLE_FIRST_BLOOD )
  GameRules:SetHideKillMessageHeaders( HIDE_KILL_BANNERS )

  GameRules:SetCustomGameEndDelay( GAME_END_DELAY )
  GameRules:SetCustomVictoryMessageDuration( VICTORY_MESSAGE_DURATION )
  GameRules:SetStartingGold( STARTING_GOLD )

  if SKIP_TEAM_SETUP then
    GameRules:SetCustomGameSetupAutoLaunchDelay( 0 )
    GameRules:LockCustomGameSetupTeamAssignment( true )
    GameRules:EnableCustomGameSetupAutoLaunch( true )
  else
    GameRules:SetCustomGameSetupAutoLaunchDelay( AUTO_LAUNCH_DELAY )
    GameRules:LockCustomGameSetupTeamAssignment( LOCK_TEAM_SETUP )
    GameRules:EnableCustomGameSetupAutoLaunch( ENABLE_AUTO_LAUNCH )
  end

  --[[ Multi-Team Configuration ]]
  if USE_AUTOMATIC_PLAYERS_PER_TEAM then
    local num = math.floor(10 / MAX_NUMBER_OF_TEAMS)
    local count = 0
    for team,number in pairs(TEAM_COLORS) do
      if count >= MAX_NUMBER_OF_TEAMS then
        GameRules:SetCustomGameTeamMaxPlayers(team, 0)
      else
        GameRules:SetCustomGameTeamMaxPlayers(team, num)
      end
      count = count + 1
    end
  else
    local count = 0
    for team,number in pairs(CUSTOM_TEAM_PLAYER_COUNT) do
      if count >= MAX_NUMBER_OF_TEAMS then
        GameRules:SetCustomGameTeamMaxPlayers(team, 0)
      else
        GameRules:SetCustomGameTeamMaxPlayers(team, number)
      end
      count = count + 1
    end
  end

  if USE_CUSTOM_TEAM_COLORS then
    for team,color in pairs(TEAM_COLORS) do
      SetTeamCustomHealthbarColor(team, color[1], color[2], color[3])
    end
  end
  DebugPrint('Game Rules set')

  --[[ These event hooks route to handler functions directly. ]]
  ListenToGameEvent('dota_player_gained_level', Dynamic_Wrap(Battle, 'OnPlayerLevelUp'), self)
  ListenToGameEvent('dota_ability_channel_finished', Dynamic_Wrap(Battle, 'OnAbilityChannelFinished'), self)

  ListenToGameEvent('player_disconnect', Dynamic_Wrap(Battle, 'OnDisconnect'), self)

  --[[ These event hooks route to "internal" hander functions first. ]]
  ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(Battle, '_OnGameRulesStateChange'), self)
  ListenToGameEvent('npc_spawned', Dynamic_Wrap(Battle, '_OnNPCSpawned'), self)
  ListenToGameEvent('entity_killed', Dynamic_Wrap(Battle, '_OnEntityKilled'), self)
  ListenToGameEvent('player_connect_full', Dynamic_Wrap(Battle, '_OnConnectFull'), self)
  
  DebugPrint('Event Hooks set')
  
  Battle._reentrantCheck = true
  Battle:InitGameMode()
  Battle._reentrantCheck = false
end

--[[ On first parse, set BattleEntity = nil to set up game mode parameters. ]]
BattleEntity = nil

--[[
This function is called as the first player loads and sets up the parameters
of the custom game.
]]
function Battle:_CaptureGameMode()
  if BattleEntity == nil then
    --[[ Set GameMode parameters ]]
    BattleEntity = GameRules:GetGameModeEntity()        
    BattleEntity:SetRecommendedItemsDisabled( RECOMMENDED_BUILDS_DISABLED )
    BattleEntity:SetCameraDistanceOverride( CAMERA_DISTANCE_OVERRIDE )
    BattleEntity:SetCustomBuybackCostEnabled( CUSTOM_BUYBACK_COST_ENABLED )
    BattleEntity:SetCustomBuybackCooldownEnabled( CUSTOM_BUYBACK_COOLDOWN_ENABLED )
    BattleEntity:SetBuybackEnabled( BUYBACK_ENABLED )
    BattleEntity:SetTopBarTeamValuesOverride ( USE_CUSTOM_TOP_BAR_VALUES )
    BattleEntity:SetTopBarTeamValuesVisible( TOP_BAR_VISIBLE )
    BattleEntity:SetUseCustomHeroLevels ( USE_CUSTOM_HERO_LEVELS )
    BattleEntity:SetCustomHeroMaxLevel ( MAX_LEVEL )
    BattleEntity:SetCustomXPRequiredToReachNextLevel( XP_PER_LEVEL_TABLE )

    BattleEntity:SetBotThinkingEnabled( USE_STANDARD_DOTA_BOT_THINKING )
    BattleEntity:SetTowerBackdoorProtectionEnabled( ENABLE_TOWER_BACKDOOR_PROTECTION )

    BattleEntity:SetFogOfWarDisabled(DISABLE_FOG_OF_WAR_ENTIRELY)
    BattleEntity:SetGoldSoundDisabled( DISABLE_GOLD_SOUNDS )
    BattleEntity:SetRemoveIllusionsOnDeath( REMOVE_ILLUSIONS_ON_DEATH )

    BattleEntity:SetAlwaysShowPlayerInventory( SHOW_ONLY_PLAYER_INVENTORY )
    BattleEntity:SetAnnouncerDisabled( DISABLE_ANNOUNCER )
    if FORCE_PICKED_HERO ~= nil then
      BattleEntity:SetCustomGameForceHero( FORCE_PICKED_HERO )
    end
    BattleEntity:SetFixedRespawnTime( FIXED_RESPAWN_TIME ) 
    BattleEntity:SetFountainConstantManaRegen( FOUNTAIN_CONSTANT_MANA_REGEN )
    BattleEntity:SetFountainPercentageHealthRegen( FOUNTAIN_PERCENTAGE_HEALTH_REGEN )
    BattleEntity:SetFountainPercentageManaRegen( FOUNTAIN_PERCENTAGE_MANA_REGEN )
    BattleEntity:SetLoseGoldOnDeath( LOSE_GOLD_ON_DEATH )
    BattleEntity:SetMaximumAttackSpeed( MAXIMUM_ATTACK_SPEED )
    BattleEntity:SetMinimumAttackSpeed( MINIMUM_ATTACK_SPEED )
    BattleEntity:SetStashPurchasingDisabled ( DISABLE_STASH_PURCHASING )

    for rune, spawn in pairs(ENABLED_RUNES) do
      BattleEntity:SetRuneEnabled(rune, spawn)
    end

    BattleEntity:SetUnseenFogOfWarEnabled( USE_UNSEEN_FOG_OF_WAR )

    BattleEntity:SetDaynightCycleDisabled( DISABLE_DAY_NIGHT_CYCLE )
    BattleEntity:SetKillingSpreeAnnouncerDisabled( DISABLE_KILLING_SPREE_ANNOUNCER )
    BattleEntity:SetStickyItemDisabled( DISABLE_STICKY_ITEM )

    self:OnFirstPlayerLoaded()
  end 
end

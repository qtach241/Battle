--[[ Primary Game Script Initialization ]]

BATTLE_VERSION = "1.00"
DEBUG_MODE = true

--[[ Create the main class for the addon ]]
if Battle == nil then
  _G.Battle = class({})
end

--[[ Load Libraries ]]

--[[ Load Internals ]]
--require('internal/battle')
--require('internal/events')

--[[ Load Settings and Event Handlers ]]
--require('settings')
--require('events')

--[[
This function should be used to set up Async precache calls at the beginning of 
gameplay.

In this function, place all of your PrecacheItemByNameAsync and
PrecacheUnitByNameAsync. These calls will be made after all players have loaded
in, but before they have selected their heroes. PrecacheItemByNameAsync can also
be used to precache dynamically-added datadriven abilities instead of items.
PrecacheUnitByNameAsync will precache the precache{} block statement of the unit
and all precache{} block statements for every Ability# defined on the unit.

This function should only be called once. If you need to precache more items,
abilities, units at a later time, call the functions individually (for example
if you want to precache units in a new wave of holdout).

This function should generally only be used if the Precache() function in
addon_game_mode.lua is not working.
]]
function Battle:PostLoadPrecache()
  DebugPrint('Post Load Pre-cache Success!')
end

--[[
This function is called once and only once as soon as the first player (almost
certain to be the server in local lobbies) loads in. It can be used to initialize
a state that isn't initializeable in InitGameMode() but needs to be done before
everyone loads in. 
]]
function Battle:OnFirstPlayerLoaded()
  DebugPrint('First Player has loaded')
end

--[[
This function is called once and only once after all players have loaded into
the game, right as the hero selection time begins. It can be used to initialize
non-hero player state or adjust the hero selection (i.e. force random, etc).
]]
function Battle:OnAllPlayersLoaded()
  DebugPrint('All Players have loaded into the game')
end

--[[
This function is called once and only once for every player when they spawn
into the game for the first time. It is also called if the player's hero is 
replaced with a new hero for any reason. This function is used for initializing 
heroes, such as adding levels, changing starting gold, removing/adding abilities, 
adding physics, etc.

The hero parameter is the hero entity that just spawned in.
]]
function Battle:OnHeroInGame(hero)
  DebugPrint('Hero spawned in game for the first time: ' .. hero:GetUnitName())
end

--[[
This function is called once and only once when the game completely begins
(about 0:00 on the clock). At this point, gold will begin to go up in ticks if
configured, creeps will spawn, towers will become damageable, etc. This function
is used for starting game timers/thinkers, starting the first round, etc.
]]
function Battle:OnGameInProgress()
  DebugPrint('The game has officially begun')
end

--[[
This function is called at the tail end of _InitGameMode() which is called by
Activate(), the main LUA entry point when the addon is loaded. 

The internal function _InitGameMode() takes care of GameRules and event hooks.
Use this function to initialize any other values/tables that will be needed
or to register custom console commands.
]]
function Battle:InitGameMode()
  DebugPrint('Done loading Battle game mode!')
end


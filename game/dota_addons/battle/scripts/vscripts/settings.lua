--[[ Global Properties ]]

ENABLE_HERO_RESPAWN = true               --[[ Heroes automatically respawn on a timer or stay dead until manually respawned? ]]
UNIVERSAL_SHOP_MODE = false              --[[ Main shop contains Secret Shop items as well as regular items? ]]
ALLOW_SAME_HERO_SELECTION = true         --[[ Let people select the same hero as each other? ]]

HERO_SELECTION_TIME = 30.0               --[[ How long do players get to select their hero? ]]
PRE_GAME_TIME = 5.0                      --[[ How long after people select their heroes should the horn blow and the game start? ]]
POST_GAME_TIME = 60.0                    --[[ How long should players look at the scoreboard before closing the server automatically? ]]
TREE_REGROW_TIME = 60.0                  --[[ How long should it take individual trees to respawn after being cut down/destroyed? ]]

GOLD_PER_TICK = 0                        --[[ How much gold should players get per tick? ]]
GOLD_TICK_TIME = 1                       --[[ How many seconds between gold ticks? ]]

RECOMMENDED_BUILDS_DISABLED = false      --[[ Disable the recommened builds for heroes? ]]
CAMERA_DISTANCE_OVERRIDE = 1800          --[[ How far out is camera allowed to go?  Use -1 for the default (1134) while still allowing for panorama camera distance changes. ]]

MINIMAP_ICON_SIZE = 1                    --[[ Minimap icon size for heroes? ]]
MINIMAP_CREEP_ICON_SIZE = 1              --[[ Minimap icon size for creeps? ]]
MINIMAP_RUNE_ICON_SIZE = 1               --[[ Minimap icon size for runes? ]]

RUNE_SPAWN_TIME = 120                    --[[ How many seconds between rune spawns? ]]
CUSTOM_BUYBACK_COST_ENABLED = true       --[[ Custom buyback cost setting? ]]
CUSTOM_BUYBACK_COOLDOWN_ENABLED = true   --[[ Custom buyback time? ]]
BUYBACK_ENABLED = false                  --[[ Allow people to buyback when they die? ]]

DISABLE_FOG_OF_WAR_ENTIRELY = false      --[[ Disable fog of war entirely for both teams? ]]
USE_UNSEEN_FOG_OF_WAR = false            --[[ Make unseen and fogged areas of the map completely black until uncovered by each team? ]]
                                         --[[ Note: DISABLE_FOG_OF_WAR_ENTIRELY must be false for USE_UNSEEN_FOG_OF_WAR to work ]]

USE_STANDARD_DOTA_BOT_THINKING = false   --[[ Have bots act like they would in Dota? (This requires 3 lanes, normal items, etc) ]]
USE_STANDARD_HERO_GOLD_BOUNTY = true     --[[ Give gold for hero kills the same as in Dota, or allow those values to be changed? ]]

USE_CUSTOM_TOP_BAR_VALUES = true         --[[ Use customized top bar values or use the default kill count per team? ]]
TOP_BAR_VISIBLE = true                   --[[ Display the top bar score/count at all? ]]
SHOW_KILLS_ON_TOPBAR = false             --[[ Display kills only on the top bar? (No denies, suicides, kills by neutrals)  Requires USE_CUSTOM_TOP_BAR_VALUES ]]

ENABLE_TOWER_BACKDOOR_PROTECTION = false --[[ Enable backdoor protection for towers? ]]
REMOVE_ILLUSIONS_ON_DEATH = false        --[[ Remove all illusions if the main hero dies? ]]
DISABLE_GOLD_SOUNDS = false              --[[ Disable the gold sound when players get gold? ]]

END_GAME_ON_KILLS = true                 --[[ Game ends after a certain number of kills? ]]
KILLS_TO_END_GAME_FOR_TEAM = 50          --[[ How many kills for a team should signify an end of game? ]]

USE_CUSTOM_HERO_LEVELS = true            --[[ Allow heroes to have custom levels? ]]
MAX_LEVEL = 50                           --[[ Custom hero level cap. ]]
USE_CUSTOM_XP_VALUES = true              --[[ Use custom XP values to level up heroes, or the default Dota numbers? ]]

--[[ Customize XP per level. ]]
XP_PER_LEVEL_TABLE = {}
for i=1,MAX_LEVEL do
  XP_PER_LEVEL_TABLE[i] = (i-1) * 100
end

ENABLE_FIRST_BLOOD = true                --[[ Enable first blood for the first kill in this game? ]]
HIDE_KILL_BANNERS = false                --[[ Hide the kill banners that show when a player is killed? ]]
LOSE_GOLD_ON_DEATH = true                --[[ Have players lose the normal amount of dota gold on death? ]]
SHOW_ONLY_PLAYER_INVENTORY = false       --[[ Only allow players to see their own inventory even when selecting other units? ]]
DISABLE_STASH_PURCHASING = false         --[[ Prevent players from being able to buy items into their stash when not at a shop? ]]
DISABLE_ANNOUNCER = false                --[[ Disable the announcer from working in the game? ]]
FORCE_PICKED_HERO = nil                  --[[ Force players to spawn as a hero? (e.g. "npc_dota_hero_axe").  nil = allow players to pick their own hero. ]]

FIXED_RESPAWN_TIME = -1                  --[[ Value used for fixed respawn timer? Use -1 to keep the default dota behavior. ]]
FOUNTAIN_CONSTANT_MANA_REGEN = -1        --[[ Value used for the constant fountain mana regen?  Use -1 to keep the default dota behavior. ]]
FOUNTAIN_PERCENTAGE_MANA_REGEN = -1      --[[ Value used for the percentage fountain mana regen?  Use -1 to keep the default dota behavior. ]]
FOUNTAIN_PERCENTAGE_HEALTH_REGEN = -1    --[[ Value used for for the percentage fountain health regen?  Use -1 to keep the default dota behavior. ]]
MAXIMUM_ATTACK_SPEED = 600               --[[ Value used for the maximum attack speed? ]]
MINIMUM_ATTACK_SPEED = 20                --[[ Value used for the minimum attack speed? ]]

GAME_END_DELAY = -1                      --[[ How long to wait after the game winner is set to display the victory banner and End Screen?  Use -1 to keep the default (about 10 seconds). ]]
VICTORY_MESSAGE_DURATION = 3             --[[ How long to wait after the victory message displays to show the End Screen? ]]
STARTING_GOLD = 500                      --[[ How much starting gold to give to each player? ]]
DISABLE_DAY_NIGHT_CYCLE = false          --[[ Disable the day night cycle from naturally occurring? (Manual adjustment still possible). ]]
DISABLE_KILLING_SPREE_ANNOUNCER = false  --[[ Disable the killing spree announcer? ]]
DISABLE_STICKY_ITEM = false              --[[ Disable the sticky item button in the quick buy area? ]]
SKIP_TEAM_SETUP = false                  --[[ Skip the team setup entirely? ]]
ENABLE_AUTO_LAUNCH = true                --[[ Automatically have the game complete team setup after AUTO_LAUNCH_DELAY seconds? ]]
AUTO_LAUNCH_DELAY = 30                   --[[ How long should the default team selection launch timer be?  The default for custom games is 30.  Setting to 0 will skip team selection. ]]
LOCK_TEAM_SETUP = false                  --[[ Lock the teams initially?  Note that the host can still unlock the teams. ]]

--[[ Which runes should be enabled to spawn? ]]
--[[ NOTE: Always need at least 2 non-bounty type runes to be able to spawn or game will crash! ]]
ENABLED_RUNES = {}
ENABLED_RUNES[DOTA_RUNE_DOUBLEDAMAGE] = true
ENABLED_RUNES[DOTA_RUNE_HASTE] = true
ENABLED_RUNES[DOTA_RUNE_ILLUSION] = true
ENABLED_RUNES[DOTA_RUNE_INVISIBILITY] = true
ENABLED_RUNES[DOTA_RUNE_REGENERATION] = true
ENABLED_RUNES[DOTA_RUNE_BOUNTY] = true
ENABLED_RUNES[DOTA_RUNE_ARCANE] = true


MAX_NUMBER_OF_TEAMS = 10                            --[[ How many potential teams can be in this game mode? ]]
USE_CUSTOM_TEAM_COLORS = true                       --[[ Use custom team colors? ]]
USE_CUSTOM_TEAM_COLORS_FOR_PLAYERS = true           --[[ Use custom team colors to color the players/minimap? ]]

TEAM_COLORS = {}                                    --[[ If USE_CUSTOM_TEAM_COLORS is set, use these colors. ]]
TEAM_COLORS[DOTA_TEAM_GOODGUYS] = { 61, 210, 150 }  --[[ Teal ]]
TEAM_COLORS[DOTA_TEAM_BADGUYS]  = { 243, 201, 9 }   --[[ Yellow ]]
TEAM_COLORS[DOTA_TEAM_CUSTOM_1] = { 197, 77, 168 }  --[[ Pink ]]
TEAM_COLORS[DOTA_TEAM_CUSTOM_2] = { 255, 108, 0 }   --[[ Orange ]]
TEAM_COLORS[DOTA_TEAM_CUSTOM_3] = { 52, 85, 255 }   --[[ Blue ]]
TEAM_COLORS[DOTA_TEAM_CUSTOM_4] = { 101, 212, 19 }  --[[ Green ]]
TEAM_COLORS[DOTA_TEAM_CUSTOM_5] = { 129, 83, 54 }   --[[ Brown ]]
TEAM_COLORS[DOTA_TEAM_CUSTOM_6] = { 27, 192, 216 }  --[[ Cyan ]]
TEAM_COLORS[DOTA_TEAM_CUSTOM_7] = { 199, 228, 13 }  --[[ Olive ]]
TEAM_COLORS[DOTA_TEAM_CUSTOM_8] = { 140, 42, 244 }  --[[ Purple ]]


USE_AUTOMATIC_PLAYERS_PER_TEAM = true               --[[ Set the number of players to 10 / MAX_NUMBER_OF_TEAMS? ]]

CUSTOM_TEAM_PLAYER_COUNT = {}
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_GOODGUYS] = 1
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_BADGUYS]  = 1
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_1] = 1
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_2] = 1
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_3] = 1
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_4] = 1
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_5] = 1
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_6] = 1
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_7] = 1
CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_8] = 1
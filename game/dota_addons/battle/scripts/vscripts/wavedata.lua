--[[ Manages the spawning of enemy waves ]]

wavesKV = LoadKeyValues('scripts/kv/waves.kv')
enemiesKV = LoadKeyValues('scripts/npc/npc_units_custom.txt')

if not WAVE_ENEMIES then
  WAVE_ENEMIES = {} -- Array that stores the order that enemies spawn in. See: /scripts/kv/waves.kv
  WAVE_HEALTH = {} -- Array that stores enemy health values per wave. See /scripts/kv/waves.kv
  ENEMY_SCRIPT_OBJECTS = {}
  ENEMIES_PER_WAVE = 10
  CURRENT_WAVE = 1
  CURRENT_BOSS_WAVE = 0
  WAVE_COUNT = wavesKV["WaveCount"]
end

--[[
Loads the enemy and health data for each wave of enemies.
]]
function LoadWaveData()
  local settings = GameSettingsKV.GameLength["Normal"]
  local baseHP = tonumber(settings["BaseHP"])

  -- yada yada yada
end

function SpawnEntity(entityClass, playerID, position)
  local entity = CreateUnitByName(entityClass, position, true, nil, nil, DOTA_TEAM_NEUTRALS)

  if entity then
    return entity
  else
    clog.error("ERROR", "Attempted to create unknown creep type: " .. entityClass)
    return nil
  end
end

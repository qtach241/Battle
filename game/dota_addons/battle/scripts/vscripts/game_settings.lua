--[[ Manages the Battle specific game settings ]]

GameSettingsKV = LoadKeyValues("scripts/kv/game_settings.kv")

if not GameSettings then
  GameSettings = {}
  GameSettings.__index = GameSettings
  GameSettings.gamemode = ""
  GameSettings.endless = "Normal"
  GameSettings.order = "Normal"
  GameSettings.length = ""
  GameSettings.elements = ""
  GameSettings.difficulty = nil
  GameSettings.mapSettings = {}

  DIFFICULTY_OBJECTS = {}
end


--[[ Primary Game Script ]]

BATTLE_VERSION = "1.00"
DEBUG_MODE = true

--[[ Create the main class for the addon ]]
if Battle == nil then
  _G.Battle = class({})
end

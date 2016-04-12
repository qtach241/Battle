--[[ Event Handlers ]]

--[[
Clean up a player when they leave.
]]
function Battle:OnDisconnect(keys)
  local name = keys.name
  local networkid = keys.networkid
  local reason = keys.reason
  local userid = keys.userid
end

--[[
The overall game state has changed.
]]
function Battle:OnGameRulesStateChange(keys)
  local newState = GameRules:State_Get()
end

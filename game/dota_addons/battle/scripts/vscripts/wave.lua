Wave = createClass({
  constructor = function(self, playerID, waveNumber)
    self.playerID = playerID
    --self.playerData = GetPlayerData(self.playerID)

    self.waveNumber = waveNumber
    self.enemiesRemaining = ENEMIES_PER_WAVE
    self.enemies = {}
    self.startTime = 0
    self.endTime = 0
    self.kills = 0
    self.callback = nil
  end},
  {},
  nil
)

function Wave:GetWaveNumber()
  return self.waveNumber
end

function Wave:GetEnemies()
  return self.enemies
end

--[[
Set the callback when the player beats this wave
]]
function Wave:SetOnCompletedCallback(func)
  self.callback = func
end

function Wave:OnEnemyKilled(index)
  if self.enemies[index] then
    self.enemies[index] = nil
    self.enemiesRemaining = self.enemiesRemaining - 1
    self.kills = self.kills + 1

    if self.enemiesRemaining <= 0 and self.callback then
      self.endTime = GameRules:GetGameTime()
      self.callback()
    end
  end
end

function Wave:RegisterEnemy(index)
  if not self.enemies[index] then
    self.enemies[index] = index
  else
    clog.warning("Attempted to register enemy " .. index .. " which is already registered!")
  end
end

function Wave:SpawnWave()

  local time_between_spawns = 0.5
  self.startTime = GameRules:GetGameTime() + time_between_spawns
  self.kills = 0
  local enemyBossSequence = 0

  self.spawnTimer = Timers:CreateTimer(time_between_spawns, function()
    local entity = SpawnEntity(WAVE_ENEMIES[self.waveNumber], self.playerID, startPos)
    if entity then
      self:RegisterEnemy(entity:entindex())
    end
  end  
end

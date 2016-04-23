--[[
Initializes the required data for damage, and vision calculation.
]]
function FireBullet(keys)
    DebugPrint('FireBullet')
    --DebugPrintTable(keys)

    local caster = keys.caster
    local caster_location = caster:GetAbsOrigin()
    local target_point = keys.target_points[1]
    local ability = keys.ability
    local ability_level = ability:GetLevel() - 1

    ability.bullet_vision_radius = ability:GetLevelSpecialValueFor("bullet_vision", ability_level)
    ability.bullet_vision_duration = ability:GetLevelSpecialValueFor("vision_duration", ability_level)
    ability.bullet_speed = ability:GetLevelSpecialValueFor("bullet_speed", ability_level)
    ability.bullet_start = caster_location
    ability.bullet_start_time = GameRules:GetGameTime()
    ability.bullet_direction = (target_point - caster_location):Normalized()
end

--[[
Calculates the distance traveled by the bullet. Applies damage and stun according to calculations.
]]
function BulletHit(keys)
    DebugPrint('BulletHit')
    --DebugPrintTable(keys)

    local caster = keys.caster
    local target = keys.target
    local target_location = target:GetAbsOrigin()
    local ability = keys.ability
    local ability_level = ability:GetLevel() - 1
    local ability_damage = ability:GetAbilityDamage()

    --[[ Initialize the damage table. ]]
    local damage_table = {}
    damage_table.attacker = caster
    damage_table.victim = target
    damage_table.damage_type = ability:GetAbilityDamageType()
    damage_table.ability = ability

    --[[ Get bullet special values. ]]
    local bullet_max_stunrange = ability:GetLevelSpecialValueFor("bullet_max_stunrange", ability_level)
    local bullet_max_damagerange = ability:GetLevelSpecialValueFor("bullet_max_damagerange", ability_level)
    local bullet_min_stun = ability:GetLevelSpecialValueFor("bullet_min_stun", ability_level)
    local bullet_max_stun = ability:GetLevelSpecialValueFor("bullet_max_stun", ability_level)
    local bullet_bonus_damage = ability:GetLevelSpecialValueFor("bullet_bonus_damage", ability_level)

    --[[ Calculate stun and damage per distance. ]]
    local stun_per_30 = bullet_max_stun/(bullet_max_stunrange*1/30)
    local damage_per_30 = bullet_bonus_damage/(bullet_max_damagerange*1/30)

    local bullet_stun_duration = 0
    local bullet_damage = 0
    local distance = (target_location - ability.bullet_start):Length2D()

    --[[ Calculate stun duration ]]
    if distance < bullet_max_stunrange then
        bullet_stun_duration = distance*1/30*stun_per_30 + bullet_min_stun
    else
        bullet_stun_duration = bullet_max_stun
    end

    --[[ Calculate damage. ]]
    if distance < bullet_max_damagerange then
        bullet_damage = distance*1/30*damage_per_30 + ability_damage
    else
        bullet_damage = ability_damage + bullet_bonus_damage
    end

    --[[ Apply damage table and stun modifier. ]]
    target:AddNewModifier(caster, ability, "modifier_stunned", {duration = bullet_stun_duration})
    damage_table.damage = bullet_damage
    ApplyDamage(damage_table)
end

--[[
Calculate bullet location using available data and create a vision point.
]]
function BulletVision(keys)
    DebugPrint('BulletVision')
    --DebugPrintTable(keys)

    local caster = keys.caster
    local ability = keys.ability

    --[[ Calculates the bullet location using the data saved when bullet was fired. ]]
    local vision_location = ability.bullet_start + ability.bullet_direction * ability.bullet_speed *
        (GameRules:GetGameTime() - ability.bullet_start_time)

    --[[ Create the vision point. ]]
    AddFOWViewer(caster:GetTeamNumber(), vision_location, ability.bullet_vision_radius,
        ability.bullet_vision_duration, false)
end
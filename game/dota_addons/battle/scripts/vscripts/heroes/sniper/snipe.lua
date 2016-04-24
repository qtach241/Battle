--[[
Initializes the required data for damage and vision calculation.
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

    --[[ Make reload ability active. ]]
    local reload_ability = ability.snipe_reload_ability
    -- [[TODO: Only set activated if there is a magazine available. ]]
    reload_ability:SetActivated(true)
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

    --[[ Calculate stun duration. ]]
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

--[[
When Snipe is first upgraded, upgrade the sub ability reload and make it inactive.
]]
function OnUpgrade(keys)
    DebugPrint('OnUpgrade')
    --DebugPrintTable(keys)

    local caster = keys.caster
    local ability = keys.ability

    --[[ Only proceed if this is the first upgrade level. ]]
    if ability:GetLevel() == 1 then
        local reload_ability = caster:FindAbilityByName(keys.sub_ability)

        ability.snipe_reload_ability = reload_ability

        if not reload_ability then
            DebugPrint('Reload not found!')
        end

        reload_ability:SetLevel(ability:GetLevel())

        if reload_ability:GetLevel() == 1 then
            reload_ability:SetActivated(false)
        end
    end
end

--[[
When Reload finishes channeling, consume 1 magazine and set mana to max.
]]
function Reload(keys)
    DebugPrint('Reload')
    --DebugPrintTable(keys)

    local caster = keys.caster
    local max_mana = caster:GetMaxMana()

    --[[ TODO: Consume 1 magazine. ]]
    caster:SetMana(max_mana)

    --[[ Deactivate reload ability until the next shot. ]]
    local reload_ability = caster:FindAbilityByName(keys.abilitystring)
    reload_ability:SetActivated(false)
    --[[
    The reason why we have to find the ability by name again instead of simply reading the string
    stored in [ability.snipe_reload_ability] is because this function is invoked by sniper_reload,
    not sniper_snipe. The [ability.snipe_reload_ability] key passed in from the sniper_reload still
    reads nil as it was never assigned a value, unlike the same key passed in from sniper_snipe,
    which has its value assigned in function OnUpgrade.
    ]]
end
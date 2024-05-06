modifier_emergency_lane = class({})

function modifier_emergency_lane:DeclareFunctions()
    local decFuncs = {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_ATTACKSPEED_PERCENTAGE,
        MODIFIER_EVENT_ON_ATTACK,
        MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
        MODIFIER_PROPERTY_IGNORE_ATTACKSPEED_LIMIT
    }
    return decFuncs
end


--------------------Piss------------------------

function modifier_emergency_lane:IsBuff()
    return true
end

function modifier_emergency_lane:RemoveOnDeath()
    return true
end

function modifier_emergency_lane:OnCreated()

end

function modifier_emergency_lane:GetModifierIgnoreMovespeedLimit()
    return 1
end

function modifier_emergency_lane:GetModifierIgnoreAttackspeedLimit()
    return 1
end

function modifier_emergency_lane:GetModifierMoveSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor("movement_speed_bonus")
end

function modifier_emergency_lane:GetModifierAttackSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor("attack_speed_bonus")
end

--[[ function modifier_emergency_lane:CheckState()
    return {[MODIFIER_STATE_UNTARGETABLE] = true,
    [MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = true,
    [MODIFIER_STATE_SILENCED] = true}
end ]]

--------------------Piss End------------------------

function modifier_emergency_lane:OnAttack(params)
    if IsServer() then
        if params.attacker == self:GetParent() then
            print("Globetrotter has attacked")
            local target = params.target
            local damageValue = CalcRandomFunnyDamage(target)
            local damageTable = {
                victim = target,
                attacker = params.attacker,
                damage = damageValue,
                damage_type = DAMAGE_TYPE_PURE,
                ability = self:GetAbility()
            }
            ApplyDamage(damageTable)
            print("Applied damage was: " .. damageTable["damage"])
            self:GetCaster():EmitSound("globetrotterCrash")
            self:GetCaster():StopSound("globetrotterWFastLane")
            self:GetCaster():RemoveModifierByName("modifier_emergency_lane")
        else if params.target == self:GetParent() then
            print("Globetrotter has been attacked")
            local target = params.target
            local damageValue = CalcRandomFunnyDamage(target)
            local damageTable = {
                victim = target,
                attacker = params.attacker,
                damage = damageValue,
                damage_type = DAMAGE_TYPE_PURE,
                ability = self:GetAbility()
            }
            ApplyDamage(damageTable)
            print("Applied damage was: " .. damageTable["damage"])
            self:GetCaster():EmitSound("globetrotterCrash")
            self:GetCaster():StopSound("globetrotterWFastLane")
            self:GetCaster():RemoveModifierByName("modifier_emergency_lane")
        end
        end
    end
end

function CalcRandomFunnyDamage(victim)
    local max_health = victim:GetMaxHealth()
    math.randomseed( GameRules:GetTimeOfDay())
    local damage_percentage = 0.1 * math.random(1,9)
    print (damage_percentage)
    local damage = max_health * damage_percentage
    return damage
end
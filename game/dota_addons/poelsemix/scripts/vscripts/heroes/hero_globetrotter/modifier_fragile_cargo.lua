modifier_fragile_cargo = class({})

function modifier_fragile_cargo:DeclareFunctions()
    local decFuncs = {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_PERCENTAGE,
        MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_TOTAL_PERCENTAGE
    }
    return decFuncs
end

function modifier_fragile_cargo:GetModifierPhysicalArmorTotal_Percentage()
    return self:GetAbility():GetSpecialValueFor("armor_reduction_percentage")
end

function modifier_fragile_cargo:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("movement_speed_percentage")
end

function modifier_fragile_cargo:GetModifierAttackSpeedPercentage()
    return self:GetAbility():GetSpecialValueFor("attack_speed_percentage")
end

function modifier_fragile_cargo:GetModifierDamageOutgoing_Percentage()
    return self:GetAbility():GetSpecialValueFor("attack_damage_percentage")
end

function modifier_fragile_cargo:IsBuff()
    return true
end

function modifier_fragile_cargo:RemoveOnDeath()
    return true
end

function modifier_fragile_cargo:OnRemoved()
    if IsServer() then

    end
end

function modifier_fragile_cargo:OnCreated()
    if IsServer() then
        local caster = self:GetCaster()
        local heavy_cargo = caster:GetAbilityByIndex(3)
        if heavy_cargo:GetToggleState()then
            heavy_cargo:ToggleAbility()
            heavy_cargo:StartCooldown(30)
        end
    end
end
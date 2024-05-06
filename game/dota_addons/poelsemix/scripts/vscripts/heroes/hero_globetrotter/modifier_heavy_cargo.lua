modifier_heavy_cargo = class({})

function modifier_heavy_cargo:DeclareFunctions()
local decFuncs = {
    MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    MODIFIER_PROPERTY_ATTACKSPEED_PERCENTAGE,
    MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE
}
return decFuncs
end
function modifier_heavy_cargo:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("movement_reduction_percentage")
end

function modifier_heavy_cargo:GetModifierAttackSpeedPercentage()
    return self:GetAbility():GetSpecialValueFor("attack_speed_reduction_percentage")
end

function modifier_heavy_cargo:GetModifierDamageOutgoing_Percentage()
    return self:GetAbility():GetSpecialValueFor("attack_increase_percentage")
end

function modifier_heavy_cargo:IsBuff()
    return true
end

function modifier_heavy_cargo:RemoveOnDeath()
    return true
end

function modifier_heavy_cargo:OnCreated()
    if IsServer() then
        local caster = self:GetCaster()
        local fragile_cargo = caster:GetAbilityByIndex(4)
        if fragile_cargo:GetToggleState()then
            fragile_cargo:ToggleAbility()
            fragile_cargo:StartCooldown(30)
        end
    end
end
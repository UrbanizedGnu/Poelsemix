---------------------------------------------------------------------
        --Plan--
    --Når ability bliver activated, skiftes fragile_cargo til true
    --Alle andre vogne bliver sat til false
    --Fjern modifiers fra andre vogne
    --Giver modifiers til hero fragile
        --Sæt health 25% lavere, increase attack damage med 20%
    --Cooldown aktiveres på alle vogn-abilties
---------------------------------------------------------------------
LinkLuaModifier("modifier_fragile_cargo", "heroes/hero_globetrotter/modifier_fragile_cargo", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_heavy_cargo", "heroes/hero_globetrotter/modifier_heavy_cargo", LUA_MODIFIER_MOTION_NONE)
fragile_cargo = class({})
function fragile_cargo:OnToggle()
    local caster = self:GetCaster()
    if self:GetToggleState() then
        print("Fragile Cargo has been equipped")
        caster:AddNewModifier(caster, self, "modifier_fragile_cargo", {})
        ReplaceAbility(self:GetCaster(), "no_wagon_smack", "wagon_smack")
    else
        print("Fragile Cargo has been unequipped")
        caster:RemoveModifierByName("modifier_fragile_cargo")
        ReplaceAbility(self:GetCaster(), "wagon_smack", "no_wagon_smack")
    end
end


function ReplaceAbility(caster, targetAbility, replaceAbility)
    local smack_ability = caster:FindAbilityByName(targetAbility)
    local target_level = smack_ability:GetLevel()
    local target_cooldown = smack_ability:GetCooldownTimeRemaining()
    caster:RemoveAbility(targetAbility)

    caster:AddAbility(replaceAbility)
    smack_ability = caster:FindAbilityByName(replaceAbility)
    smack_ability:SetLevel(target_level)
    smack_ability:StartCooldown(target_cooldown)
end
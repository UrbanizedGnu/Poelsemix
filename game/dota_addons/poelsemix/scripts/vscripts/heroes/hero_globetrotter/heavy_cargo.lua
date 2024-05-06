---------------------------------------------------------------------
        --Plan--
    --Når ability bliver activated, skiftes heavy_cargo til true
    --Alle andre vogne bliver sat til false
    --Fjern modifiers fra andre vogne
    --Cooldown aktiveres på alle vogn-abilties
    --Giv modifiers fra heavy cargo
        --Increase attack damage med 30%, increase armor med 30%, decrease movement speed med 50%
    ----------------------------------------------------------------------

LinkLuaModifier("modifier_fragile_cargo", "heroes/hero_globetrotter/modifier_fragile_cargo", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_heavy_cargo", "heroes/hero_globetrotter/modifier_heavy_cargo", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_wagon", "heroes/hero_globetrotter/modifier_wagon", LUA_MODIFIER_MOTION_NONE)

local wagon = nil
heavy_cargo = class({})
function heavy_cargo:OnToggle()
    local caster = self:GetCaster()
    if self:GetToggleState() then
        print("Heavy Cargo has been equipped")
        caster:RemoveModifierByName("modifier_fragile_cargo")
        caster:AddNewModifier(caster, self, "modifier_heavy_cargo", {})
        ReplaceAbility(self:GetCaster(), "no_wagon_smack", "wagon_smack")
        wagon = SpawnWagon("npc_wagon_test", self:GetCaster():GetAttachmentOrigin(5), self:GetCaster())
        function wagon:NoHealthBar()
            return true
        end
    else
        print("Heavy Cargo has been unequipped")
        caster:RemoveModifierByName("modifier_heavy_cargo")
        ReplaceAbility(self:GetCaster(), "wagon_smack", "no_wagon_smack")
        wagon:SetParent(nil, nil)
        wagon:ForceKill(false)
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


function SpawnWagon(unit_name, spawn_pos, caster)
    wagon = CreateUnitByName(unit_name, spawn_pos, true, caster, nil, caster:GetTeam())
    --wagon:FaceTowards(spawn_pos)
    if IsServer() then
        wagon:SetParent(caster, "attach_hitch")
        wagon:SetForwardVector(caster:GetRightVector())
    end
    function wagon:IsAttachedToParent()
        return true
    end
    return wagon
end
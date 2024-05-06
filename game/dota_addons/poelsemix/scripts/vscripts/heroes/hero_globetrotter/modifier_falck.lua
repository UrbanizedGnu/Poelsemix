modifier_falck = class({})

LinkLuaModifier("modifier_falck_invuln", "heroes/hero_globetrotter/modifier_falck_invuln", LUA_MODIFIER_MOTION_NONE)

--Tjekker om incoming damage vil slå ihjel
--hvis ja:
--Giver Globetrotter 20% af sit max liv tilbage
--Gør Globetrotter udødelig i _tid
--Tager 600 guld fra Globetrotter
--Efter _tid, fjern udødelighed
function modifier_falck:DeclareFunctions()
    local decFuncs = {
        MODIFIER_EVENT_ON_DAMAGE_CALCULATED,
        MODIFIER_EVENT_ON_ATTACK_START,
        MODIFIER_EVENT_ON_TAKEDAMAGE
    }
    return decFuncs
end

function modifier_falck:IsBuff()
    return true
end


function modifier_falck:OnTakeDamage(params)
    if IsServer() then
        if params.unit == self:GetParent() then
            parent = self:GetParent()
            insuranceCost = self:GetAbility():GetSpecialValueFor("repair_cost")
                if params.damage >= parent:GetHealth() and parent:GetGold() >= insuranceCost and parent:HasModifier("modifier_falck_invuln") == false then
                    print("the check was there for fatal damage")
                    parent:AddNewModifier(parent, self:GetAbility(), "modifier_falck_invuln", {})
                    parent:SetHealth(parent:GetMaxHealth()*0.2)
                    parent:SpendGold(insuranceCost, 19)
                end
        end
    end
end
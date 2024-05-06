modifier_falck_invuln = class({})

--Gør invulnerable
-- Sæt duration til _tid

function modifier_falck_invuln:DeclareFunctions()
    local decFuncs = {
        MODIFIER_STATE_INVULNERABLE
    }
    return decFuncs
end

function modifier_falck_invuln:OnCreated()
    --Virker ikke. Fiks det. Prøv at manuelt hente ability level
    --NVM
    parent = self:GetParent()
    ability = parent:FindAbilityByName("falck")
    self:SetDuration(ability:GetSpecialValueFor("insurance_time"), true)

end

function modifier_falck_invuln:CheckState()
    return {[MODIFIER_STATE_INVULNERABLE] = true}
end
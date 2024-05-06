falck = class ({})

LinkLuaModifier("modifier_falck", "heroes/hero_globetrotter/modifier_falck", LUA_MODIFIER_MOTION_NONE)

--Globetrotter aktiverer falck abonnement.
--Hvis Globetrotter tager fatal damage, gør ham udødelig i 0.5 sekunder, fratag 500 guld, sæt hans liv tilbage til 20% max health.
--Description: "As long as Globetrotter has an active Falck Insurance-subscription, he cannot die - for a fee."

function falck:OnToggle()
    local caster = self:GetCaster()
    if self:GetToggleState() then
        print(self:GetLevel())
        caster:AddNewModifier(caster, self, "modifier_falck", {})
    else
        caster:RemoveModifierByName("modifier_falck")
    end
end
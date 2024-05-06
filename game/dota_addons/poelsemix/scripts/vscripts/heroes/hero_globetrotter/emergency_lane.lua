LinkLuaModifier("modifier_emergency_lane", "heroes/hero_globetrotter/modifier_emergency_lane", LUA_MODIFIER_MOTION_NONE)

emergency_lane = class({})

--- Når ability bruges, sættes modifier på, der giver ekstra movement speed
--- Afspiller funny lydeffekt
--- Næste gang globetrotter rammer et angreb, skal damage ganges op med en eller anden værdi, og modifieren fjernes
--- Hvis globetrotter bliver ramt inden han når at angribe, ganges damage taken op med en eller anden værdi, og modifieren fjernes

function emergency_lane:OnSpellStart()
    local caster = self:GetCaster()
    caster:AddNewModifier(caster, self, "modifier_emergency_lane", {})
    caster:EmitSound("globetrotterWFastLane")
end
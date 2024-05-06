wagon_smack = wagon_smack or class({})

function wagon_smack:OnSpellStart()
    local caster = self:GetCaster()
    local point = self:GetCursorPosition()
    

end

---------------------------------------------------------------------
        --Plan--
    --Tjek hvilken, hvis nogen, vogn er aktiv
    --Calculate attack delay og radius baseret på dette
    --Calculate attack damage baseret på dette
    --Angrib i en AOE omkring truck med given radius og delay før et enkelt angreb med given damage udføres på alle enemies i radius
---------------------------------------------------------------------
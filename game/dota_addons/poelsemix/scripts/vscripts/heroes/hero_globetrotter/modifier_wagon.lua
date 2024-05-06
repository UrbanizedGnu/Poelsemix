modifier_wagon = class({})

function modifier_wagon:OnIntervalThink()
    wagon = self:GetParent()
    truck = wagon:GetParent()

    wagon:FaceTowards(truck:EyePosition())
end
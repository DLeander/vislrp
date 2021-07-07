local meta = FindMetaTable("Player")

function meta:GetBalance()
    return self:GetNWInt("playerMoney",0)
end

function meta:GetJobs()
    return self:GetNWInt("playerJob", 0)
end

function meta:CanAfford(cost)
    if (self:GetBalance() >= cost) then
        return true
    else
        return false
    end
end
local meta = FindMetaTable("Player")

function meta:AddToBalance(amount)
    local curBalance = self:GetBalance()

    self:SetBalance(curBalance + amount)
end

function meta:RemoveFromBalance(amount)
    local curBalance = self:GetBalance()

    self:SetBalance(curBalance - amount)
end

function meta:SetBalance(balance)
    self:SetNWInt("playerMoney", balance)
end
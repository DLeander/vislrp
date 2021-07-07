function setSalaryTimer(ply)
    timer.Create("SalaryTimer"..ply:UserID(), 300, 0, function()
        local plyClass = PLAYER_CLASSES[ply:GetNWInt("playerJob")]
        local oldBal = ply:GetNWInt("playerMoney")

        if (plyClass.name == "District Governor") then
            local governorpay = #player.GetAll()*global_tax
            ply:SetNWInt("playerMoney", oldBal + governorpay)
            if governorpay > 0 then 
                ply:ChatPrint("You just received tax money "..tostring(((#player.GetAll())-1)*global_tax).."$")
            else
                ply:ChatPrint("You did not receive any tax money as there is no tax.")
            end
            return
        else
            ply:SetNWInt("playerMoney", oldBal + plyClass.salary-global_tax)
            ply:ChatPrint("You just received a salary of "..tostring(plyClass.salary-global_tax.."$").." and payed a tax of "..tostring(global_tax).."$")
            return
        end
    end)
end
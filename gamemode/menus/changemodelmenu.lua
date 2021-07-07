function changeCharacterModel()
    local ply = LocalPlayer()
    local oldModel = ply:GetNWString("charModel")
    local modelSelected = 0

    local DFrame = vgui.Create( "DFrame" )
    xsize = ScrW()/4
    ysize = ScrH()/4
    DFrame:SetSize( xsize, ysize ) -- Set the size of the panel
    DFrame:Center()
    DFrame:MakePopup()
    DFrame:ShowCloseButton(true)
    DFrame:SetTitle("VislRP Character Model Change")
    DFrame:SetDraggable(false)
    DFrame.Paint = function()
        surface.SetDrawColor(50,50,50,230)
        surface.DrawRect(0,0,DFrame:GetWide(), DFrame:GetTall())

        surface.SetDrawColor(20,20,20,255)
        surface.DrawRect(0,24,DFrame:GetWide(), 1)
        draw.DrawText("The changes will appear next time you respawn.", "DermaDefaultBold", 140, 30, Color(255,255,255,255), 1)
        draw.DrawText("Select your new character model:", "DermaDefaultBold", 100, 50, Color(255,255,255,255), 1)
    end

    local ModelView = vgui.Create("DModelPanel", DFrame)
    ModelView:SetSize(250,250)
    ModelView:SetPos(185,15)
    ModelView:SetFOV(55)
    ModelView:SetModel(ply:GetModel())
    ModelView:SetCamPos(ModelView:GetCamPos() + Vector(0,0,15))
    function ModelView:LayoutEntity(ent) return end

    local DComboBox = vgui.Create("DComboBox", DFrame)
    DComboBox:SetPos(10, 70)
    DComboBox:SetSize(165, 20)
    DComboBox:SetValue("Select Your Character Model")
    DComboBox:AddChoice("Female 1")
    DComboBox:AddChoice("Female 2")
    DComboBox:AddChoice("Female 3")
    DComboBox:AddChoice("Female 4")
    DComboBox:AddChoice("Female 5")
    DComboBox:AddChoice("Female 6")
    DComboBox:AddChoice("Male 1")
    DComboBox:AddChoice("Male 2")
    DComboBox:AddChoice("Male 3")
    DComboBox:AddChoice("Male 4")
    DComboBox:AddChoice("Male 5")
    DComboBox:AddChoice("Male 6")
    DComboBox:AddChoice("Male 7")
    DComboBox:AddChoice("Male 8")
    DComboBox:AddChoice("Male 9")
    DComboBox.OnSelect = function(self, index, value)
        if (index == 1) then
            ModelView:SetModel("models/smalls_civilians/pack2/female/hoodiepulloverjeans/female_01_hoodiepulloverjeans_pm.mdl")
            modelSelected = 1
        end
        if (index == 2) then
            ModelView:SetModel("models/smalls_civilians/pack2/female/hoodiepulloversweats/female_02_hoodiepulloversweats_pm.mdl")
            modelSelected = 2
        end
        if (index == 3) then
            ModelView:SetModel("models/smalls_civilians/pack2/female/hoodiezippedjeans/female_03_hoodiezippedjeans_pm.mdl")
            modelSelected = 3
        end
        if (index == 4) then
            ModelView:SetModel("models/smalls_civilians/pack2/female/hoodiezippedsweats/female_04_hoodiezippedsweats_pm.mdl")
            modelSelected = 4
        end
        if (index == 5) then
            ModelView:SetModel("models/smalls_civilians/pack2/female/parkajeans/female_06_parkajeans_pm.mdl")
            modelSelected = 5
        end
        if (index == 6) then
            ModelView:SetModel("models/smalls_civilians/pack2/female/parkasweats/female_07_parkasweats_pm.mdl")
            modelSelected = 6
        end
        if (index == 7) then
            ModelView:SetModel("models/smalls_civilians/pack2/male/baseballtee/male_01_baseballtee_pm.mdl")
            modelSelected = 7
        end
        if (index == 8) then
            ModelView:SetModel("models/smalls_civilians/pack2/male/flannel/male_02_flannel_pm.mdl")
            modelSelected = 8
        end
        if (index == 9) then
            ModelView:SetModel("models/smalls_civilians/pack2/male/leatherjacket/male_03_leather_jacket_pm.mdl")
            modelSelected = 9
        end
        if (index == 10) then
            ModelView:SetModel("models/smalls_civilians/pack2/male/hoodie_jeans/male_04_hoodiejeans_pm.mdl")
            modelSelected = 10
        end
        if (index == 11) then
            ModelView:SetModel("models/smalls_civilians/pack2/male/hoodie_sweatpants/male_05_hoodiesweatpants_pm.mdl")
            modelSelected = 11
        end
        if (index == 12) then
            ModelView:SetModel("models/smalls_civilians/pack2/male/jacket_open/male_06_jacketopen_pm.mdl")
            modelSelected = 12
        end
        if (index == 13) then
            ModelView:SetModel("models/smalls_civilians/pack2/male/jacketvneck_sweatpants/male_07_jacketvneck_sweatpants_pm.mdl")
            modelSelected = 13
        end
        if (index == 14) then
            ModelView:SetModel("models/smalls_civilians/pack2/male/hoodie_jeans/male_08_hoodiejeans_pm.mdl")
            modelSelected = 14
        end
        if (index == 15) then
            ModelView:SetModel("models/smalls_civilians/pack2/male/flannel/male_09_flannel_pm.mdl")
            modelSelected = 15
        end
    end

    local buttoncancel = vgui.Create("DButton", DFrame)
	buttoncancel:SetSize(75,30)
	buttoncancel:SetPos(20, (ScrH()/4 - 40))
	buttoncancel:SetText("Cancel")
	buttoncancel.DoClick = function()
        DFrame:Close()
    end

    local buttonApply = vgui.Create("DButton", DFrame)
	buttonApply:SetSize(110,30)
	buttonApply:SetPos(xsize-130, (ScrH()/4 - 40))
	buttonApply:SetText("Apply New Model")
	buttonApply.DoClick = function()
        if (charModel == "") then
            DFrame:Close()
        else
            net.Start("visl_CharacterModelChange")
            net.WriteUInt(modelSelected, 5)
            net.SendToServer()
        end
        DFrame:Close()
    end
end
concommand.Add("changeCharacterModel", changeCharacterModel)
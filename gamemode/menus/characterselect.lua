-- function isNumberInString(string)
--     for c in string.gmatch("sentence",".") do 
--         b = tonumber(c)
--         if (b != nil) then
--             return true
--         end
--     end
--     return false
-- end

function characterSelect()
    local modelSelected = ""
    local charName = ""
    local charDesc = ""
    local ply = LocalPlayer()

    local DFrame = vgui.Create( "DFrame" )
    xsize = ScrW()/3
    ysize = ScrH()/3
    DFrame:SetSize( xsize, ysize ) -- Set the size of the panel
    DFrame:Center()
    DFrame:MakePopup()
    DFrame:ShowCloseButton(false)
    DFrame:SetTitle("VislRP Character Selection")
    DFrame:SetDraggable(false)
    DFrame.Paint = function()
        surface.SetDrawColor(50,50,50,230)
        surface.DrawRect(0,0,DFrame:GetWide(), DFrame:GetTall())

        surface.SetDrawColor(20,20,20,255)
        surface.DrawRect(0,24,DFrame:GetWide(), 1)
        draw.DrawText("Enter your desired Character Name:", "DermaDefaultBold", 110, 60, Color(255,255,255,255), 1)
        draw.DrawText("Enter your desired Character Description:", "DermaDefaultBold", 125, 140, Color(255,255,255,255), 1)
        draw.DrawText("Choose your desired look: \n(You may look different for certain jobs)", "DermaDefaultBold", 125, 220, Color(255,255,255,255), 1)
    end
    
    local NameInput = vgui.Create( "DTextEntry", DFrame)
    NameInput:SetUpdateOnType(true)
    NameInput:SetSize(200,20)
    NameInput:SetPos(10,80)
    NameInput.OnValueChange = function()
        charName = NameInput:GetValue()
    end

    local DescriptionInput = vgui.Create( "DTextEntry", DFrame)
    DescriptionInput:SetUpdateOnType(true)
    DescriptionInput:SetSize(230,20)
    DescriptionInput:SetPos(10,160)
    DescriptionInput.OnValueChange = function()
        charDesc = DescriptionInput:GetValue()
    end

    local ModelView = vgui.Create("DModelPanel", DFrame)
    ModelView:SetSize(300,300)
    ModelView:SetPos(275,40)
    ModelView:SetFOV(55)
    ModelView:SetCamPos(ModelView:GetCamPos() + Vector(0,0,15))
    function ModelView:LayoutEntity(ent) return end

    local DComboBox = vgui.Create("DComboBox", DFrame)
    DComboBox:SetPos(10, 255)
    DComboBox:SetSize(250, 20)
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


    local buttondone = vgui.Create("DButton", DFrame)
	buttondone:SetSize(75,30)
	buttondone:SetPos(10, (ScrH()/3 - 40))
	buttondone:SetText("I'm Done")
	buttondone.DoClick = function()
        if (charName == "" and charDesc == "") then
            notification.AddLegacy("Please Enter a Character Name and Description.", NOTIFY_ERROR,5)
            NameInput:SetValue("")
            DescriptionInput:SetValue("")
            return
        end
        if (charName == "") then
            notification.AddLegacy("Please Enter a Character Name.", NOTIFY_ERROR,5)
            NameInput:SetValue("")
            return
        end
        if (charDesc == "") then
            notification.AddLegacy("Please Enter a Character Description.", NOTIFY_ERROR,5)
            DescriptionInput:SetValue("") 
            return
        end
        if (string.len(tostring(charName)) > 24) then
            notification.AddLegacy("The maximum length for a name is 24 characters", NOTIFY_ERROR,5)
            charName = ""
            NameInput:SetValue("")
            return
        end

        if (string.len(tostring(charDesc)) > 50) then
            notification.AddLegacy("The maximum length for a description is 50 characters", NOTIFY_ERROR,5)
            charDesc = ""
            DescriptionInput:SetValue("")
            return
        end

        if (string.len(tostring(charName)) < 5) then 
            notification.AddLegacy("The Character Name has to be atleast 5 Characters long", NOTIFY_ERROR,5)
            charName = ""
            NameInput:SetValue("")
            return
        end

        if (string.len(tostring(charDesc)) <= 10) then 
            notification.AddLegacy("The Character Description has to be atleast 10 Characters long", NOTIFY_ERROR,5)
            charDesc = ""
            DescriptionInput:SetValue("")
            return
        end

        if (charModel == "") then 
            notification.AddLegacy("You need to select a Character Model", NOTIFY_ERROR,5)
            charModel = ""
            return
        end
        
        -- if (isNumberInString(tostring(charName))) then
        --     notification.AddLegacy("The Character Name should not contain any numbers", NOTIFY_ERROR,5)
        --     charName = ""
        --     NameInput:SetValue("")
        --     return
        -- end

        -- if (isNumberInString(tostring(charDesc))) then
        --     notification.AddLegacy("The Character Description should not contain any numbers", NOTIFY_ERROR,5)
        --     charDesc = ""
        --     DescriptionInput:SetValue("")
        --     return
        -- end
        if (!isnumber(modelSelected)) then return end


        net.Start("visl_CharacterCreationInformation")
        net.WriteString(charName)
        net.WriteString(charDesc)
        net.WriteUInt(modelSelected, 5)
        net.SendToServer()
        
		DFrame:Close()
    end
end
net.Receive("visl_OpenCharacterMenu", characterSelect)
--ply:IsUserGroup("mod")
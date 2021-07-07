function changeCharacterInformation()
    local ply = LocalPlayer()
    local oldName = ply:GetNWString("charName")
    local oldDesc = ply:GetNWString("charDesc")
    local charName = ""
    local charDesc = ""

    local DFrame = vgui.Create( "DFrame" )
    xsize = ScrW()/4
    ysize = ScrH()/5
    DFrame:SetSize( xsize, ysize ) -- Set the size of the panel
    DFrame:Center()
    DFrame:MakePopup()
    DFrame:ShowCloseButton(true)
    DFrame:SetTitle("VislRP Character Information")
    DFrame:SetDraggable(false)
    DFrame.Paint = function()
        surface.SetDrawColor(50,50,50,230)
        surface.DrawRect(0,0,DFrame:GetWide(), DFrame:GetTall())

        surface.SetDrawColor(20,20,20,255)
        surface.DrawRect(0,24,DFrame:GetWide(), 1)
        draw.DrawText("If you wish not to change name/description, leave the box blank", "DermaDefaultBold", 188, 40, Color(255,0,0,255), 1)
        draw.DrawText("Enter your new desired Character Name:", "DermaDefaultBold", 120, 70, Color(255,255,255,255), 1)
        draw.DrawText("Enter your new desired Character Description:", "DermaDefaultBold", 135, 130, Color(255,255,255,255), 1)
    end

    local NameInput = vgui.Create( "DTextEntry", DFrame)
    NameInput:SetUpdateOnType(true)
    NameInput:SetSize(200,20)
    NameInput:SetPos(10,90)
    NameInput:SetPlaceholderText("Enter your new name here")
    --NameInput:SetValue(oldName)
    NameInput.OnValueChange = function()
        charName = NameInput:GetValue()
    end

    local DescriptionInput = vgui.Create( "DTextEntry", DFrame)
    DescriptionInput:SetUpdateOnType(true)
    DescriptionInput:SetSize(230,20)
    DescriptionInput:SetPos(10,150)
    --DescriptionInput:SetValue(oldDesc)
    DescriptionInput:SetPlaceholderText("Enter your new description here")
    DescriptionInput.OnValueChange = function()
        charDesc = DescriptionInput:GetValue()
    end

    local buttondone = vgui.Create("DButton", DFrame)
	buttondone:SetSize(75,30)
	buttondone:SetPos(xsize-85, (ScrH()/5 - 40))
	buttondone:SetText("I'm Done")
	buttondone.DoClick = function()
        if (string.len(tostring(charName)) > 24) then
            notification.AddLegacy("The maximum length for a name is 24 characters", NOTIFY_ERROR,5)
            --NameInput:SetValue(oldName)
            return
        end

        if (string.len(tostring(charDesc)) > 50) then
            notification.AddLegacy("The maximum length for a description is 50 characters", NOTIFY_ERROR,5)
            --DescriptionInput:SetValue(oldDesc)
            return
        end

        if (tostring(charName) != "" and string.len(tostring(charName)) < 5) then 
            notification.AddLegacy("The Character Name has to be atleast 5 Characters long", NOTIFY_ERROR,5)
            --NameInput:SetValue(oldName)
            return
        end

        if (tostring(charDesc) != "" and string.len(tostring(charDesc)) <= 10) then 
            notification.AddLegacy("The Character Description has to be atleast 10 Characters long", NOTIFY_ERROR,5)
            --DescriptionInput:SetValue(oldDesc)
            return
        end

        if (charName == "" and charDesc == "") then
            net.Start("visl_CharacterInformationChange")
            net.WriteString(oldName)
            net.WriteString(oldDesc)
            net.SendToServer()
        elseif (charName == "") then
            net.Start("visl_CharacterInformationChange")
            net.WriteString(oldName)
            net.WriteString(charDesc)
            net.SendToServer()
        elseif (charDesc == "") then
            net.Start("visl_CharacterInformationChange")
            net.WriteString(charName)
            net.WriteString(oldDesc)
            net.SendToServer()
        else
            net.Start("visl_CharacterInformationChange")
            net.WriteString(charName)
            net.WriteString(charDesc)
            net.SendToServer()
        end
        DFrame:Close()
    end

    local buttoncancel = vgui.Create("DButton", DFrame)
	buttoncancel:SetSize(75,30)
	buttoncancel:SetPos(xsize-175, (ScrH()/5 - 40))
	buttoncancel:SetText("Cancel")
	buttoncancel.DoClick = function()
        DFrame:Close()
    end
end
concommand.Add("changeCharacterInformation", changeCharacterInformation)
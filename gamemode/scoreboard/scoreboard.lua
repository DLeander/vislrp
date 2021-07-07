local ScoreboardDerma = nil
local PlayerList = nil

-- function GM:ScoreboardShow()
--     if (!IsValid(ScoreboardDerma)) then

--         surface.CreateFont( "ScoreboardFont", {
--             font = "DermaDefault", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
--             extended = false,
--             size = 20,
--             weight = 1000,
--             blursize = 0,
--             scanlines = 0,
--             antialias = true,
--             underline = false,
--             italic = false,
--             strikeout = true,
--             symbol = false,
--             rotary = false,
--             shadow = true,
--             additive = true,
--             outline = true,
--         } )

--         ScoreboardDerma = vgui.Create("DFrame")
--         ScoreboardDerma:SetSize(ScrW()/2,ScrH()/1.4)
--         ScoreboardDerma:Center()
--         ScoreboardDerma:SetTitle("VislRP Player List")
--         ScoreboardDerma:SetDraggable(false)
--         ScoreboardDerma:ShowCloseButton(false)
--         ScoreboardDerma.Paint = function()
--             draw.RoundedBox(5,0,0,ScoreboardDerma:GetWide(), ScoreboardDerma:GetTall(), Color(60,60,60,200))
--         end

--         local PlayerScrollPanel = vgui.Create("DScrollPanel", ScoreboardDerma)
--         PlayerScrollPanel:SetSize(ScoreboardDerma:GetWide(), ScoreboardDerma:GetTall() - 20)
--         PlayerScrollPanel:SetPos(0,20)

--         PlayerList = vgui.Create("DListLayout", PlayerScrollPanel)
--         PlayerList:SetSize(PlayerScrollPanel:GetWide(), PlayerScrollPanel:GetTall())
--         PlayerList:SetPos(0,0)
--     end
--     if (IsValid(ScoreboardDerma)) then
--         PlayerList:Clear()
--         for k,v in pairs(player.GetAll()) do
--             local plyClass = PLAYER_CLASSES[v:GetNWInt("playerJob")]
--             local PlayerPanel = vgui.Create("DPanel", PlayerList)
--             PlayerPanel:SetSize(PlayerList:GetWide(), 50)
--             PlayerPanel:SetPos(0,0)
--             PlayerPanel.Paint = function()
--                 draw.RoundedBox(0,0,0,PlayerPanel:GetWide(), PlayerPanel:GetTall(), Color(plyClass.color[1],plyClass.color[2],plyClass.color[3],200))
--                 draw.RoundedBox(0,0,49, PlayerPanel:GetWide(), 1, Color(255,255,255,255))

--                 draw.SimpleText("\t\t\t\t[".. plyClass.name.."]\t"..v:GetName().." (" .. v:GetNWString("charName")..")", "ScoreboardFont", 10, 14)
--                 draw.SimpleText("Rank: ", "DermaDefault", PlayerList:GetWide() - 20, 10, Color(255,255,255), TEXT_ALIGN_RIGHT)
--                 draw.SimpleText("Kills: "..v:Frags(), "DermaDefault", PlayerList:GetWide() - 20, 25, Color(255,255,255), TEXT_ALIGN_RIGHT)
--             end

--             local Avatar = vgui.Create( "AvatarImage", ScoreboardDerma )
--             Avatar:SetSize( 48, 48 )
--             Avatar:SetPos( 8, 21 )
--             Avatar:SetPlayer( v, 64 )
--         end
--     end
-- end

function GM:ScoreboardShow()
    surface.CreateFont( "ScoreboardFont", {
    font = "DermaDefault", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
    extended = false,
    size = 20,
    weight = 1000,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
            italic = false,
            strikeout = true,
            symbol = false,
            rotary = false,
            shadow = true,
            additive = true,
            outline = true,
        } )

    ScoreboardDerma = vgui.Create("DFrame")
    ScoreboardDerma:SetSize(ScrW()/2,ScrH()/1.4)
    ScoreboardDerma:Center()
    ScoreboardDerma:SetTitle("VislRP Player List")
    ScoreboardDerma:SetDraggable(false)
    ScoreboardDerma:ShowCloseButton(false)
    ScoreboardDerma.Paint = function()
        draw.RoundedBox(5,0,0,ScoreboardDerma:GetWide(), ScoreboardDerma:GetTall(), Color(60,60,60,200))
    end

    local PlayerScrollPanel = vgui.Create("DScrollPanel", ScoreboardDerma)
    PlayerScrollPanel:SetSize(ScoreboardDerma:GetWide(), ScoreboardDerma:GetTall() - 20)
    PlayerScrollPanel:SetPos(0,20)

    PlayerList = vgui.Create("DListLayout", PlayerScrollPanel)
    PlayerList:SetSize(PlayerScrollPanel:GetWide(), PlayerScrollPanel:GetTall())
    PlayerList:SetPos(0,0)

    PlayerList:Clear()
    for k,v in pairs(player.GetAll()) do

        if v:IsValid() == false then return end

        local plyClass = PLAYER_CLASSES[v:GetNWInt("playerJob")]
        local PlayerPanel = vgui.Create("DPanel", PlayerList)
        PlayerPanel:SetSize(PlayerList:GetWide(), 49)
        PlayerPanel:SetPos(0,0)
        PlayerPanel.Paint = function()
            draw.RoundedBox(0,0,0,PlayerPanel:GetWide(), PlayerPanel:GetTall(), Color(plyClass.color[1],plyClass.color[2],plyClass.color[3],200))
            draw.RoundedBox(0,0,48, PlayerPanel:GetWide(), 1, Color(255,255,255,255))

            draw.SimpleText("\t\t\t\t[".. plyClass.name.."]\t"..v:GetName().." (" .. v:GetNWString("charName")..")".." ["..tostring(v:UserID()).."]", "ScoreboardFont", 10, 14)
            draw.SimpleText("Rank: "..v:GetUserGroup(), "DermaDefault", PlayerList:GetWide() - 20, 10, Color(255,255,255), TEXT_ALIGN_RIGHT)
            draw.SimpleText("Kills: "..v:Frags(), "DermaDefault", PlayerList:GetWide() - 20, 25, Color(255,255,255), TEXT_ALIGN_RIGHT)
        end


        local Avatar = vgui.Create( "AvatarImage", PlayerPanel )
        Avatar:SetSize( 48, 48 )
        Avatar:SetPos( 8, 0 )
        Avatar:SetPlayer( v, 48 )
    end
end

function GM:ScoreboardHide()
    if (IsValid(ScoreboardDerma)) then
        ScoreboardDerma:Hide()
    end
end
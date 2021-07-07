AddCSLuaFile("../database/cl_database.lua")

include("../config/custom_classes.lua")
include("../database/cl_database.lua")
include("../database/items.lua")

local menu
local ply
local plyClass

local function openF4Menu()
    ply = LocalPlayer()
    -- if(IsValid(menu)) then
    --     menu:Show()
    -- else
    menu = vgui.Create("F4Menu")
    local characterPanel = vgui.Create("CharacterPanel", menu)
    menu:AddSheet("Character", characterPanel, "icon16/group.png")
    local marketPanel = vgui.Create("MarketPanel", menu)
    menu:AddSheet("Market", marketPanel, "icon16/basket.png")
    local inventoryPanel = vgui.Create("InventoryPanel", menu)
    menu:AddSheet("Inventory", inventoryPanel, "icon16/box.png")
    -- end
end
concommand.Add("open_f4_menu", openF4Menu)

local PANEL = {}
function PANEL:Init()
    --self:StretchToParent(100,100,100,100)
    self:SetSize(ScrW()/1.521, ScrH()/1.5)
    self:Center()
    self:MakePopup()
    self:SetupCloseButton(function ()
        self:Close()
    end)
    self:ParentToHUD()
end

function PANEL:SetupCloseButton(func)
    self.CloseButton = self.tabScroller:Add("DButton")
    self.CloseButton:SetText("")
    self.CloseButton.DoClick = func

    self.CloseButton.Paint = function(panel, w, h)
        derma.SkinHook("Paint", "WindowCloseButton", panel, w, h)
    end
    self.CloseButton:Dock(RIGHT)
    self.CloseButton:DockMargin(0,0,0,8)
    self.CloseButton:SetSize(32,32)
end

function PANEL:Show()
    self:SetVisible(true)
end

function PANEL:Hide()
    self:SetVisible(false)
end

function PANEL:Close()
    self:Hide()
end
vgui.Register("F4Menu", PANEL, "DPropertySheet")

PANEL = {}
function PANEL:Init()
    local categoryList = vgui.Create("DCategoryList", self)
    categoryList:Dock(FILL)

    for categoryName, categoryTbl in SortedPairs(MARKETTABLE.MarketItems) do
        local collapsibleCategory = vgui.Create("DCollapsibleCategory", categoryList)
        collapsibleCategory:SetLabel(categoryName)

        local iconLayout = vgui.Create("DIconLayout", collapsibleCategory)
        collapsibleCategory:SetContents(iconLayout)

        for itemName, itemTbl in SortedPairsByMemberValue(categoryTbl, "Price") do
            local model = itemTbl.Model
            local price = itemTbl.Price
            local jobrequirement = itemTbl.JobRequirement
            
            local icon = vgui.Create("SpawnIcon", iconLayout)
            icon:SetModel(model)
            icon:SetToolTip(itemName.."\nPrice: ".. price.."\n Job Requirement: ".. jobrequirement)
            icon.DoClick = function()
                RunConsoleCommand("buy_item", categoryName, itemName)
            end
        end
    end
end
vgui.Register("MarketPanel", PANEL, "DPanel")

PANEL = {}
function PANEL:Init()
    local plyClass = PLAYER_CLASSES[ply:GetNWInt("playerJob")]

    local categoryList = vgui.Create("DPanel", self)
    categoryList:Dock(FILL)
    surface.CreateFont( "CharacterMenuFont", {
        font = "DermaDefaultBold", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
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
        shadow = false,
        additive = false,
        outline = false,
    } )
    
    local charNameLabel = vgui.Create( "DLabel", self)
	charNameLabel:Dock( TOP )
    charNameLabel:SetFont("CharacterMenuFont")
	charNameLabel:DockMargin( 7, 0, 0, 0 ) -- shift to the right
	charNameLabel:SetColor( color_black )
	charNameLabel:SetText( "Character Name: "..ply:GetNWString("charName") )

    local charDescLabel = vgui.Create( "DLabel", self)
	charDescLabel:Dock( TOP )
	charDescLabel:DockMargin( 7, 0, 0, 0 ) -- shift to the right
	charDescLabel:SetColor( color_black )
	charDescLabel:SetText( "Character Description: "..ply:GetNWString("charDesc") )

    local jobLabel = vgui.Create( "DLabel", self)
	jobLabel:Dock( TOP )
	jobLabel:DockMargin( 7, 0, 0, 0 ) -- shift to the right
	jobLabel:SetColor( color_black )
    jobLabel:SetText( "Current Job: " .. plyClass.name )

    local balLabel = vgui.Create( "DLabel", self)
	balLabel:Dock( TOP )
	balLabel:DockMargin( 7, 0, 0, 0 ) -- shift to the right
	balLabel:SetColor( color_black )
    balLabel:SetText( "Total Balance: "..ply:GetNWString("playerMoney").."$" )

    local salaryLabel = vgui.Create( "DLabel", self)
	salaryLabel:Dock( TOP )
	salaryLabel:DockMargin( 7, 0, 0, 0 ) -- shift to the right
	salaryLabel:SetColor( color_black )
    salaryLabel:SetText( "Current Salary: "..plyClass.salary.."$" )

    local ModelView = vgui.Create("DModelPanel", self)
    ModelView:SetSize(200,100)
    ModelView:SetPos(275,0)
    ModelView:SetModel(ply:GetModel())
    ModelView:SetFOV(25)
    ModelView:SetCamPos(ModelView:GetCamPos() + Vector(0,0,15))
    ModelView:SetLookAt( Vector(0,0,61) )
    function ModelView:LayoutEntity(ent) return end

    local buttonChange = vgui.Create("DButton", self)
	buttonChange:SetSize(155,30)
	buttonChange:SetPos(600, 55)
	buttonChange:SetText("Change Character Information")
	buttonChange.DoClick = function()
        menu:Close()
        ply:ConCommand("changeCharacterInformation")
    end

    local buttonChangeModel = vgui.Create("DButton", self)
	buttonChangeModel:SetSize(155,30)
	buttonChangeModel:SetPos(600, 15)
	buttonChangeModel:SetText("Change Character Model")
	buttonChangeModel.DoClick = function()
        menu:Close()
    end

    local jobPanel = vgui.Create("DIconLayout", self)
    jobPanel:Dock( FILL )
    jobPanel:SetPos(20, 115)
    jobPanel:GetSpaceY(5)
    jobPanel:GetSpaceX(5)
    local spacing = jobPanel:Add("DPanel")
    spacing:SetSize(ScrW(), 7)
    --spacing:SetBackgroundColor(Color(155,155,155,150))
    spacing.Paint = function()
        draw.RoundedBox(0,0,0,spacing:GetWide(), spacing:GetTall(), Color(155,155,155,150))
    end
    for k,v in pairs(PLAYER_CLASSES) do
        local listJob = jobPanel:Add( "DPanel" ) -- Add DPanel to the DIconLayout
        listJob:SetSize(ScrW()/1.525, 45)
        listJob.Paint = function()
            surface.SetDrawColor(Color(PLAYER_CLASSES[k].color[1], PLAYER_CLASSES[k].color[2], PLAYER_CLASSES[k].color[3]))
            surface.DrawRect( 0, 40, ScrW()/1.525, 5)
            draw.RoundedBox(0,0,0,listJob:GetWide(), listJob:GetTall()-5, Color(220,220,220,255))

        end
        local becomeJob = vgui.Create("DButton", listJob)
        becomeJob:SetSize(75,20)
        becomeJob:SetPos((ScrW()/1.52-75)-30, 25/2)
        becomeJob:SetText("Become Job")
        becomeJob.DoClick = function()
            if plyClass.name == PLAYER_CLASSES[k].name then
                notification.AddLegacy("You can not become your current job", NOTIFY_ERROR,5)
            elseif PLAYER_CLASSES[k].currentplayers == PLAYER_CLASSES[k].maxplayers then
                notification.AddLegacy("This job is currently full", NOTIFY_ERROR,5)
            else
                plyClass.currentplayers = plyClass.currentplayers - 1
                ply:ConCommand("player_set_job "..tostring(k))
                PLAYER_CLASSES[k].currentplayers = PLAYER_CLASSES[k].currentplayers + 1
                menu:Close()
            end
        end


        --ListJob:SetBackgroundColor(Color(PLAYER_CLASSES[k].color[1], PLAYER_CLASSES[k].color[2], PLAYER_CLASSES[k].color[3]))
    end

    --[[PlayerPanel.Paint = function()
        draw.RoundedBox(0,0,0,PlayerPanel:GetWide(), PlayerPanel:GetTall(), Color(plyClass.color[1],plyClass.color[2],plyClass.color[3],200))
        draw.RoundedBox(0,0,49, PlayerPanel:GetWide(), 1, Color(255,255,255,255))

        draw.SimpleText(v:GetName().. "\t " .. "Job: ".. plyClass.name, "DermaDefault", 20, 10)
        draw.SimpleText("$ "..v:GetNWInt("playerMoney"), "DermaDefault", 20, 25)
        draw.SimpleText("Rank: ", "DermaDefault", PlayerList:GetWide() - 20, 10, Color(255,255,255), TEXT_ALIGN_RIGHT)
        draw.SimpleText("Kills: "..v:Frags(), "DermaDefault", PlayerList:GetWide() - 20, 25, Color(255,255,255), TEXT_ALIGN_RIGHT)
    end--]]

end
vgui.Register("CharacterPanel", PANEL, "DPanel")

PANEL = {}
function PANEL:Init()
    local categoryList = vgui.Create("DCategoryList", self)
    categoryList:Dock(FILL)

    local w = 506  
    local h = 512
    local padding = 4
    local inventory = inventoryTable()

    for k, v in pairs(itemCategories) do
        local category = categoryList:Add( v )
        local items = vgui.Create("DPanelList",self)
        for k2,v2 in pairs(inventory) do
            local i = getItems(k2)
            if i then
                if(v == i.category) then
                    items:SetPos(padding, padding+21)
                    items:SetSize(w-32 - padding*2, h-48-padding*2)
                    items:EnableVerticalScrollbar(true)
                    items:EnableHorizontal(true)
                    items:SetPadding(padding)
                    items:SetSpacing(padding)

                    local buttons = {}
                    buttons["use"] = (function()
                        inventoryUse(k2)
                        menu:Close()
                    end)

                    buttons["drop"] = (function()
                        inventoryDrop(k2)
                        menu:Close()
                    end)

                    local b = inventoryItemButton(k2, i.name .. "(" .. v2.amount .. ")", v2.amount, i.desc, i.model, items, i.buttonDist, buttons)
                    items:AddItem(b)
                    category:SetContents(items)
                end
            end
        end
    end
end
vgui.Register("InventoryPanel", PANEL, "DPanel")
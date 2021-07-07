local menu
local ply
local plyClass
local lawtable = {}

local function openF4Menu()
    ply = LocalPlayer()

    menu = vgui.Create("F4Menu")
    local characterPanel = vgui.Create("CharacterPanel", menu)
    menu:AddSheet("Character", characterPanel, "icon16/group.png")

    local marketPanel = vgui.Create("MarketPanel", menu)
    menu:AddSheet("Market", marketPanel, "icon16/basket.png")

    local inventoryPanel = vgui.Create("InventoryPanel", menu)
    menu:AddSheet("Inventory", inventoryPanel, "icon16/box.png")

    local lawsPanel = vgui.Create("LawsPanel", menu)
    menu:AddSheet("Laws", lawsPanel, "icon16/error.png")

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
    local plyClass = PLAYER_CLASSES[ply:GetNWInt("playerJob")]
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
            if jobrequirement == "none" then
                icon:SetToolTip(itemTbl.Name.."\nPrice: ".. price)
            else
                icon:SetToolTip(itemTbl.Name.."\nPrice: ".. price.."\n Job Requirement: ".. jobrequirement)
            end
            icon.DoClick = function()
                if jobrequirement == "none" then
                    if ply:CanAfford(price) then
                        net.Start("visl_inventory_purchase")
                        net.WriteBool(itemTbl.isSpawned)
                        net.WriteString(model)
                        net.WriteString(itemName)
                        net.WriteString(categoryName)
                        net.SendToServer()
                        menu:Close()
                    else
                        notification.AddLegacy("You do not have enough money to purchase this.", NOTIFY_ERROR,5)
                    end
                elseif plyClass.name == jobrequirement then
                    if ply:CanAfford(price) then
                        net.Start("visl_inventory_purchase")
                        net.WriteString(itemName)
                        net.WriteString(categoryName)
                        net.SendToServer()
                        menu:Close()
                    else
                        notification.AddLegacy("You do not have enough money to purchase this.", NOTIFY_ERROR,5)
                    end
                else
                    notification.AddLegacy("You do not have the right job to purchase this.", NOTIFY_ERROR,5)
                end
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

    local salaryLabel = vgui.Create( "DLabel", self)
	salaryLabel:Dock( TOP )
	salaryLabel:DockMargin( 7, 0, 0, 0 ) -- shift to the right
	salaryLabel:SetColor( color_black )
    salaryLabel:SetText( "" )

    local ModelView = vgui.Create("DModelPanel", self)
    ModelView:SetSize(200,120)
    ModelView:SetPos(295,1)
    ModelView:SetModel(ply:GetModel())
    ModelView:SetFOV(28)
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
        ply:ConCommand("changeCharacterModel")
    end

    local padding = 4
    local w = 506  
    local h = 512

    local categoryJobList = vgui.Create("DCategoryList", categoryList)
    categoryJobList:Dock(FILL)

    for k1, v2 in pairs(PLAYER_CLASSES_CATEGORIES) do
        local amountofjobs = 0
        local category = categoryJobList:Add( v2 )
        local jobPanel = vgui.Create("DPanel", category)
        jobPanel:SetSize(ScrW()/1.525, 45)
        --jobPanel:SetPos(-30,0)
        --jobPanel:SetBackgroundColor(220,220,220)
        --local listJob = vgui.Create("DPanelList", category)

        for k,v in pairs(PLAYER_CLASSES) do
            if PLAYER_CLASSES[k].category == v2 then
                local listJob = vgui.Create("DPanelList", jobPanel)
                listJob:SetSize(ScrW()/1.525, 45)
                listJob.Paint = function()
                    draw.RoundedBox(0,0,listJob:GetTall()-5,listJob:GetWide(), 5, Color(PLAYER_CLASSES[k].color[1], PLAYER_CLASSES[k].color[2], PLAYER_CLASSES[k].color[3]))
                    --draw.RoundedBox(0,0,0,listJob:GetWide(), listJob:GetTall()-5, Color(220,220,220,255))
                    draw.DrawText(PLAYER_CLASSES[k].name, "DermaDefault", 5, 25/2, Color(0,0,0,255))
                    draw.DrawText("Salary: " .. PLAYER_CLASSES[k].salary .. "$", "DermaDefault", 200, 25/2, Color(0,0,0,255))
                    if PLAYER_CLASSES[k].name != "Citizen" then
                        draw.DrawText(tostring(countPlayersInJob(k)) .. "/" .. tostring(PLAYER_CLASSES[k].maxplayers), "DermaDefault", ScrW()/1.52-65, 25/2, Color(0,0,0,255))
                    else
                        draw.DrawText("∞", "DermaDefault", ScrW()/1.52-65, 25/2, Color(0,0,0,255))
                    end
                    --draw.DrawText( string text, string font = "DermaDefault", number x = 0, number y = 0, table color = Color( 255, 255, 255, 255 ), number xAlign = TEXT_ALIGN_LEFT )
                end
                listJob:SetPos(0, 45*amountofjobs)

                local becomeJob = vgui.Create("DButton", listJob)
                becomeJob:SetSize(75,20)
                becomeJob:SetPos((ScrW()/1.52-75)-75, 25/2)
                becomeJob:SetText("Become Job")
                becomeJob.DoClick = function()
                    if plyClass.name == PLAYER_CLASSES[k].name then
                        notification.AddLegacy("You can not become your current job", NOTIFY_ERROR,5)
                    elseif countPlayersInJob(k) >= PLAYER_CLASSES[k].maxplayers then
                        notification.AddLegacy("This job is currently full", NOTIFY_ERROR,5)
                    else
                        plyClass.currentplayers = plyClass.currentplayers - 1
                        ply:ConCommand("player_set_job "..tostring(k))
                        PLAYER_CLASSES[k].currentplayers = PLAYER_CLASSES[k].currentplayers + 1
                        menu:Close()
                    end
                end
                amountofjobs = amountofjobs + 1
                --listJob:AddItem(becomeJob)
                --category:SetContents(jobPanel)
            end
        end
        category:SetContents(jobPanel)
        jobPanel:SetSize(ScrW()/1.525, 45 * amountofjobs)
        --jobPanel:SetSize(w-32 - padding,(h-48-padding*2) + ((h-48-padding) * amountofjobs))
    end

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
    categoryList:SetPos(0,20)

    local DProgress = vgui.Create( "DProgress", categoryList )
    DProgress:SetPos(0, 0)
    DProgress:SetSize( menu:GetWide(), 15 )
    DProgress:SetFraction( getCurrentInvSize() / ply:GetNWInt("visl_max_invsize") )

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

PANEL = {}
function PANEL:Init()
    surface.CreateFont( "LawMessageFont", {
        font = "DermaDefaultBold", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
        extended = false,
        size = 25,
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

    surface.CreateFont( "LawsFont", {
        font = "DermaDefaultBold", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
        extended = false,
        size = 20,
        weight = 1000,
        blursize = 0,
        scanlines = 0,
        antialias = true,
        underline = false,
        italic = true,
        strikeout = true,
        symbol = false,
        rotary = false,
        shadow = false,
        additive = false,
        outline = false,
    } )
    local lawList = vgui.Create("DScrollPanel", self)
    lawList:Dock(FILL)

    local lawMessage = vgui.Create( "DLabel", lawList)
    lawMessage:SetPos( 15, 10 )
    lawMessage:SetSize(1800, 25)
    --lawMessage:Center()
    lawMessage:SetTextColor(Color(0,0,0))
    lawMessage:SetFont("LawMessageFont")
    lawMessage:SetText("The current laws issued by the governor:")
    
    for k,v in pairs(lawtable) do
        local lawLabel = vgui.Create( "DLabel", lawList)
        lawLabel:SetPos( 15, 45*k )
        lawLabel:SetTextColor(Color(0,0,0))
        lawLabel:SetSize(1800, 20)
        lawLabel:SetFont("LawsFont")
        lawLabel:SetText(tostring(k)..". "..tostring(v))
    end

end
vgui.Register("LawsPanel", PANEL, "DPanel")

net.Receive("visl_SyncLaws",function()
    lawtable = net.ReadTable()
end)
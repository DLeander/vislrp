itemCategories = {"Food and Drinks", "Clothing", "Weapons", "Melee Weapons", "Storage", "Illegalities"}

local items = {}

governmental_jobs = {1,2,3,4,5,6,7}

function getItems(name)
    if items[name] then
        return items[name]
    end
    return false
end
--FOODS
items["energydrink"] =    {
                        name = "Energy Drink",
                        desc = "Cold and refreshing",
                        ent = "item_basic",
                        model = "models/props_junk/PopCan01a.mdl",
                        use = (function(ply, ent)
                            if ply:IsValid() then
                                ply:SetNWInt("visl_hunger", ply:GetNWInt("visl_hunger") + 10)
                                if ply:GetNWInt("visl_hunger") > 100 then
                                    ply:SetNWInt("visl_hunger", 100)
                                end
                                if ent then
                                    ent:Remove()
                                end
                            end
                        end),
                        spawn = (function(ply, ent)
                            ent:SetItemName("energydrink")
                        end),
                        skin = 0,
                        space = 1,
                        category = "Food and Drinks",
                        buttonDist = 32,                
                    }

items["popsoda"] =    {
                        name = "Pop Soda",
                        desc = "Coke rip-off",
                        ent = "item_basic",
                        model = "models/props_junk/PopCan01a.mdl",
                        use = (function(ply, ent)
                            if ply:IsValid() then
                                ply:SetNWInt("visl_hunger", ply:GetNWInt("visl_hunger") + 10)
                                if ply:GetNWInt("visl_hunger") > 100 then
                                    ply:SetNWInt("visl_hunger", 100)
                                end
                                if ent then
                                    ent:Remove()
                                end
                            end
                        end),
                        spawn = (function(ply, ent)
                            ent:SetItemName("popsoda")
                        end),
                        skin = 1,
                        space = 1,
                        category = "Food and Drinks",
                        buttonDist = 32,                
                    }  
                    
items["watermelon"] =    {
                        name = "Watermelon",
                        desc = "A tasty watermelon",
                        ent = "item_basic",
                        model = "models/props_junk/watermelon01.mdl",
                        use = (function(ply, ent)
                            if ply:IsValid() then
                                ply:SetNWInt("visl_hunger", ply:GetNWInt("visl_hunger") + 15)
                                if ply:GetNWInt("visl_hunger") > 100 then
                                    ply:SetNWInt("visl_hunger", 100)
                                end
                                if ent then
                                    ent:Remove()
                                end
                            end
                        end),
                        spawn = (function(ply, ent)
                            ent:SetItemName("watermelon")
                        end),
                        skin = 1,
                        space = 2,
                        category = "Food and Drinks",
                        buttonDist = 32,                
                    }

items["takeoutbox"] =    {
                        name = "Takeout Box",
                        desc = "Noodles!",
                        ent = "item_basic",
                        model = "models/props_junk/garbage_takeoutcarton001a.mdl",
                        use = (function(ply, ent)
                            if ply:IsValid() then
                                ply:SetNWInt("visl_hunger", ply:GetNWInt("visl_hunger") + 35)
                                if ply:GetNWInt("visl_hunger") > 100 then
                                    ply:SetNWInt("visl_hunger", 100)
                                end
                                if ent then
                                    ent:Remove()
                                end
                            end
                        end),
                        spawn = (function(ply, ent)
                            ent:SetItemName("takeoutbox")
                        end),
                        skin = 1,
                        space = 2,
                        category = "Food and Drinks",
                        buttonDist = 32,                
                    }

items["bakedbeans"] =    {
                        name = "Baked Beans",
                        desc = "Beans in a sweet sauce",
                        ent = "item_basic",
                        model = "models/props_junk/garbage_metalcan002a.mdl",
                        use = (function(ply, ent)
                            if ply:IsValid() then
                                ply:SetNWInt("visl_hunger", ply:GetNWInt("visl_hunger") + 25)
                                if ply:GetNWInt("visl_hunger") > 100 then
                                    ply:SetNWInt("visl_hunger", 100)
                                end
                                if ent then
                                    ent:Remove()
                                end
                            end
                        end),
                        spawn = (function(ply, ent)
                            ent:SetItemName("bakedbeans")
                        end),
                        skin = 1,
                        space = 1,
                        category = "Food and Drinks",
                        buttonDist = 32,                
                    }

items["milkcarton"] =    {
                        name = "Milk Carton",
                        desc = "A carton of milk",
                        ent = "item_basic",
                        model = "models/props_junk/garbage_milkcarton002a.mdl",
                        use = (function(ply, ent)
                            if ply:IsValid() then
                                ply:SetNWInt("visl_hunger", ply:GetNWInt("visl_hunger") + 10)
                                if ply:GetNWInt("visl_hunger") > 100 then
                                    ply:SetNWInt("visl_hunger", 100)
                                end
                                if ent then
                                    ent:Remove()
                                end
                            end
                        end),
                        spawn = (function(ply, ent)
                            ent:SetItemName("milkcarton")
                        end),
                        skin = 1,
                        space = 1,
                        category = "Food and Drinks",
                        buttonDist = 32,                
                    }

items["bottleofwater"] =    {
                        name = "Bottle of Water",
                        desc = "A refreshing bottle of water",
                        ent = "item_basic",
                        model = "models/props/cs_office/Water_bottle.mdl",
                        use = (function(ply, ent)
                            if ply:IsValid() then
                                ply:SetNWInt("visl_hunger", ply:GetNWInt("visl_hunger") + 5)
                                if ply:GetNWInt("visl_hunger") > 100 then
                                    ply:SetNWInt("visl_hunger", 100)
                                end
                                if ent then
                                    ent:Remove()
                                end
                            end
                        end),
                        spawn = (function(ply, ent)
                            ent:SetItemName("waterbottle")
                        end),
                        skin = 1,
                        space = 1,
                        category = "Food and Drinks",
                        buttonDist = 32,                
                    }

--WEAPONS BELOW HERE

items["m9k_barret_m82"] =    {
                        name = "Barret M82",
                        desc = "A powerful sniper-rifle!",
                        ent = "item_basic",
                        model = "models/weapons/w_barret_m82.mdl",
                        use = (function(ply, ent)
                            if ply:IsValid() then
                                ply:Give("m9k_barret_m82", true)
                                if ent then
                                    ent:Remove()
                                end
                            end
                        end),
                        spawn = (function(ply, ent)
                            ent:SetItemName("m9k_barret_m82")
                        end),
                        skin = 1,
                        space = 5,
                        category = "Weapons",
                        buttonDist = 32,                
}

items["m9k_m24"] =    {
                        name = "M24",
                        desc = "A standard issue sniper-rifle",
                        ent = "item_basic",
                        model = "models/weapons/w_barret_m82.mdl",
                        use = (function(ply, ent)
                            if ply:IsValid() then
                                ply:Give("m9k_m24", true)
                                if ent then
                                    ent:Remove()
                                end
                            end
                        end),
                        spawn = (function(ply, ent)
                            ent:SetItemName("m9k_m24")
                        end),
                        skin = 1,
                        space = 5,
                        category = "Weapons",
                        buttonDist = 32,                
}

items["m9k_ares_shrike"] =    {
                        name = "Ares Shrike",
                        desc = "A machine gun with alot of rounds",
                        ent = "item_basic",
                        model = "models/weapons/w_ares_shrike.mdl",
                        use = (function(ply, ent)
                            if ply:IsValid() then
                                ply:Give("m9k_ares_shrike", true)
                                if ent then
                                    ent:Remove()
                                end
                            end
                        end),
                        spawn = (function(ply, ent)
                            ent:SetItemName("m9k_ares_shrike")
                        end),
                        skin = 1,
                        space = 5,
                        category = "Weapons",
                        buttonDist = 32,                
}

items["m9k_pkm"] =    {
                        name = "PKM",
                        desc = "A russian made machine gun with alot of rounds",
                        ent = "item_basic",
                        model = "models/weapons/w_mach_russ_pkm.mdl",
                        use = (function(ply, ent)
                            if ply:IsValid() then
                                ply:Give("m9k_pkm", true)
                                if ent then
                                    ent:Remove()
                                end
                            end
                        end),
                        spawn = (function(ply, ent)
                            ent:SetItemName("m9k_pkm")
                        end),
                        skin = 1,
                        space = 5,
                        category = "Weapons",
                        buttonDist = 32,                
}

items["m9k_m3"] =    {
                        name = "Benelli M3",
                        desc = "A Benelli shotgun",
                        ent = "item_basic",
                        model = "models/weapons/w_benelli_m3.mdl",
                        use = (function(ply, ent)
                            if ply:IsValid() then
                                ply:Give("m9k_m3", true)
                                if ent then
                                    ent:Remove()
                                end
                            end
                        end),
                        spawn = (function(ply, ent)
                            ent:SetItemName("m9k_m3")
                        end),
                        skin = 1,
                        space = 5,
                        category = "Weapons",
                        buttonDist = 32,                
}

items["m9k_remington870"] =    {
                        name = "Remington 870",
                        desc = "A Remington shotgun",
                        ent = "item_basic",
                        model = "models/weapons/w_remington_870_tact.mdl",
                        use = (function(ply, ent)
                            if ply:IsValid() then
                                ply:Give("m9k_remington870", true)
                                if ent then
                                    ent:Remove()
                                end
                            end
                        end),
                        spawn = (function(ply, ent)
                            ent:SetItemName("m9k_remington870")
                        end),
                        skin = 1,
                        space = 5,
                        category = "Weapons",
                        buttonDist = 32,                
}

items["m9k_scar"] =    {
                        name = "Scar",
                        desc = "A Scar assault rifle",
                        ent = "item_basic",
                        model = "models/weapons/w_fn_scar_h.mdl",
                        use = (function(ply, ent)
                            if ply:IsValid() then
                                ply:Give("m9k_scar", true)
                                if ent then
                                    ent:Remove()
                                end
                            end
                        end),
                        spawn = (function(ply, ent)
                            ent:SetItemName("m9k_scar")
                        end),
                        skin = 1,
                        space = 5,
                        category = "Weapons",
                        buttonDist = 32,                
}

items["m9k_ak47"] =    {
                        name = "AK-47",
                        desc = "An AK-47!",
                        ent = "item_basic",
                        model = "models/weapons/w_ak47_m9k.mdl",
                        use = (function(ply, ent)
                            if ply:IsValid() then
                                ply:Give("m9k_ak47", true)
                                if ent then
                                    ent:Remove()
                                end
                            end
                        end),
                        spawn = (function(ply, ent)
                            ent:SetItemName("m9k_ak47")
                        end),
                        skin = 1,
                        space = 5,
                        category = "Weapons",
                        buttonDist = 32,                
}

items["m9k_m416"] =    {
                        name = "HK 416",
                        desc = "An HK 416!",
                        ent = "item_basic",
                        model = "models/weapons/w_ak47_m9k.mdl",
                        use = (function(ply, ent)
                            if ply:IsValid() then
                                ply:Give("m9k_m416", true)
                                if ent then
                                    ent:Remove()
                                end
                            end
                        end),
                        spawn = (function(ply, ent)
                            ent:SetItemName("m9k_m416")
                        end),
                        skin = 1,
                        space = 5,
                        category = "Weapons",
                        buttonDist = 32,                
}

items["m9k_kac_pdw"] =    {
                        name = "KAC PDW",
                        desc = "Almost an assault rifle...",
                        ent = "item_basic",
                        model = "models/weapons/w_kac_pdw.mdl",
                        use = (function(ply, ent)
                            if ply:IsValid() then
                                ply:Give("m9k_kac_pdw", true)
                                if ent then
                                    ent:Remove()
                                end
                            end
                        end),
                        spawn = (function(ply, ent)
                            ent:SetItemName("m9k_kac_pdw")
                        end),
                        skin = 1,
                        space = 2,
                        category = "Weapons",
                        buttonDist = 32,                
}

items["m9k_mp9"] =    {
                        name = "MP9",
                        desc = "A MP9 sub-machine gun with a sight!",
                        ent = "item_basic",
                        model = "models/weapons/w_brugger_thomet_mp9.mdl",
                        use = (function(ply, ent)
                            if ply:IsValid() then
                                ply:Give("m9k_mp9", true)
                                if ent then
                                    ent:Remove()
                                end
                            end
                        end),
                        spawn = (function(ply, ent)
                            ent:SetItemName("m9k_mp9")
                        end),
                        skin = 1,
                        space = 2,
                        category = "Weapons",
                        buttonDist = 32,                
}

items["m9k_mp5"] =    {
                        name = "MP5",
                        desc = "MP5 sub-machine gun",
                        ent = "item_basic",
                        model = "models/weapons/w_hk_mp5.mdl",
                        use = (function(ply, ent)
                            if ply:IsValid() then
                                ply:Give("m9k_mp5", true)
                                if ent then
                                    ent:Remove()
                                end
                            end
                        end),
                        spawn = (function(ply, ent)
                            ent:SetItemName("m9k_mp5")
                        end),
                        skin = 1,
                        space = 2,
                        category = "Weapons",
                        buttonDist = 32,                
}

items["m9k_uzi"] =    {
                        name = "UZI",
                        desc = "Small and quick to use",
                        ent = "item_basic",
                        model = "models/weapons/w_uzi_imi.mdl",
                        use = (function(ply, ent)
                            if ply:IsValid() then
                                ply:Give("m9k_uzi", true)
                                if ent then
                                    ent:Remove()
                                end
                            end
                        end),
                        spawn = (function(ply, ent)
                            ent:SetItemName("m9k_uzi")
                        end),
                        skin = 1,
                        space = 2,
                        category = "Weapons",
                        buttonDist = 32,                
}

items["m9k_coltpython"] =    {
                        name = "Colt Python",
                        desc = "A Colt Python, powerful!",
                        ent = "item_basic",
                        model = "models/weapons/w_colt_python.mdl",
                        use = (function(ply, ent)
                            if ply:IsValid() then
                                ply:Give("m9k_coltpython", true)
                                if ent then
                                    ent:Remove()
                                end
                            end
                        end),
                        spawn = (function(ply, ent)
                            ent:SetItemName("m9k_coltpython")
                        end),
                        skin = 1,
                        space = 2,
                        category = "Weapons",
                        buttonDist = 32,                
}

items["m9k_m92beretta"] =    {
                        name = "M92 Beretta",
                        desc = "Has a lot of bullets in the clip!",
                        ent = "item_basic",
                        model = "models/weapons/w_beretta_m92.mdl",
                        use = (function(ply, ent)
                            if ply:IsValid() then
                                ply:Give("m9k_m92beretta", true)
                                if ent then
                                    ent:Remove()
                                end
                            end
                        end),
                        spawn = (function(ply, ent)
                            ent:SetItemName("m9k_m92beretta")
                        end),
                        skin = 1,
                        space = 2,
                        category = "Weapons",
                        buttonDist = 32,                
}

items["m9k_colt1911"] =    {
                        name = "Colt 1911",
                        desc = "A simple, easy to use handgun",
                        ent = "item_basic",
                        model = "models/weapons/s_dmgf_co1911.mdl",
                        use = (function(ply, ent)
                            if ply:IsValid() then
                                ply:Give("m9k_colt1911", true)
                                if ent then
                                    ent:Remove()
                                end
                            end
                        end),
                        spawn = (function(ply, ent)
                            ent:SetItemName("m9k_colt1911")
                        end),
                        skin = 1,
                        space = 2,
                        category = "Weapons",
                        buttonDist = 32,                
}



-- Illegalities below

items["weedbag"] =    {
                        name = "Fiveish",
                        desc = "dragg",
                        ent = "item_basic",
                        model = "models/katharsmodels/contraband/zak_wiet/zak_wiet.mdl",
                        use = (function(ply, ent)
                            if ply:IsValid() then
                                print("dragas")
                            end
                        end),
                        spawn = (function(ply, ent)
                            ent:SetItemName("weedbag")
                        end),
                        skin = 1,
                        space = 1,
                        category = "Illegalities",
                        buttonDist = 32,                
}

items["ceramicpot"] =    {
                        name = "Ceramic Pot",
                        desc = "Great for planting in",
                        ent = "item_basic",
                        model = "models/nater/weedplant_pot.mdl",
                        use = (function(ply, ent)
                            if ply:IsValid() then
                                local newEnt = ents.Create("drug_pot")
                                newEnt:SetPos(ply:EyePos() + 95 * ply:GetAimVector())
                                newEnt:Spawn()
                            end
                        end),
                        spawn = (function(ply, ent)
                            ent:SetItemName("ceramicpot")
                        end),
                        skin = 1,
                        space = 1,
                        category = "Illegalities",
                        buttonDist = 32,                
}

items["cannabisseed"] =    {
                        name = "Cannabis Seed",
                        desc = "Could be hemp, am i right?",
                        ent = "item_basic",
                        model = "models/props_junk/garbage_bag001a.mdl",
                        use = (function(ply, ent)
                            if ply:IsValid() then
                                local newEnt = ents.Create("drug_seed")
                                newEnt:SetPos(ply:EyePos() + 95 * ply:GetAimVector())
                                newEnt:Spawn()
                            end
                        end),
                        spawn = (function(ply, ent)
                            ent:SetItemName("cannabisseed")
                        end),
                        skin = 1,
                        space = 1,
                        category = "Illegalities",
                        buttonDist = 32,                
}

items["pottingsoil"] =    {
                        name = "Potting Soil",
                        desc = "Nutrition for plants!",
                        ent = "item_basic",
                        model = "models/props/CS_militia/fertilizer.mdl",
                        use = (function(ply, ent)
                            if ply:IsValid() then
                                local newEnt = ents.Create("drug_soil")
                                newEnt:SetPos(ply:EyePos() + 95 * ply:GetAimVector())
                                newEnt:Spawn()
                            end
                        end),
                        spawn = (function(ply, ent)
                            ent:SetItemName("pottingsoil")
                        end),
                        skin = 1,
                        space = 2,
                        category = "Illegalities",
                        buttonDist = 32,                
}

--Clothing below here
items["fancysuit"] =    {
                        name = "Fancy Suit",
                        desc = "Suit up! A wise man once said",
                        ent = "item_basic",
                        model = "models/props_c17/SuitCase_Passenger_Physics.mdl",
                        use = (function(ply, ent)
                            if ply:IsValid() then
                                tableofgenderinformation = getGender(ply)
                                if tableofgenderinformation[1] == "f" then
                                    if tableofgenderinformation[2] == "female_07" then
                                        ply:SetModel( "models/kaesar/suits1/female_05.mdl" )
                                    else
                                        ply:SetModel( "models/kaesar/suits1/"..tableofgenderinformation[2]..".mdl" )
                                    end
                                else
                                    ply:SetModel("models/player/suits/"..tableofgenderinformation[2].."_open.mdl")
                                end
                            end
                        end),
                        spawn = (function(ply, ent)
                            ent:SetItemName("fancysuit")
                        end),
                        skin = 1,
                        space = 0,
                        category = "Clothing",
                        buttonDist = 32,                
}

items["femalebundleofclothes"] =    {
                        name = "Bundle of Female Clothes",
                        desc = "You got a good style!",
                        ent = "item_basic",
                        model = "models/props_c17/BriefCase001a.mdl",
                        use = (function(ply, ent)
                            if ply:IsValid() then
                                tableofgenderinformation = getGender(ply)
                                if tableofgenderinformation[1] == "f" then
                                    ply:SetModel(ply:GetNWString("vislrp_f_purchasedplayerModel"))
                                    ply:SetBodygroup(1, ply:GetNWInt("visl_f_bodygroup1"))
                                    ply:SetBodygroup(2, ply:GetNWInt("visl_f_bodygroup2"))
                                    ply:SetBodygroup(3, ply:GetNWInt("visl_f_bodygroup3"))
                                else
                                    return
                                end
                            end
                        end),
                        spawn = (function(ply, ent)
                            ent:SetItemName("femalebundleofclothes")
                        end),
                        skin = 1,
                        space = 0,
                        category = "Clothing",
                        buttonDist = 32,                
}

items["malebundleofclothes"] =    {
                        name = "Bundle of Male Clothes",
                        desc = "You got a good style!",
                        ent = "item_basic",
                        model = "models/props_c17/BriefCase001a.mdl",
                        use = (function(ply, ent)
                            if ply:IsValid() then
                                tableofgenderinformation = getGender(ply)
                                if tableofgenderinformation[1] == "m" then
                                    ply:SetModel(ply:GetNWString("vislrp_m_purchasedplayerModel"))
                                    ply:SetBodygroup(1, ply:GetNWInt("visl_m_bodygroup1"))
                                    ply:SetBodygroup(2, ply:GetNWInt("visl_m_bodygroup2"))
                                    ply:SetBodygroup(3, ply:GetNWInt("visl_m_bodygroup3"))
                                else
                                    return
                                end
                            end
                        end),
                        spawn = (function(ply, ent)
                            ent:SetItemName("malebundleofclothes")
                        end),
                        skin = 1,
                        space = 0,
                        category = "Clothing",
                        buttonDist = 32,                
}

-- Storage related below here
items["addstoragesmall"] =    {
                        name = "Small Storage Expander",
                        desc = "Will add 10 slots to your inventory capacity",
                        ent = "item_basic",
                        model = "models/props_junk/cardboard_box004a.mdl",
                        use = (function(ply, ent)
                            if ply:IsValid() then
                                ply:SetNWInt("visl_max_invsize", ply:GetNWInt("visl_max_invsize") + 10)
                            end
                        end),
                        spawn = (function(ply, ent)
                            ent:SetItemName("addstoragesmall")
                        end),
                        skin = 1,
                        space = 0,
                        category = "Storage",
                        buttonDist = 32,                
}

items["addstoragemedium"] =    {
                        name = "Medium Storage Expander",
                        desc = "Will add 20 slots to your inventory capacity",
                        ent = "item_basic",
                        model = "models/props_junk/cardboard_box002b.mdl",
                        use = (function(ply, ent)
                            if ply:IsValid() then
                                ply:SetNWInt("visl_max_invsize", ply:GetNWInt("visl_max_invsize") + 20)
                            end
                        end),
                        spawn = (function(ply, ent)
                            ent:SetItemName("addstoragemedium")
                        end),
                        skin = 1,
                        space = 0,
                        category = "Storage",
                        buttonDist = 32,                
}

items["addstoragelarge"] =    {
                        name = "Large Storage Expander",
                        desc = "Will add 40 slots to your inventory capacity",
                        ent = "item_basic",
                        model = "models/props_junk/cardboard_box003b_gib01.mdl",
                        use = (function(ply, ent)
                            if ply:IsValid() then
                                ply:SetNWInt("visl_max_invsize", ply:GetNWInt("visl_max_invsize") + 40)
                            end
                        end),
                        spawn = (function(ply, ent)
                            ent:SetItemName("addstoragelarge")
                        end),
                        skin = 1,
                        space = 0,
                        category = "Storage",
                        buttonDist = 32,                
}

function getGender(ply)
	local playermodel = ply:GetNWString("charModel")

	local explstr = string.Explode("/", playermodel)
    local explstr2 = string.Explode("_", explstr[#explstr])
    local charactertype = explstr2[1].."_"..explstr2[2]

	local substring = string.sub(charactertype, 1, 1 )
	local table_of_gender = {substring, charactertype}

	return table_of_gender
end
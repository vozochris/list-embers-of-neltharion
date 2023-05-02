--TSU
--VOZ_FETCH_LINES
function(states, event, core_event, ...)
    local order = 2
    local prof1, prof2, _, _, _ = GetProfessions()
    local skill_line1 = ""
    local skill_level1 = 0
    local skill_line2 = ""
    local skill_level2 = 0
    if prof1 then
        _, _, skill_level1, _, _, _, skill_line1 = GetProfessionInfo(prof1)
    end
    if prof2 then
        _, _, skill_level2, _, _, _, skill_line2 = GetProfessionInfo(prof2)
    end

    local function add_lines(entries, name)
        WeakAuras.ScanEvents("VOZ_ADD_LINES", entries, name, order)
        order = order + 0.01
    end

    local function add_profession(entries, skill_line, name)
        local required_skill = 25
        if skill_line1 == skill_line and skill_level1 >= required_skill or skill_line2 == skill_line and skill_level2 >= required_skill then
            add_lines(entries, name)
        end
    end

    add_lines(aura_env.professions, "Professions")

    add_profession(aura_env.inscription, 773, "Inscription")
    add_profession(aura_env.mining, 186, "Mining")
    add_profession(aura_env.herbalism, 182, "Herbalism")
    add_profession(aura_env.alchemy, 171, "Alchemy")
    add_profession(aura_env.blacksmithing, 164, "Blacksmithing")
    add_profession(aura_env.enchanting, 333, "Enchanting")
    add_profession(aura_env.engineering, 202, "Engineering")
    add_profession(aura_env.jewelcrafting, 755, "Jewelcrafting")
    add_profession(aura_env.leatherworking, 165, "Leatherworking")
    add_profession(aura_env.skinning, 393, "Skinning")
    add_profession(aura_env.tailoring, 197, "Tailoring")
end
--TSU
--VOZ_FETCH_LINES
function(states, event, core_event, ...)
    local order = 8

    local function add_lines(entries, name)
        WeakAuras.ScanEvents("VOZ_ADD_LINES", entries, name, order)
        order = order + 0.01
    end

    local function add_profession_rares(entries, name)
        local required_skill = 25
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

        for i, entry in pairs(entries) do
            if not (skill_line1 == entry.required_profession and skill_level1 >= required_skill or
            skill_line2 == entry.required_profession and skill_level2 >= required_skill) then
                entries[i] = nil
            end
        end
        
        add_lines(entries, name)
    end

    add_lines(aura_env.forbidden_reach, "Forbidden Reach")

    if aura_env.config["show_profession_rares"] then
        add_profession_rares(aura_env.forbidden_reach_profession_rares, "Forbidden Reach Profession Rares")
    end
end
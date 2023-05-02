aura_env.quest_completed = function(quest)
    return C_QuestLog.IsQuestFlaggedCompleted(quest)
end

aura_env.add_lines = function(entries, category, states, starting_index)
    local index = starting_index + 1
    local added_lines = false

    if not entries then
        return
    end
    
    for _, entry in pairs(entries) do
        local c = 0
        local quests_count = 0
        local show = false
        local has_vignette = false
        local requirement = true
        local filtered = false
        local completed_on = entry.completed_on or 1
        
        local filter_config = aura_env.config["filter"]
        if filter_config then
            for _, filter in pairs(filter_config) do
                if (entry.name == filter.name) then
                    filtered = true
                end
            end
        end
        
        if not filtered and entry.required_quests then
            for _, required_quest in pairs(entry.required_quests) do
                if not aura_env.quest_completed(required_quest) then
                    requirement = false
                    break
                end
            end
        end
        
        if not filtered and requirement then
            for _, quest in pairs(entry.quests) do
                quests_count = quests_count + 1
                if aura_env.quest_completed(quest) then
                    c = c + 1
                end
            end
        end
        
        if quests_count > 0 and c < completed_on then
            for _, vignette in pairs(aura_env.vignettes) do
                if entry.name == vignette.name then
                    has_vignette = true
                    break
                end
            end
            show = true
        elseif not filtered and requirement and aura_env.config["show_completed"] then
            show = true
        end
        if show then
            local prepend = entry.prepend or ""
            local append = entry.append or ""
            
            if show then
                local is_completed = c >= completed_on

                if entry.completed_on then
                    append = append .. ": " .. (completed_on - c)
                end

                if entry.coords and aura_env.config["show_coords"] then
                    append = append .. WrapTextInColorCode(" (" .. entry.coords .. ")", "FFDDDDDD")
                end
                
                if entry.info and aura_env.config["show_info"] then
                    append = append .. WrapTextInColorCode(" (" .. entry.info .. ")", "FFDDDDDD")
                end
                
                if quests_count == 0 then
                    append = append .. WrapTextInColorCode(" [Missing ID!]", "FFDDDDDD")
                    is_completed = true
                end
                
                if has_vignette then
                    append = append .. " <---"
                end
                
                states[entry] = {
                    show = true,
                    name = entry.name,
                    prepend = prepend,
                    append = append,
                    completed = is_completed,
                    has_vignette = has_vignette,
                    zone_id = entry.zone_id,
                    coords = entry.coords,
                    index = index
                }
                index = index + 1
                added_lines = true
            end
        end
    end
    
    if added_lines then
        states["category_" .. category] =  {
            show = true,
            name = category,
            category = true,
            index = starting_index
        }
        if aura_env.config["add_empty_line_after_category"] then
            index = aura_env.add_empty_line(states, index)
        end
    end

    return index
end

aura_env.add_empty_line = function(states, starting_index)
    states["empty_" .. starting_index] = {
        show = true,
        name = "",
        index = starting_index
    }
    return starting_index + 1
end

aura_env.on_voz_add_lines = function(states, event, entries, category, order, ...)
    aura_env.index = order * 10000
    aura_env.index = aura_env.add_lines(entries, category, states, aura_env.index)
end

aura_env.vignettes = {}
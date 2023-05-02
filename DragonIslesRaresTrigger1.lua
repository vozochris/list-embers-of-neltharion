--TSU
--VOZ_FETCH_LINES
function(states, event, core_event, ...)
    local order = 3

    local function add_lines(entries, name)
        WeakAuras.ScanEvents("VOZ_ADD_LINES", entries, name, order)
        order = order + 0.01
    end

    local function add_zone(entries, zone_id, name)
        local show_only_current_zone = aura_env.config["show_only_current_zone"]
        local in_zone = not show_only_current_zone or C_Map.GetBestMapForUnit("player") == zone_id
        
        if in_zone and aura_env.config["show_" .. zone_id] then
            for i, entry in pairs(entries) do
                if not aura_env.config["show_only_super_rares"] or entry.super then
                    entry.zone_id = zone_id
                    if entry.super then
                        entry.prepend = "[S] "
                    end
                else
                    entries[i] = nil
                end
            end

            add_lines(entries, name)
        end
    end

    add_zone(aura_env.the_waking_shores, 2022, "The Waking Shores")
    add_zone(aura_env.ohnahran_plains, 2023, "Ohn'ahran Plains")
    add_zone(aura_env.the_azure_span, 2024, "The Azure Span")
    add_zone(aura_env.thaldraszus, 2025, "Thaldraszus")
end
--TSU
--VOZ_FETCH_LINES
function(states, event, core_event, ...)
    local order = 11
    local function add_zone(entries, zone_id, name)
        local show_only_current_zone = aura_env.config["show_only_current_zone"]
        local in_zone = not show_only_current_zone or C_Map.GetBestMapForUnit("player") == zone_id
        
        if in_zone and aura_env.config["show_" .. zone_id] then
            for _, entry in pairs(entries) do
                entry.zone_id = zone_id
            end

            WeakAuras.ScanEvents("VOZ_ADD_LINES", entries, name, order)
            order = order + 0.01
        end
    end

    add_zone(aura_env.zaralek_cavern_treasures, 2133, "Zaralek Cavern Treasures")
end
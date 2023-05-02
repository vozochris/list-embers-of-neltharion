--TSU
--VOZ_FETCH_LINES
function(states, event, core_event, ...)
    local order = 7

    local function add_lines(entries, name)
        WeakAuras.ScanEvents("VOZ_ADD_LINES", entries, name, order)
        order = order + 0.01
    end

    add_lines(aura_env.primal_cores, "Primal Cores")
    add_lines(aura_env.fire_elementals, "Fire Elementals")
    add_lines(aura_env.water_elementals, "Water Elementals")
    add_lines(aura_env.earth_elementals, "Earth Elementals")
    add_lines(aura_env.air_elementals, "Air Elementals")
end
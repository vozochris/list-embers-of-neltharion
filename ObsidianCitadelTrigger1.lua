--TSU
--VOZ_FETCH_LINES
function(states, event, core_event, ...)
    local order = 4
    WeakAuras.ScanEvents("VOZ_ADD_LINES", aura_env.obsidian_citadel, "Obsidian Citadel", order)
end
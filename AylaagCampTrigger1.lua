--TSU
--VOZ_FETCH_LINES
function(states, event, core_event, ...)
    local order = 5
    WeakAuras.ScanEvents("VOZ_ADD_LINES", aura_env.aylaag_camp, "Aylaag Camp", order)
end
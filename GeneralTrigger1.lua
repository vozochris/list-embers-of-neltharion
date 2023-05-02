--TSU
--VOZ_FETCH_LINES
function(states, event, core_event, ...)
    local order = 1
    WeakAuras.ScanEvents("VOZ_ADD_LINES", aura_env.general, "General", order)
end
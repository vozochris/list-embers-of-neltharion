--TSU
--VOZ_FETCH_LINES
function(states, event, core_event, ...)
    local order = 6
    WeakAuras.ScanEvents("VOZ_ADD_LINES", aura_env.iskaara_fish, "Iskaara Fish", order)
end
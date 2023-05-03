--TSU
--VOZ_FETCH_LINES
function(states, event, core_event, ...)
    local order = 1

    local entries = aura_env.general
    for i, entry in pairs(entries) do
        if entry.id and aura_env.config["hide_" .. entry.id] then
            entries[i] = nil
        end
    end
    WeakAuras.ScanEvents("VOZ_ADD_LINES", entries, "General", order)
end
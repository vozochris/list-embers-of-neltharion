--TSU
--VOZ_FETCH_LINES
function(states, event, core_event, ...)
    local order = 11

    local function add_lines(entries, name)
        WeakAuras.ScanEvents("VOZ_ADD_LINES", entries, name, order)
        order = order + 0.01
    end

    add_lines(aura_env.fyrakk_assault, "Fyrakk Assault")
end
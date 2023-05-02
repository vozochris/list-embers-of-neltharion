--TSU
--VOZ_ADD_LINES, PLAYER_LOGIN, PLAYER_REGEN_ENABLED, PLAYER_TARGET_CHANGED, ZONE_CHANGED_AREA_NEW, ZONE_CHANGED, VARIABLES_LOADED, ZONE_CHANGED_NEW_AREA, ZONE CHANGED INDOORS, VIGNETTE_MINIMAP_UPDATED
function(states, event, ...)
    if event == "VOZ_ADD_LINES" then
        aura_env.on_voz_add_lines(states, event, ...)
    else
        for _, state in pairs(states) do
            state.show = false
            state.changed = true
        end

        if event == "VIGNETTE_MINIMAP_UPDATED" then
            local vignette_GUID = select(1, ...)
            local on_minimap = select(2, ...)
    
            if on_minimap then
                local vignette_info = C_VignetteInfo.GetVignetteInfo(vignette_GUID)
                aura_env.vignettes[vignette_GUID] = vignette_info
            else
                aura_env.vignettes[vignette_GUID] = nil
            end
        end
        
        aura_env.index = 1
        WeakAuras.ScanEvents("VOZ_FETCH_LINES", event, ...)
    end

    return true
end
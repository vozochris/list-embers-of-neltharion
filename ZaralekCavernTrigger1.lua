--TSU
--VOZ_FETCH_LINES
function(states, event, core_event, ...)
    local order = 9

    local inactive_subzone = nil

    if aura_env.config["hide_inactive_zone"] then
        local subzone_rotation = {
            [0] = "glimmerogg",
            [1] = "nal_ks_kol",
            [2] = "loamm",
            [3] = "aberrus",
        }

        local start_timestamp = GetServerTime() - 1683345600
        local days = start_timestamp / 86400
        local rotation_index = math.floor(days % 4)
        inactive_subzone = subzone_rotation[rotation_index]
    end

    local function add_zone(entries, zone_id, name, skip_prepend)
        local show_only_current_zone = aura_env.config["show_only_current_zone"]
        local in_zone = not show_only_current_zone or C_Map.GetBestMapForUnit("player") == zone_id
        
        if in_zone then
            for i, entry in pairs(entries) do
                if aura_env.config["hide_events"] and entry.is_event or
                aura_env.config["hide_rares"] and not entry.is_event then
                    entries[i] = nil
                else
                    if not skip_prepend then
                        if entry.is_event then
                            entry.prepend = "[E] "
                        else
                            entry.prepend = "[R] "
                        end
                    end

                    entry.zone_id = zone_id
                end
            end

            WeakAuras.ScanEvents("VOZ_ADD_LINES", entries, name, order)
            order = order + 0.01
        end
    end

    add_zone(aura_env.zaralek_cavern, 2133, "Zaralek Cavern", true)

    if not aura_env.config["hide_caldera"] then
        add_zone(aura_env.zaralek_cavern_caldera, 2133, "Zaralek Cavern: Caldera")
    end
    if not aura_env.config["hide_glimmerogg"] and inactive_subzone ~= "glimmerogg" then
        add_zone(aura_env.zaralek_cavern_glimmerogg, 2133, "Zaralek Cavern: Glimmerogg")
    end
    if not aura_env.config["hide_nal_ks_kol"] and inactive_subzone ~= "nal_ks_kol" then
        add_zone(aura_env.zaralek_cavern_nal_ks_kol, 2133, "Zaralek Cavern: Nal Ks'Kol")
    end
    if not aura_env.config["hide_loamm"] and inactive_subzone ~= "loamm" then
        add_zone(aura_env.zaralek_cavern_loamm, 2133, "Zaralek Cavern: Loamm")
    end
    if not aura_env.config["hide_aberrus"] and inactive_subzone ~= "aberrus" then
        add_zone(aura_env.zaralek_cavern_aberrus, 2133, "Zaralek Cavern: Aberrus")
    end
end
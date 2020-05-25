script.on_event(defines.events.on_lua_shortcut,
        function(event)
            if(event.prototype_name == "trolley-problem") then
                local player = game.get_player(event.player_index)
                local called = 0
                for i, train in pairs(player.surface.get_trains(player.force)) do

                    -- check if at least 1 locomotive on the entire train has the same color as the player
                    local soulbound = false
                    for i, movers in pairs(train.locomotives) do
                        for i, locomotive in pairs(movers) do
                            if(player.color.r == locomotive.color.r and player.color.g == locomotive.color.g and player.color.b == locomotive.color.b) then
                                soulbound = true
                            end
                        end
                    end

                    if soulbound then

                        -- check if the player is standing on a rail tile
                        local rail = nil
                        if not rail then
                            rail = player.surface.find_entity("straight-rail", player.position)
                        end
                        if not rail then
                            rail = player.surface.find_entity("curved-rail", player.position)
                        end

                        if rail then

                            local schedule = {}
                            schedule.current = 1
                            schedule.records = {}

                            if(train.schedule) then
                                schedule = train.schedule;
                            end

                            local record = {}
                            record.rail = rail
                            record.wait_conditions = {
                                {compare_type="or", type = "inactivity", ticks = 60 * 15},
                                {compare_type="or", type = "inactivity", ticks = 60 *  5},
                                {compare_type="and", type = "passenger_present"},
                            }
                            record.temporary = true;
                            table.insert(schedule.records, 1, record)
                            train.schedule = schedule;
                            train.go_to_station(1)
                            called = called + 1;
                        end

                    end
                end

                player.surface.create_entity{name = "flying-text", position = player.position, text = "[item=locomotive] " .. called}
            end
        end
)


script.on_event(defines.events.on_lua_shortcut,
        function(event)
            if(event.prototype_name == "trolley-problem") then
                local player = game.get_player(event.player_index)
                local called = 0

                for _, train in pairs(player.surface.get_trains(player.force)) do

                    if train_matches_player(train, player) then
                        if has_track_below_player(player)  then

                            local schedule = {}
                            schedule.current = 1
                            schedule.records = {}

                            if(train.schedule) then
                                schedule = train.schedule;

                                -- remove any existing temporary station @ top
                                if(schedule.records[1].temporary == true) then
                                    table.remove(schedule.records, 1)
                                end
                            end

                            local record = {}
                            record.temporary = true;
                            record.rail = get_track_below_player(player)
                            record.wait_conditions = {
                                {compare_type="or", type = "inactivity", ticks = 60 * 15},
                                {compare_type="or", type = "inactivity", ticks = 60 *  5},
                                {compare_type="and", type = "passenger_present"},
                            }

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

function train_matches_player(train, player)
    for _, movers in pairs(train.locomotives) do
        for _, locomotive in pairs(movers) do
            if(locomotive.color) then -- locomotive color isn't required
                if(identical_color(player.color, locomotive.color)) then
                    return true
                end
            end
        end
    end
    return false
end

function identical_color(color1, color2)
    return color1.r == color2.r and color1.g == color2.g and color1.b == color2.b
end

function get_track_below_player(player)
    return player.surface.find_entity("straight-rail", player.position) or player.surface.find_entity("curved-rail", player.position) or nil
end

function has_track_below_player(player)
    return get_track_below_player(player) and true
end

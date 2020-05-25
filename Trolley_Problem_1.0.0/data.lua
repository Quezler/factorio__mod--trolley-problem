data:extend(
        {
             {
               type = "shortcut",
               name = "trolley-problem",
               action = "lua",
               toggleable = false,
               order = "pick[one]";
               localised_name = {"shortcut.trolley-problem"},
               icon =
               {
                   filename = "__Trolley_Problem__/32.png",
                   priority = "extra-high-no-scale",
                   size = 32,
                   scale = 0.5,
                   mipmap_count = 2,
                   flags = {"gui-icon"}
               },
               small_icon =
               {
                   filename = "__Trolley_Problem__/24.png",
                   priority = "extra-high-no-scale",
                   size = 24,
                   scale = 0.5,
                   mipmap_count = 2,
                   flags = {"gui-icon"}
               },
             }

            -- Custom shortcut can be defined as follows:
            -- {
            --   type = "shortcut",
            --   name = "shortcut-name",
            --   action = "lua",
            --   toggleable = true, -- whether or not the shortcut button is a toggle button or not
            --   order, localised_name, technology_to_unlock, icon, small_icon, disabled_icon, disabled_small_icon as above
            -- }
        })

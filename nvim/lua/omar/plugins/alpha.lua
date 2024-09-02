return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        -- Greeting Function
        local function getGreeting(name)
            local tableTime = os.date '*t'
            local datetime = os.date ' %Y-%m-%d-%A   %H:%M:%S '
            local hour = tableTime.hour
            local greetingsTable = {
                [1] = '  Sleep well',
                [2] = '  Good morning',
                [3] = '  Good afternoon',
                [4] = '  Good evening',
                [5] = '󰖔  Good night',
            }
            local greetingIndex = 0
            if hour == 23 or hour < 7 then
                greetingIndex = 1
            elseif hour < 12 then
                greetingIndex = 2
            elseif hour >= 12 and hour < 18 then
                greetingIndex = 3
            elseif hour >= 18 and hour < 21 then
                greetingIndex = 4
            elseif hour >= 21 then
                greetingIndex = 5
            end
            return datetime .. '  ' .. greetingsTable[greetingIndex] .. ', ' .. name
        end

        -- Set header
        dashboard.section.header.val = {
            [[          ▀████▀▄▄              ▄█ ]],
            [[            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ]],
            [[    ▄        █          ▀▀▀▀▄  ▄▀  ]],
            [[   ▄▀ ▀▄      ▀▄              ▀▄▀  ]],
            [[  ▄▀    █     █▀   ▄█▀▄      ▄█    ]],
            [[  ▀▄     ▀▄  █     ▀██▀     ██▄█   ]],
            [[   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ]],
            [[    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ]],
            [[   █   █  █      ▄▄           ▄▀   ]],
        }

        -- Set menu
        dashboard.section.buttons.val = {
            dashboard.button("f", "󰱼  Find file", ":Telescope find_files <CR>"),
            dashboard.button("w", "  Make Cool Codes", ":e ~/Document/Code/test/test.c<CR>"),
            dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
            dashboard.button("r", "󰱼  Recently used files", ":Telescope oldfiles <CR>"),
            dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
            dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.vim<CR>"),
            dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
        }

        -- Set footer with greeting
        local function footer()
            return getGreeting('Lazy')
        end

        dashboard.section.footer.val = footer()

        dashboard.section.footer.opts.hl = "Type"
        dashboard.section.header.opts.hl = "Include"
        dashboard.section.buttons.opts.hl = "Keyword"

        dashboard.opts.opts.noautocmd = true
        alpha.setup(dashboard.opts)

        -- Disable folding on alpha buffer
        vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
    end,
}

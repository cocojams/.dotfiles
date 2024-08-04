return {
  -- {{{ Define the Harpoon lazy.vim specificaiton.

  "ThePrimeagen/harpoon",
  enabled = true,
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },

  -- ----------------------------------------------------------------------- }}}
  -- {{{ Define events to load Harpoon.

  keys = function()
    local harpoon = require("harpoon")
    local conf = require("telescope.config").values

    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end
      require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      }):find()
    end


    return {
      -- Harpoon marked files 1 through 4

            vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end),
            vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end),

            vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end),
            vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end),
            vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end),
            vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end),

            -- Toggle previous & next buffers stored within Harpoon list
            vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end),
            vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end),
    }
  end,

  -- ----------------------------------------------------------------------- }}}
  -- {{{ Use Harpoon defaults or my customizations.

  opts = function(_, opts)
    opts.settings = {
      save_on_toggle = false,
      sync_on_ui_close = false,
      save_on_change = true,
      enter_on_sendcmd = false,
      tmux_autoclose_windows = false,
      excluded_filetypes = { "harpoon", "alpha", "dashboard", "gitcommit" },
      mark_branch = false,
      key = function()
        return vim.loop.cwd()
      end
    }
  end,

  -- ----------------------------------------------------------------------- }}}
  -- {{{ Configure Harpoon.

  config = function(_, opts)
    require("harpoon").setup(opts)
  end,

  -- ----------------------------------------------------------------------- }}}
}

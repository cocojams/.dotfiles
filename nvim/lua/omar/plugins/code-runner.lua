return {
 theme = "lushwal",
  "CRAG666/code_runner.nvim",
  config = function()
    require("code_runner").setup({
      filetype = {
        python = "python",
      },
    })

    vim.keymap.set("n", "<leader>rr", ":RunFile<CR>", { noremap = true, silent = false })
    vim.keymap.set("n", "<leader>rq", ":RunClose<CR>", { noremap = true, silent = false })
  end,
}

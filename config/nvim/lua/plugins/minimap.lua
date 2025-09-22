return {
  {
    "Isrothy/neominimap.nvim",
    version = "v3.x.x",
    lazy = false,
    keys = {
      -- Global Minimap Controls
      { "<leader>mm", "<cmd>Neominimap Toggle<cr>", desc = "Toggle global minimap" },
      { "<leader>mo", "<cmd>Neominimap Enable<cr>", desc = "Enable global minimap" },
      { "<leader>mc", "<cmd>Neominimap Disable<cr>", desc = "Disable global minimap" },
    },
    init = function()
      -- The following options are recommended when layout == "float"
      vim.opt.wrap = false
      vim.opt.sidescrolloff = 36 -- Set a large value

      --- Put your configuration here
      ---@type Neominimap.UserConfig
      vim.g.neominimap = {
        auto_enable = true,
      }
    end,
  },
}

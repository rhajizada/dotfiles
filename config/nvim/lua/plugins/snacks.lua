return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    explorer = {
      enabled = true,
      replace_netrw = true,
    },
    picker = {
      ignored = true,
      hidden = true,
    },
    keys = {
      { "<leader>gd", false },
      {
        "<leader>gT",
        function()
          Snacks.picker.git_diff()
        end,
        desc = "Git Diff (Hunks)",
      },
    },
  },
}

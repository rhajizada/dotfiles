return {
  {
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
        hidden = true,
        ignored = true,
        exclude = {
          ".git",
          ".hypothesis",
          ".pytest_cache",
          ".ruff_cache",
          ".venv",
          "__pycache__",
          "node_modules",
        },
      },
    },
    keys = {
      { "<leader>gd", false },
    },
  },
}

return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    ft = "markdown",
    cmd = "Obsidian",
    ---@module "obsidian"
    ---@type obsidian.config
    opts = {
      legacy_commands = false,
      workspaces = {
        {
          name = "personal",
          path = vim.env.HOME .. "/Dev/knowledge-base",
        },
      },
      picker = {
        name = "snacks.picker",
      },
    },
  },
}

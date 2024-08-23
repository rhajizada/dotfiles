return {
  {
    "olimorris/codecompanion.nvim",
    event = "LazyFile",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- Optional
      "stevearc/dressing.nvim", -- Optional: Improves the default Neovim UI
      {
        "grapp-dev/nui-components.nvim",
        dependencies = {
          "MunifTanjim/nui.nvim",
        },
      },
      {
        "folke/which-key.nvim",
        opts = function(_, opts)
          local wk = require("which-key")
          wk.add({ "<leader>a", group = "ai (CodeCompanion)" })
        end,
      },
    },
    keys = {
      --{ "<leader>aa", ":CodeCompanion" },
      --{ "<leader>ac", "<cmd>CodeCompanionChat<CR>", desc = "Open New Chat Buffer" },
      --{ "<leader>au", "<cmd>CodeCompanionToggle<CR>", desc = "Toggle Chat Buffer" },
      --{ "<leader>aA", "<cmd>CodeCompanionAdd<CR>", desc = "Add Selection to Chat Buffer", mode = { "n", "x", "v" } },
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "Actions" },
      { "<leader>ai", "<cmd>CodeCompanion<cr>", mode = { "n", "v" }, desc = "InlineCode" },
      { "<leader>av", "<cmd>CodeCompanionAdd<cr>", mode = { "v" }, desc = "Add Visual" },
      { "<leader>at", "<cmd>CodeCompanionToggle<cr>", mode = { "n", "v" }, desc = "Toggle" },
      { "<leader>am", desc = "Switch Mode Chat" },
    },
    opts = {
      strategies = {
        chat = {
          adapter = "ollama",
        },
        inline = {
          adapter = "ollama",
        },
        agent = {
          adapter = "ollama",
        },
      },
    },
  },
}

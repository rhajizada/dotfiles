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
          wk.add({ "<leader>a", group = "Copilot" })
        end,
      },
    },
    keys = {
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "Actions" },
      { "<leader>ai", "<cmd>CodeCompanion<cr>", mode = { "n", "v" }, desc = "Inline Code" },
      { "<leader>av", "<cmd>CodeCompanionAdd<cr>", mode = { "v" }, desc = "Add Visual" },
      { "<leader>at", "<cmd>CodeCompanionToggle<cr>", mode = { "n", "v" }, desc = "Toggle" },
      { "<leader>am", desc = "Switch Mode Chat" },
    },
    config = function()
      require("codecompanion").setup({
        adapters = {
          ollama = require("codecompanion.adapters").use("ollama", {
            schema = {
              model = {
                default = "codegeex4:9b",
              },
              num_ctx = {
                default = 16384,
              },
              num_predict = {
                default = -1,
              },
            },
          }),
        },
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
      })
    end,
  },
}

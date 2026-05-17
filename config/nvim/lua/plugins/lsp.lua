return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruff = {
          init_options = {
            settings = {
              lint = {
                enable = false,
              },
            },
          },
        },
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      local seen = {}
      local deduped = {}

      for _, tool in ipairs(opts.ensure_installed or {}) do
        if not seen[tool] then
          seen[tool] = true
          deduped[#deduped + 1] = tool
        end
      end

      opts.ensure_installed = deduped
    end,
  },
}

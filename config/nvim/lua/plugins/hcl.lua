return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        tf = { "tfmt" },
        terraform = { "tfmt" },
        hcl = { "tfmt" },
      },
      formatters = {
        tfmt = {
          -- Specify the command and its arguments for formatting
          command = "terraform",
          args = { "fmt", "-" },
          stdin = true,
        },
      },
    },
  },
  {
    "nathom/filetype.nvim",
    config = function()
      -- Setup overrides for file extensions
      require("filetype").setup({
        overrides = {
          extensions = {
            tf = "terraform",
            tfvars = "hcl",
            tfstate = "json",
          },
        },
      })
    end,
  },
}

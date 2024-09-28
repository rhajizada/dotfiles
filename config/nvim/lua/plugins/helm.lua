return {
  {
    "mrjosh/helm-ls",
    dependencies = {
      "towolf/vim-helm",
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        helm_ls = {},
      },
    },
  },
}

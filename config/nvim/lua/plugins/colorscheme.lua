return {
  {
    "EdenEast/nightfox.nvim",
    config = function()
      require("nightfox").setup({
        options = {
          transparent = true,
          styles = {
            comments = "italic",
            keywords = "bold",
            functions = "italic,bold",
          },
        },
        palettes = {
          carbonfox = {
            bg0 = "#000000",
            bg1 = "#000000",
            bg2 = "#000000",
            bg3 = "#000000",
            bg4 = "#000000",
            comment = "#60728a",
          },
        },
        groups = {
          carbonfox = {
            Normal = { bg = "NONE" },
            NormalNC = { bg = "NONE" },
            SignColumn = { bg = "NONE" },
            VertSplit = { bg = "NONE" },
            EndOfBuffer = { bg = "NONE" },
          },
        },
      })
      vim.cmd("colorscheme carbonfox")
    end,
  },
}

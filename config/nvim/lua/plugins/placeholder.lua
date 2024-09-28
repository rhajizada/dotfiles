return {
  {
    "rhajizada/placeholder",
    config = function()
      require("placeholder").setup({
        keymap = "<leader>cj",
        console = "internalConsole",
      })
    end,
  },
}

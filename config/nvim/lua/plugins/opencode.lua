return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    ---@module 'snacks'
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {}

    vim.o.autoread = true

    -- Toggle / open
    vim.keymap.set({ "n", "t" }, "<leader>at", function()
      require("opencode").toggle()
    end, { desc = "opencode: toggle" })

    -- "Open" (if your plugin has a true open/focus API use it;
    -- otherwise toggle is the closest behavior)
    vim.keymap.set({ "n", "t" }, "<leader>ao", function()
      -- If opencode exposes something like .open() or .focus(), prefer that:
      -- require("opencode").open()
      require("opencode").toggle()
    end, { desc = "opencode: open" })

    -- Ask / actions
    vim.keymap.set({ "n", "x" }, "<leader>aa", function()
      require("opencode").ask("@this: ", { submit = true })
    end, { desc = "opencode: ask" })

    vim.keymap.set({ "n", "x" }, "<leader>ax", function()
      require("opencode").select()
    end, { desc = "opencode: actions" })

    -- Add context (operator-style)
    vim.keymap.set({ "n", "x" }, "go", function()
      return require("opencode").operator("@this ")
    end, { desc = "opencode: add range", expr = true })

    vim.keymap.set("n", "goo", function()
      return require("opencode").operator("@this ") .. "_"
    end, { desc = "opencode: add line", expr = true })

    -- Scroll the opencode session from anywhere
    vim.keymap.set("n", "<C-u>", function()
      require("opencode").command("session.half.page.up")
    end, { desc = "opencode: scroll up" })

    vim.keymap.set("n", "<C-d>", function()
      require("opencode").command("session.half.page.down")
    end, { desc = "opencode: scroll down" })
  end,
}

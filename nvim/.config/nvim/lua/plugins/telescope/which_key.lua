local setup = function()
  local wk = require("which-key")
  wk.register({
      t = {
          name = "Telescope",
          f = { "Find File" },
          g = { "Grep in files" },
          c = { "Show commits" },
          S = { "Show git stash" },
          s = { "Show git status" },
          b = { "Show nvim buffers" },
          h = { "Show help tags" },
      }
  }, {
      mode = "n",
      prefix = "<leader>",
      nowait = false,
  })
  end

return {
  setup = setup
}

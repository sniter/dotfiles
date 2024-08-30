local setup = function()
  local wk = require("which-key")
  wk.add({
    { "<leader>t", group = "Telescope", nowait = false },
    { "<leader>tS", desc = "Show git stash", nowait = false },
    { "<leader>tb", desc = "Show nvim buffers", nowait = false },
    { "<leader>tc", desc = "Show commits", nowait = false },
    { "<leader>tf", desc = "Find File", nowait = false },
    { "<leader>tg", desc = "Grep in files", nowait = false },
    { "<leader>th", desc = "Show help tags", nowait = false },
    { "<leader>ts", desc = "Show git status", nowait = false },
  })
  end

return {
  setup = setup
}

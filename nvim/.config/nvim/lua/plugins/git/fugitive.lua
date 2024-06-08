return {
  keys = {
    {
      "<leader>ga",
      "<cmd>Git add %<cr>",
      desc = "git add All",
    },
    {
      "<leader>gs",
      "<cmd>vertical Git<cr>",
      desc = "git status",
    },
    {
      "<leader>gl",
      "<cmd>0GlLog!<cr>",
      desc = "git log for buffer",
    },
    {
      "<leader>gb",
      "<cmd>Git blame<cr>",
      desc = "git log for buffer",
    },
    {
      "<leader>gc",
      "<cmd>Git commit -v -q %:p<cr>",
      desc = "git commit",
    },
    {
      "<leader>gB",
      "<cmd>Git branch -c %:p<cr>",
      desc = "git create new branch",
    },
    {
      "<leader>gp",
      "<cmd>Git push<cr>",
      desc = "git push",
    }
  },
}
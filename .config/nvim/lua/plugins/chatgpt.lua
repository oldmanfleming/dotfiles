return {
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("chatgpt").setup()
    end,
    keys = {
      { "<leader>ac", "<cmd>ChatGPT<cr>", desc = "Open Chat", mode = { "n" } },
      {
        "<leader>ae",
        "<cmd>ChatGPTEditWithInstructions<cr>",
        desc = "Edit selected text or whole window",
        mode = { "n", "v", "x" },
      },
      -- See: https://github.com/jackMort/ChatGPT.nvim/blob/main/lua/chatgpt/flows/actions/actions.json
      -- for a list of available actions
      { "<leader>at", "<cmd>ChatGPTRun add_tests<cr>", desc = "Add Tests", mode = { "n", "v", "x" } },
      { "<leader>ad", "<cmd>ChatGPTRun docstring<cr>", desc = "Generate Docs", mode = { "n", "v", "x" } },
      { "<leader>ao", "<cmd>ChatGPTRun optimize_code<cr>", desc = "Optimize Code", mode = { "n", "v", "x" } },
      { "<leader>ai", "<cmd>ChatGPTRun explain_code<cr>", desc = "Explain Code", mode = { "n", "v", "x" } },
    },
  },
}

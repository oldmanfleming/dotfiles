return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      ---@type lspconfig.options
      servers = {
        denols = {
          root_dir = require("lspconfig/util").root_pattern("mod.ts", "deps.ts", "deno.json", "deno.jsonc"),
        },
        tsserver = {
          root_dir = require("lspconfig/util").root_pattern("package.json"),
        },
      },
    },
  },
}

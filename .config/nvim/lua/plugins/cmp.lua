return {
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local luasnip = require("luasnip")
      local cmp = require("cmp")

      -- tab completion + no CR completion
      -- https://www.lazyvim.org/configuration/recipes#supertab
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true })
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<CR>"] = cmp.mapping(function(fallback)
          fallback()
        end, { "i", "s" }),
      })
    end,
  },
}
-- bug: seems to remove copilot as well
-- remove text completions
-- https://github.com/hrsh7th/nvim-cmp/pull/1067
--      opts.sources = cmp.config.sources({
--        {
--          name = "nvim_lsp",
--          entry_filter = function(entry, ctx)
--            local kind = require("cmp.types").lsp.CompletionItemKind[entry:get_kind()]
--
--            if kind == "Text" then
--              return false
--            end
--            return true
--          end,
--        },
--      })

-- Alternative: first item is not selected, tab to select and CR to confirm
--return {
--  {
--    "L3MON4D3/LuaSnip",
--    keys = function()
--      return {}
--    end,
--  },
--  {
--    "hrsh7th/nvim-cmp",
--    dependencies = {
--      "hrsh7th/cmp-emoji",
--    },
--    ---@param opts cmp.ConfigSchema
--    opts = function(_, opts)
--      local luasnip = require("luasnip")
--      local cmp = require("cmp")
--
--      opts.completion = {
--        completeopt = "menu,menuone,noselect",
--      }
--
--      -- bug: seems to remove copilot
--      -- remove text completions
--      -- https://github.com/hrsh7th/nvim-cmp/pull/1067
--      --      opts.sources = cmp.config.sources({
--      --        {
--      --          name = "nvim_lsp",
--      --          entry_filter = function(entry, ctx)
--      --            local kind = require("cmp.types").lsp.CompletionItemKind[entry:get_kind()]
--      --
--      --            if kind == "Text" then
--      --              return false
--      --            end
--      --            return true
--      --          end,
--      --        },
--      --      })
--
--      -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#safely-select-entries-with-cr
--      opts.mapping = vim.tbl_extend("force", opts.mapping, {
--        ["<CR>"] = cmp.mapping({
--          i = function(fallback)
--            if cmp.visible() and cmp.get_active_entry() then
--              cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
--            else
--              fallback()
--            end
--          end,
--          s = cmp.mapping.confirm({ select = true }),
--          c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
--        }),
--      })
--
--      -- supertab
--      -- https://www.lazyvim.org/configuration/recipes#supertab
--      local has_words_before = function()
--        unpack = unpack or table.unpack
--        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
--      end
--      opts.mapping = vim.tbl_extend("force", opts.mapping, {
--        ["<Tab>"] = cmp.mapping(function(fallback)
--          if cmp.visible() then
--            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
--            cmp.select_next_item()
--            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
--            -- this way you will only jump inside the snippet region
--          elseif luasnip.expand_or_jumpable() then
--            luasnip.expand_or_jump()
--          elseif has_words_before() then
--            cmp.complete()
--          else
--            fallback()
--          end
--        end, { "i", "s" }),
--        ["<S-Tab>"] = cmp.mapping(function(fallback)
--          if cmp.visible() then
--            cmp.select_prev_item()
--          elseif luasnip.jumpable(-1) then
--            luasnip.jump(-1)
--          else
--            fallback()
--          end
--        end, { "i", "s" }),
--        -- ["<C-a>"] = cmp.mapping.confirm({ select = true }),
--        -- ["<CR>"] = cmp.mapping(function(fallback)
--        --   fallback()
--        -- end, { "i", "s" }),
--      })
--    end,
--  },
--}

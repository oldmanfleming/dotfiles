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
      local cmp = require("cmp")
      -- use tab for completions
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
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<CR>"] = cmp.mapping(function(fallback)
          fallback()
        end, { "i", "s" }),
      })
      -- disable the completion previews.
      -- find it incredibly distracting
      opts.experimental = {
        ghost_text = false,
      }
      -- remove snippet completions
      -- https://github.com/hrsh7th/nvim-cmp/pull/1067
      opts.sources = cmp.config.sources({
        {
          name = "nvim_lsp",
          ---@param entry cmp.Entry
          entry_filter = function(entry, ctx)
            local types = require("cmp.types")
            local kind = types.lsp.CompletionItemKind[entry:get_kind()]

            if kind == "Snippet" then
              return false
            end
            return true
          end,
        },
        -- keep other sources
        { name = "buffer" },
        { name = "path" },
        {
          name = "copilot",
          group_index = 1,
          priority = 100,
        },
      })
    end,
  },
}

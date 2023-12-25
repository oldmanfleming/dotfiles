-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- Sync clipboard between OS and nvim
vim.opt.clipboard = "unnamedplus"
vim.opt.relativenumber = false

-- WSL Clipboard support
-- https://stackoverflow.com/questions/75548458/copy-into-system-clipboard-from-neovim
-- prereq: sudo apt install wl-clipboard
if vim.fn.has("wsl") == 1 then
  if vim.fn.executable("wl-copy") == 0 then
    print("wl-clipboard not found, clipboard integration won't work")
  else
    vim.cmd([[ echomsg "wl-clipboard not found. Please install wl-clipboard." ]])
    vim.g.clipboard = {
      name = "wl-clipboard (wsl)",
      copy = {
        ["+"] = "wl-copy --foreground --type text/plain",
        ["*"] = "wl-copy --foreground --primary --type text/plain",
      },
      paste = {
        ["+"] = function()
          return vim.fn.systemlist('wl-paste --no-newline|sed -e "s/\r$//"', { "" }, 1)
        end,
        ["*"] = function()
          return vim.fn.systemlist('wl-paste --primary --no-newline|sed -d "s/\r$//"', { "" }, 1)
        end,
      },
      cache_enabled = true,
    }
  end
end

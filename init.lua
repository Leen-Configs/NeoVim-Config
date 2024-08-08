-- Set colorscheme
-- vim.o.termguicolors = false
-- vim.cmd [[colorscheme default]]


vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },


  -- {
  --     "stevearc/conform.nvim",
  -- event = { "BufReadPre", "BufNewFile" },
  -- config = function()
  --   local conform = require("conform")
  --
  --   conform.setup({
  --     formatters_by_ft = {
  --       go = { "goimports", "gofmt" },
  --       javascript = { "prettierd", "prettier" },
  --       python = { "isort", "black" },
  --     },
  --     format_on_save = {
  --       lsp_fallback = true,
  --       async = false,
  --       timeout_ms = 500
  --     }
  --   })
  --
  --   vim.keymap.set({ "n", "v" }, "<leader>mp", function()
  --     conform.format({
  --       lsp_fallback = true,
  --       async = false,
  --       timeout_ms = 500
  --     })
  --   end, {desc = "Format file or range (in visual mode)"})
  -- end,
  --
  -- },


  { import = "plugins" },
}, lazy_config)

require 'nvim-tree'.setup {
  filters = {
    dotfiles = false, -- Set this to false to show dotfiles
  }
  -- other settings
}

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

require("base46").toggle_transparency()

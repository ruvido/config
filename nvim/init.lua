-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Set the leader key to space
vim.g.mapleader = ' '
vim.api.nvim_set_keymap('n', '<leader>yy', ':1,$y+<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F12>', ':Neotree toggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>w', '<C-w>w', { noremap = true, silent = true })

-- Editor settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.syntax = 'enable'
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Plugin setup using lazy.nvim
require("lazy").setup({
  {'nvim-treesitter/nvim-treesitter', build = ":TSUpdate"},
  {'nvim-treesitter/tree-sitter-lua'},
  {"Pocco81/auto-save.nvim"},
  {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
          "MunifTanjim/nui.nvim",
          -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
      },
      config = function()
          require("neo-tree").setup({
              window = {
                  width = 30,  -- Set the desired width here
              },
              -- Other configurations can go here
          })
      end,
  },
  {"folke/zen-mode.nvim", opts = { window = { backdrop = 1, width = 80, height = 0.8 } }},
  {"preservim/vim-pencil"},
  {'AlexvZyl/nordic.nvim'},
  {
      "epwalsh/pomo.nvim",
      version = "*",  -- Recommended, use latest release instead of latest commit
      lazy = true,
      cmd = { "TimerStart", "TimerRepeat", "TimerSession" },
      dependencies = {
          -- Optional, but highly recommended if you want to use the "Default" timer
          "rcarriga/nvim-notify",
      },
      opts = {
          sticky = false,
          title_icon = "",
          text_icon = "",
          -- See below for full list of options 👇
      },
  }
})

vim.cmd [[colorscheme nordic]]

------------------------ i

-- vim.cmd('autocmd VimEnter *.md,*.txt :PencilSoft | ZenMode')
-- vim.cmd('autocmd VimEnter *.md,*.txt :ZenMode')
-- vim.cmd('autocmd BufLeave *.md,*.txt :ZenMode')
vim.api.nvim_set_keymap('n', '<leader>zz', ':ZenMode<CR>:PencilSoft<CR>', { noremap = true, silent = true })

-- vim.cmd('autocmd BufRead *.md,*.txt :PencilSoft | ZenMode')
-- vim.cmd('autocmd BufAdd *.md,*.txt :PencilSoft | ZenMode')
-- vim.cmd('autocmd BufAdd *.md,*.txt let g:prose = 1 | ZenMode')
--
require("pomo").setup({
  sessions = {
    pomodoro = {
      { name = "Work", duration = "25m" },
      { name = "Short Break", duration = "5m" },
      { name = "Work", duration = "25m" },
      { name = "Short Break", duration = "5m" },
      { name = "Work", duration = "25m" },
      { name = "Long Break", duration = "15m" },
    },
  },
})

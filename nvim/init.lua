
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Leader key e impostazioni base
vim.g.mapleader = " "
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Plugin setup with lazy.nvim
require("lazy").setup({
  -- Treesitter for syntax highlighting
  {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      opts = {
          ensure_installed = { "dart" },
          highlight = {
              enable = true,
              additional_vim_regex_highlighting = false,
          }
      }
  },

  -- Neo-tree for file exploration
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        window = { width = 30 },
      })
    end,
  },

  -- Zen Mode for a distraction-free environment
  { "folke/zen-mode.nvim", opts = { window = { backdrop = 1, width = 80, height = 0.8 } } },

  -- Pencil for improving Markdown editing
  { "preservim/vim-pencil" },

  -- bullets.vim per la gestione automatica delle liste in Markdown
  { "dkarter/bullets.vim" },

  -- Nordic theme for a pleasant visual experience
  { "AlexvZyl/nordic.nvim" },

  -- Tools for a better writing experience in Markdown
  {
    "skwee357/nvim-prose",
    config = function()
      require("nvim-prose").setup({
        wpm = 200.0,
        filetypes = { "markdown", "asciidoc" },
        placeholders = { words = "words", minutes = "min" },
      })
    end,
  },

  -- Dart syntax highlighting base
  { "dart-lang/dart-vim-plugin" },

})

-- Imposta il colorscheme
vim.cmd("colorscheme nordic")

-- Keybindings
vim.api.nvim_set_keymap("n", "<leader>yy", ":%y+<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F12>", ":Neotree toggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>w", "<C-w>w", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>zz", ":ZenMode<CR>:PencilSoft<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>wc", ":lua print(require('nvim-prose').word_count() .. ' words, ' .. require('nvim-prose').reading_time() .. ' minutes')<CR>", { noremap = true, silent = true })

-- Configurazione specifica per HTML (es. template per Go)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "html",
  callback = function()
    vim.opt_local.commentstring = "{{/*%s*/}}"
    vim.opt_local.comments = "s1:/*,mb:*,ex:*/,://,://"
  end,
})

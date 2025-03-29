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
  -- Treesitter for syntax highlighting
  {'nvim-treesitter/nvim-treesitter', build = ":TSUpdate"},
  {'nvim-treesitter/tree-sitter-lua'},

  -- Auto-save
  {"Pocco81/auto-save.nvim"},

  -- Neo-tree file explorer
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
        window = {
          width = 30,  -- Set the desired width here
        },
      })
    end,
  },

  -- Zen mode
  {"folke/zen-mode.nvim", opts = { window = { backdrop = 1, width = 80, height = 0.8 } }},

  -- Pencil for prose editing
  {"preservim/vim-pencil"},

  -- Nordic theme
  {'AlexvZyl/nordic.nvim'},

  -- Pomodoro timer
  {
    "epwalsh/pomo.nvim",
    version = "*",
    lazy = true,
    cmd = { "TimerStart", "TimerRepeat", "TimerSession" },
    dependencies = {
      "rcarriga/nvim-notify",
    },
    opts = {
      sticky = false,
      title_icon = "",
      text_icon = "",
    },
  },

  -- Prose writing tools
  {
    "skwee357/nvim-prose",
    config = function()
      require("nvim-prose").setup({
        wpm = 200.0,
        filetypes = { "markdown", "asciidoc" },
        placeholders = {
          words = "words",
          minutes = "min",
        },
      })
    end,
  },

  -- LSP and Flutter support
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      -- Set up LSP for Dart/Flutter
      local lspconfig = require("lspconfig")
      lspconfig.dartls.setup({
        cmd = { "dart", "language-server", "--protocol=lsp" },
        init_options = {
          closingLabels = true,
          flutterOutline = true,
          onlyAnalyzeProjectsWithOpenFiles = true,
          outline = true,
          suggestFromUnimportedLibraries = true,
        },
      })

      -- Auto-completion setup
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        mapping = {
          ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
          ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
          ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
          ['<C-y>'] = cmp.config.disable,
          ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
        }),
      })

      -- Keybindings for Flutter
      vim.api.nvim_set_keymap('n', '<leader>fr', ':lua vim.lsp.buf.formatting()<CR>:lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>fd', ':lua vim.lsp.buf.declaration()<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>fq', ':lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
    end,
  },
})

-- Set colorscheme
vim.cmd [[colorscheme nordic]]

-- Zen mode and prose writing
vim.api.nvim_set_keymap('n', '<leader>zz', ':ZenMode<CR>:PencilSoft<CR>', { noremap = true, silent = true })

-- Pomodoro timer setup
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

-- Go templating language
vim.api.nvim_create_autocmd("FileType", {
  pattern = "html",
  callback = function()
    vim.opt_local.commentstring = "{{/*%s*/}}"
    vim.opt_local.comments = "s1:/*,mb:*,ex:*/,://,://"
  end,
})

-- Word count and reading time
vim.api.nvim_set_keymap('n', '<leader>wc', ':lua print(require("nvim-prose").word_count() .. " words, " .. require("nvim-prose").reading_time() .. " minutes")<CR>', { noremap = true, silent = true })

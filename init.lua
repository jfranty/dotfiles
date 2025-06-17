local o = vim.opt

o.expandtab   = true  -- expand tabs
o.shiftwidth  = 2     -- autoindent spacing
o.softtabstop = 2     -- <Tab> counts for 2 spaces while editing

o.guicursor   = ''    -- disable invisible cursor
o.mouse       = ''    -- allow using mous again

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

local function map(mode, l, r, opts)
  vim.keymap.set(mode, l, r, opts)
end

-- make it easier to disable highlight
map({ 'n', 'v' }, '^', ':noh<CR>')
-- Emacs/bash style command-line
map({ 'c' }, '<C-A>', '<Home>', { noremap = true })
map({ 'c' }, '<C-E>', '<End>', { noremap = true })

vim.g.augment_workspace_folders = {'~/src/sigma/slate'}

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { 'ellisonleao/gruvbox.nvim', priority = 1000 },

  'tpope/vim-commentary',
  'wincent/ferret',

  'neovim/nvim-lspconfig',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/nvim-cmp',
  'williamboman/mason.nvim',

  {
    'nvim-telescope/telescope.nvim', 
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  { 'nvim-treesitter/nvim-treesitter', build = ":TSUpdate" },

  -- {
  --   -- Main LSP Configuration
  --   'neovim/nvim-lspconfig',
  --   dependencies = {
  --     -- Automatically install LSPs and related tools to stdpath for Neovim
  --     -- Mason must be loaded before its dependents so we need to set it up here.
  --     -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
  --     {
  --       'williamboman/mason.nvim', opts = {} },
  --       'williamboman/mason-lspconfig.nvim',
  --       'WhoIsSethDaniel/mason-tool-installer.nvim',

  --     -- -- Useful status updates for LSP.
  --     -- { 'j-hui/fidget.nvim', opts = {} },
  --     --
  --     -- -- Allows extra capabilities provided by nvim-cmp
  --     -- 'hrsh7th/cmp-nvim-lsp',
  --   },

  --   config = function()
  --     local servers = {}
  --     local ensure_installed = vim.tbl_keys(servers or {})

  --     require('mason-tool-installer').setup { ensure_installed = ensure_installed }

  --     require('mason-lspconfig').setup()
  --   end,
  -- },

  -- {
  --   'stevearc/conform.nvim',
  --   opts = {
  --     format_on_save = {
  --       -- These options will be passed to conform.format()
  --       timeout_ms = 500,
  --       lsp_format = "fallback",
  --     },
  --     formatters_by_ft = {
  --       javascript = { "prettierd", "prettier", stop_after_first = true },
  --     },
  --   },
  -- },

--  'prettier/vim-prettier',
--  -- 'leafgarland/typescript-vim',
--  -- 'pangloss/vim-javascript',
--
--  {
--    'mhartington/formatter.nvim',
--    config = function ()
--      local formatter_prettier = { require('formatter.defaults.prettier') }
--      require('formatter').setup({
--	filetype = {
--	  javascript      = formatter_prettier,
--	  javascriptreact = formatter_prettier,
--	  typescript      = formatter_prettier,
--	  typescriptreact = formatter_prettier,
--	}
--      })
--      -- automatically format buffer before writing to disk:
--      vim.api.nvim_create_autocmd('BufWritePost', {
--	command = 'FormatWrite',
--	pattern = { '*.js', '*.jsx', '*.ts', '*.tsx' },
--      })
--    end,
--    ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
--  },
--  {
--    'nvim-treesitter/nvim-treesitter',
--    build = ':TSUpdate',
--    config = function () 
--      local configs = require('nvim-treesitter.configs')
--      configs.setup({
--        ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query', 'elixir', 'heex', 'javascript', 'html' },
--        sync_install = false,
--        highlight = { enable = true },
--        indent = { enable = true },  
--      })
--    end
--  },
--  {
--    'nvim-neo-tree/neo-tree.nvim',
--    branch = 'v3.x',
--    dependencies = {
--      'nvim-lua/plenary.nvim',
--      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
--      'MunifTanjim/nui.nvim',
--    },
--  },

  { 'augmentcode/augment.vim' },
})

-- vim.cmd('colorscheme onedark')
vim.cmd([[colorscheme gruvbox]])
vim.cmd('highlight Normal guibg=#000000')

require('mason').setup()

local nvim_lsp = require('lspconfig')

nvim_lsp.ts_ls.setup({
  init_options = {
    maxTsServerMemory = 4096, -- Limit memory usage
  },
  handlers = {
    ['textDocument/publishDiagnostics'] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        update_in_insert = true,
      }
    ),
  },
})

-- Remap Ctrl-] to use LSP definition instead of tags
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, opts)
    -- You might also want these:
    vim.keymap.set('n', '<C-t>', '<C-o>', opts) -- Go back (like with tags)
  end,
})

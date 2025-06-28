call plug#begin('~/.local/share/nvim/plugged')

Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'andweeb/presence.nvim'

" Theme
Plug 'bluz71/vim-moonfly-colors'

" LSP + IntelliSense (C/C++)
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

call plug#end()



" Shortcuts
nnoremap <C-w> :NERDTreeToggle<CR>

" Theme settings
syntax enable
set background=dark
colorscheme moonfly

" Line numbers
set number

" Auto indentation
filetype plugin indent on
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

lua << EOF
-- Completion setup
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  })
})

-- Mason setup
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "clangd" }, -- for C
})

-- LSP config
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require("lspconfig").clangd.setup({
  capabilities = capabilities,
})
EOF

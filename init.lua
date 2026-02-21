vim.opt.winborder = "single"

vim.opt.listchars = {
  tab = "▸ ",
  trail = "·",
  extends = "›",
  precedes = "‹",
  nbsp = "␣",
}

local indent_group = vim.api.nvim_create_augroup(
  "FileTypeIndent",
  { clear = true }
)

local filetype_settings = {
  javascript = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  typescript = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  typescriptreact = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  html = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  css = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  scss = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  json = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  yaml = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  vue = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  svelte = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  python = { expandtab = true, shiftwidth = 4, tabstop = 4, softtabstop = 4 },
  lua = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  go = { expandtab = false, shiftwidth = 4, tabstop = 4, softtabstop = 0 },
  c = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  cpp = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  rust = { expandtab = true, shiftwidth = 4, tabstop = 4, softtabstop = 4 },
  java = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  sh = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  bash = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  zsh = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  ruby = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  php = { expandtab = true, shiftwidth = 4, tabstop = 4, softtabstop = 4 },
  markdown = { expandtab = true, shiftwidth = 4, tabstop = 4, softtabstop = 4 },
  make = { expandtab = false, shiftwidth = 4, tabstop = 4, softtabstop = 0 },
}

for filetype, settings in pairs(filetype_settings) do
  vim.api.nvim_create_autocmd("FileType", {
    group = indent_group,
    pattern = filetype,
    callback = function()
      vim.bo.expandtab = settings.expandtab
      vim.bo.shiftwidth = settings.shiftwidth
      vim.bo.tabstop = settings.tabstop
      vim.bo.softtabstop = settings.softtabstop
      vim.notify("[INDENT] " .. filetype .. " sw=" .. settings.shiftwidth, vim.log.levels.WARN)
    end,
  })
end

vim.o.clipboard = "unnamedplus"
vim.o.signcolumn = "yes"
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.swapfile = false
vim.g.mapleader = " "
vim.o.clipboard = "unnamedplus"
vim.o.backup = false
vim.o.writebackup = false
vim.o.undofile = true
vim.o.hidden = true
vim.o.list = true
vim.o.colorcolumn = "80"
vim.o.expandtab = true
vim.o.incsearch = true

vim.keymap.set("i", "jk", "<esc>", { silent = true })
vim.keymap.set("i", "kj", "<esc>", { silent = true })
vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<cr>", { silent = true })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { silent = true })

vim.pack.add({
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
  { src = "https://github.com/hrsh7th/cmp-buffer" },
  { src = "https://github.com/hrsh7th/cmp-path" },
  { src = "https://github.com/hrsh7th/cmp-cmdline" },
  { src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/tpope/vim-fugitive" },
  { src = "https://github.com/echasnovski/mini.nvim" },
  { src = "https://github.com/cbochs/grapple.nvim" },
})

local oil = require("oil")
oil.setup({
  default_file_explorer = true,
  view_options = {
    show_hidden = true
  }
})
vim.keymap.set("n", "<leader>o", "<cmd>Oil<cr>")

local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered()
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-space"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<C-j>"] = cmp.mapping.scroll_docs(4),
    ["<C-k>"] = cmp.mapping.scroll_docs(-4),
  }),
  sources = cmp.config.sources({
    { name = "buffer" },
    { name = "nvim_lsp" },
    { name = "path" },
  })
}, {
  { name = "buffer" }
})

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { silent = true })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { silent = true })
vim.keymap.set("n", "gh", vim.lsp.buf.hover, { silent = true })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { silent = true })
vim.keymap.set("n", "gR", vim.lsp.buf.rename, { silent = true })
vim.keymap.set("n", "gca", vim.lsp.buf.code_action, { silent = true })
vim.keymap.set("n", "gcl", vim.lsp.codelens.run, { silent = true })
vim.keymap.set("n", "gL", vim.lsp.codelens.refresh, { silent = true })
vim.keymap.set("n", "g=", vim.lsp.buf.format, { silent = true })

vim.lsp.config["lua_ls"] = {
  cmd = { '/home/soul/.git-repos/lua-language-server/bin/lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      }
    }
  }
}

local servers = {
  "lua_ls",
  "gopls"
}

---@type boolean
vim.g.lsp_enabled = false

vim.keymap.set("n", "<leader>l", function()
  vim.g.lsp_enabled = not vim.g.lsp_enabled
  if vim.g.lsp_enabled then
    for _, server in ipairs(servers) do
      vim.lsp.enable(server, true)
    end
    vim.cmd("edit")
    vim.notify("[LSP] enabled", vim.log.levels.WARN)
  else
    for _, server in ipairs(servers) do
      vim.lsp.enable(server, false)
    end
    for _, client in ipairs(vim.lsp.get_clients()) do
      client:stop()
    end
    vim.notify("[LSP] disabled", vim.log.levels.WARN)
  end
end)

local mini_pairs = require("mini.pairs")
mini_pairs.setup()

local mini_pick = require("mini.pick")
mini_pick.setup()

local mini_extra = require("mini.extra")
mini_extra.setup()

local mini_statusline = require("mini.statusline")
mini_statusline.setup()

local mini_comment = require("mini.comment")
mini_comment.setup()

vim.keymap.set("n", "<leader>sf", "<cmd>Pick files tool='git'<cr>", { silent = true })
vim.keymap.set("n", "<leader>sg", "<cmd>Pick grep_live<cr>", { silent = true })
vim.keymap.set("n", "<leader>sb", "<cmd>Pick buffers<cr>", { silent = true })
vim.keymap.set("n", "<leader>sd", "<cmd>Pick diagnostic<cr>", { silent = true })

local grapple = require("grapple")
grapple.setup({
  icons = false
})

vim.keymap.set("n", "<leader>g", "<cmd>Grapple tag<cr>", { silent = true })
vim.keymap.set("n", "<leader>G", "<cmd>Grapple toggle_tags<cr>", { silent = true })
vim.keymap.set("n", "H", "<cmd>Grapple cycle_tags prev<cr>", { silent = true })
vim.keymap.set("n", "L", "<cmd>Grapple cycle_tags next<cr>", { silent = true })

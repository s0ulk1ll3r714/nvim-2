vim.o.winborder = "single"

---@diagnostic disable-next-line: param-type-mismatch
vim.api.nvim_create_autocmd("VimResized", {
  pattern = "*",
  callback = function()
    vim.cmd("wincmd =")
  end,
})

vim.keymap.set(
  "t",
  "<Esc><Esc>",
  "<C-\\><C-n>",
  { desc = "Exit terminal mode" }
)

vim.keymap.set(
  "n",
  "<C-h>",
  "<C-w><C-h>",
  { desc = "Move focus to the left window" }
)
vim.keymap.set(
  "n",
  "<C-l>",
  "<C-w><C-l>",
  { desc = "Move focus to the right window" }
)
vim.keymap.set(
  "n",
  "<C-j>",
  "<C-w><C-j>",
  { desc = "Move focus to the lower window" }
)
vim.keymap.set(
  "n",
  "<C-k>",
  "<C-w><C-k>",
  { desc = "Move focus to the upper window" }
)

vim.cmd [[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NonText guibg=NONE ctermbg=NONE
  highlight SignColumn guibg=NONE ctermbg=NONE
  highlight NormalFloat guibg=NONE ctermbg=NONE
  highlight FloatBorder guibg=NONE ctermbg=NONE
]]

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
  make = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2},
  txt = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
  cmake = { expandtab = true, shiftwidth = 2, tabstop = 2, softtabstop = 2 },
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
    end,
  })
end

vim.o.signcolumn = "yes"
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.swapfile = false
vim.g.mapleader = " "
vim.g.localleader = " "
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
  { src = "https://github.com/vague2k/vague.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/tpope/vim-fugitive" },
  { src = "https://github.com/echasnovski/mini.nvim" },
  { src = "https://github.com/cbochs/grapple.nvim" },
})

require("vague").setup({
  transparent = true,
})
vim.cmd("colorscheme vague")

local oil = require("oil")
oil.setup({
  default_file_explorer = true,
  view_options = {
    show_hidden = true
  }
})
vim.keymap.set("n", "<leader>o", "<cmd>Oil<cr>")

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

local servers = {
  "lua_ls",
  "gopls",
  "rust_analyzer",
  "ts_ls",
  "tailwindcss",
  "clangd",
  "cmake",
}

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

vim.lsp.config["gopls"] = {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = { 'go.mod', 'go.work', '.git' },
}

vim.lsp.config["rust_analyzer"] = {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", ".git" },
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = true,
      inlayHints = {
        enable = true,
      },
    },
  },
}

vim.lsp.config["ts_ls"] = {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
}

vim.lsp.config["tailwindcss"] = {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
  root_markers = { "tailwind.config.js", "tailwind.config.ts", "tailwind.config.cjs", "tailwind.config.mjs", ".git" },
}

vim.lsp.config["clangd"] = {
  cmd = { "clangd", "--background-index", "--clang-tidy" },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
  root_markers = { "compile_commands.json", "compile_flags.txt", ".clangd", ".git" },
}

vim.lsp.config["cmake"] = {
  cmd = { "cmake-language-server" },
  filetypes = { "cmake" },
  root_markers = { "CMakeLists.txt", "CMakePresets.json", ".git" },
  init_options = {
    buildDirectory = "build",
  },
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

local mini_comment = require("mini.comment")
mini_comment.setup()

local mini_completion = require("mini.completion")
mini_completion.setup()

vim.keymap.set("n", "<leader>ff", "<cmd>:lua MiniFiles.open()<cr>", { silent = true })

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

-- Code for custom statusline starts
vim.g.timer_remaining = nil

local function statusline_timer()
  if vim.g.timer_remaining and vim.g.timer_remaining > 0 then
    local mins = math.floor(vim.g.timer_remaining / 60)
    local secs = vim.g.timer_remaining % 60
    return string.format("[tim=%02d:%02d]", mins, secs)
  end
  return ""
end

_G.statusline_timer = statusline_timer

vim.o.statusline = "[fil=%f][mod=%m]%=%{v:lua.statusline_timer()}[tim=%{strftime('%H:%M:%S')}][pos=%l|%c]"
vim.o.laststatus = 2

local timer = vim.uv.new_timer()
timer:start(1000, 1000, vim.schedule_wrap(function()
  if vim.g.timer_remaining and vim.g.timer_remaining > 0 then
    vim.g.timer_remaining = vim.g.timer_remaining - 1
    if vim.g.timer_remaining == 0 then
      vim.notify("[timer] timer finished", vim.log.levels.ERROR)
    end
  end
  vim.cmd("redrawstatus")
end))

vim.api.nvim_create_user_command("TimerStart", function(opts)
  local mins = tonumber(opts.args)
  if not mins or mins < 1 or mins > 60 then
    vim.notify("[timer] usage: :TimerStart <1-60>", vim.log.levels.ERROR)
    return
  end
  vim.g.timer_remaining = mins * 60
  vim.notify(string.format("[timer] started: %d minutes", mins), vim.log.levels.INFO)
end, { nargs = 1 })

-- Code for custom statusline ends

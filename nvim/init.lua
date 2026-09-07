-- Neovim configuration — ported from vimmy (github.com/kevinjqiu/vimmy)
-- Sections mirror the original vimrc and vim/*.vim module files.

-- Bootstrap lazy.nvim (replaces neobundle) {
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({ { "Failed to clone lazy.nvim:\n", "ErrorMsg" }, { out, "WarningMsg" } }, true, {})
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
-- }

-- Plugins (ported from vim/00-bundles.vim) {
require("lazy").setup({
  -- General
  "tpope/vim-surround",
  "tpope/vim-fugitive",
  "ctrlpvim/ctrlp.vim",
  "scrooloose/nerdtree",
  "majutsushi/tagbar",
  "scrooloose/nerdcommenter",
  "vim-airline/vim-airline",
  "vim-airline/vim-airline-themes",
  "Konfekt/FastFold",
  "hashivim/vim-terraform",

  -- Color
  "flazz/vim-colorschemes",

  -- Completion / LSP (requires nodejs; run :CocInstall coc-python after setup)
  { "neoclide/coc.nvim", branch = "release" },

  -- Golang
  "fatih/vim-go",

  -- Javascript
  "pangloss/vim-javascript",

  -- Ruby
  "vim-ruby/vim-ruby",

  -- Rust
  "rust-lang/rust.vim",

  "stephpy/vim-yaml",

  -- Dropped in the port:
  --   neobundle.vim        (vim-only plugin manager, replaced by lazy.nvim)
  --   neosnippet.vim       (superseded by coc.nvim)
  --   neocomplete.vim      (vim-only; coc.nvim provides completion)
  --   vimproc.vim          (linux-only build; not needed)
})
-- }

-- General (ported from vimrc "General") {
vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

vim.opt.cursorline = true
vim.opt.encoding = "utf-8"
vim.opt.fileformat = "unix"
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.background = "dark"
vim.opt.relativenumber = true
-- }

-- Whitespace (ported from vimrc "Whitespace") {
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.backspace = "indent,eol,start"
-- }

-- Searching (ported from vimrc "Searching") {
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- }

-- Tab completion (ported from vimrc "Tab completion") {
vim.opt.wildmode = { "list:longest", "list:full" }
vim.opt.wildignore:append({ "*.o", "*.obj", ".git", "*.rbc", "*.pyc" })
-- }

-- Keymappings (ported from vim/10-keymappings.vim) {
vim.g.mapleader = ","
local map = vim.keymap.set

-- Ctrl+N twice to toggle show line number
map("n", "<C-N><C-N>", ":set invnumber<CR>")

-- highlight the word under cursor (with hlsearch on)
map("n", "<Leader>g", "*N")
map("n", "/", "/\\v")
map("v", "/", "/\\v")
map("n", "<Leader><Space>", ":noh<CR>")

map("i", "<C-Space>", "<C-x><C-o>")
map("i", "jj", "<ESC>")
map("", "<Leader>T", ":tabnew<CR>", { silent = true })
for i = 1, 9 do
  map("", "t" .. i, i .. "gt")
end

map("", "<F3>", ":TagbarToggle<CR>")
map("", "<Leader>B", ":!ctags -R .<CR>")
map("", "<Leader>v", ":tabnew ~/.config/nvim/init.lua<CR>")
map("", "<Leader>V", ":tabnew ~/.vimrc.local<CR>")
map("n", "<Leader>q", ":q<CR>")

map("n", "Q", ":tabc<CR>")

map("n", "<C-u>", ":tabp<CR>", { silent = true })
map("n", "<C-p>", ":tabn<CR>", { silent = true })

map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

map("n", "<Leader>w", ":set list!<CR>") -- toggle show whitespace

-- the shift key is a bit sticky on Mac...
map("", ":W", ":w")
map("", ":Q", ":q")
map("", ":Wq", ":wq")

-- traverse buffers
map("", "<Leader>,", ":bn<CR>")
map("", "<Leader>.", ":bp<CR>")

-- redraw the screen
map("n", "U", ":syntax sync fromstart<CR>:redraw!<CR>")

-- visual shifting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- sudo!!
map("c", "w!!", "w !sudo tee % > /dev/null")
-- }

-- airline (ported from vim/20-airline.vim) {
vim.opt.laststatus = 2
vim.g.airline_theme = "dark"
vim.g["airline#extensions#branch#enabled"] = 1
vim.g["airline#extensions#syntastic#enabled"] = 1
vim.g["airline#extensions#tabline#enabled"] = 1
-- }

-- ctrlp (ported from vim/20-ctrlp.vim) {
vim.g.ctrlp_map = "<Leader>t"
vim.g.ctrlp_extensions = { "tag" }
vim.g.ctrlp_open_new_file = "h"
vim.g.ctrlp_custom_ignore = {
  dir = [[\.git$\|\.hg$\|\.svn$\|.*\.egg$\|build$\|bower_components$\|vendor$\|tmp$\|dist$\|rpm$\|lib$\|node_modules$]],
  file = [[\.exe$\|\.so$\|\.dll$\|\.pyc$]],
}
-- }

-- go (ported from vim/20-go.vim) {
vim.g.go_highlight_functions = 1
vim.g.go_highlight_method = 1
vim.g.go_highlight_structs = 1
-- }

-- nerdtree (ported from vim/20-nerdtree.vim) {
vim.g.NERDTreeIgnore = { "\\.pyc$" }
map("n", "<F2>", "<Esc>:NERDTreeToggle<CR>")
map("n", "<Leader>r", "<Esc>:NERDTreeFind<CR>")
-- NERDTree bookmark
map("", ":bm", ":Bookmark")
-- }

-- ruby (ported from vim/20-ruby.vim) {
vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
  pattern = "ruby",
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
  end,
})
-- }

-- solarized (ported from vim/20-solarized.vim) {
vim.g.solarized_termcolors = 256
vim.g.solarized_termtrans = 1
-- }

-- Local overrides (ported from vimrc) {
if vim.fn.filereadable(vim.fn.expand("$HOME/.vimrc.local")) == 1 then
  vim.cmd("source $HOME/.vimrc.local")
end
-- }

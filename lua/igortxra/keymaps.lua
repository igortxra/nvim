-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap


-------------
-- GENERIC --
-------------
--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Quit
keymap("n", "<leader>q", ":q<cr>", opts)
keymap("n", "<leader>Q", ":qa<cr>", opts)

-- Turn file into a executable
keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>", term_opts)

-- Open Explore/Tree
-- keymap("n", "<leader>e", ":Lex 30<cr>", opts)


-----------------
-- NAVIGATIONS --
-----------------
-- Better window navigation
keymap("n", "<C-h>", "<C-w>hzz", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>kzz", opts    )
keymap("n", "<C-l>", "<C-w>lzz", opts)

-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Half page navigation
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-w>zz", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)


-----------------
-- MOVING TEXT --
-----------------
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts) -- IDK

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)


---------------
-- SEARCHING --
---------------
-- Keep cursor in the middle when searching
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)

-- Unset highlight search
keymap("n", "<leader>h", ":nohlsearch<CR>", opts)

-- Magic change all words in file
keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)


-------------
-- BUFFERS --
-------------

-- Write Buffer
keymap("n", "<leader>w", ":w<cr>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Close buffers
keymap("n", "<leader>c", ":bdelete<CR>", opts)
keymap("n", "<leader>bcc", ":bdelete<CR>", opts)
keymap("n", "<leader>bco", ":only<CR>", opts)


-------------
-- Plugins --
-------------

-- NvimTree --
keymap("n", "<leader>e", ":NvimTreeFindFileToggle<cr>", opts)

-- Telescope --
keymap('n', '<leader>ff', ":Telescope find_files<cr>", opts)
keymap('n', '<leader>fg', ":Telescope live_grep<cr>", opts)
keymap('n', '<leader>fb', ":Telescope buffers<cr>", opts)
keymap('n', '<leader>fh', ":Telescope help_tags<cr>", opts)

-- Gitsigns --
keymap('n', '<leader>gp', ":Gitsigns preview_hunk<cr>", opts)
keymap('n', '<leader>gs', ":Gitsigns stage_hunk<cr>", opts)
keymap('n', '<leader>gS', ":Gitsigns stage_buffer<cr>", opts)
keymap('n', '<leader>gr', ":Gitsigns reset_hunk<cr>", opts)
keymap('n', '<leader>gR', ":Gitsigns reset_buffer<cr>", opts)
keymap('n', '<leader>gk', ":Gitsigns prev_hunk<cr>", opts)
keymap('n', '<leader>gj', ":Gitsigns next_hunk<cr>", opts)
keymap('n', '<leader>gb', ":Gitsigns blame_line<cr>", opts)
keymap('n', '<leader>gd', ":Gitsigns diffthis<cr>", opts)

-- ToggleTerm --
keymap('n', '<C-t>', ':ToggleTerm<cr>', opts)
keymap("t", "<C-t>", "<C-\\><C-N><C-w>l", term_opts)
keymap("t", "H", "H", term_opts)
keymap("t", "L", "L", term_opts)
keymap("n", "<leader>tm", ":lua _HTOP_TOGGLE()<cr>", opts)


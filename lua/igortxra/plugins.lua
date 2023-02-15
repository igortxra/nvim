local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins

	------------- MY PLUGINS ---------------

	-- Colorschemes
	use("Mofiqul/dracula.nvim")

	use("lunarvim/colorschemes")

	-- NvimTree
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
		tag = "nightly", -- optional, updated every week. (see issue #1193)
		config = function()
			require("nvim-tree").setup({
				respect_buf_cwd = true,
				view = {
					adaptive_size = false,
					centralize_selection = false,
					cursorline = true,
					debounce_delay = 15,
					width = 40,
					hide_root_folder = false,
					side = "left",
					preserve_window_proportions = false,
					number = false,
					relativenumber = false,
					signcolumn = "yes",
					mappings = {
						custom_only = false,
						list = {
							-- Custom actions --
							-- SEE ALL HERE https://github.com/nvim-tree/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt#L1488
							{ key = { "<CR>", "o", "l" }, action = "edit", mode = "n" },
							{ key = "h", action = "close_node", mode = "n" },
							{ key = "v", action = "vsplit", mode = "n" },
						},
					},
					float = {
						enable = true,
						quit_on_focus_loss = true,
						open_win_config = {
							relative = "editor",
							border = "rounded",
							width = 30,
							height = 20,
							row = 1,
							col = 1,
						},
					},
				},
			})
		end,
	})

	-- Treesitter
	use({ "JoosepAlviste/nvim-ts-context-commentstring" })
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = true,

				ensure_installed = "all",
				sync_install = false,
				ignore_install = { "" }, -- List of parsers to ignore installing
				highlight = {
					enable = true, -- false will disable the whole extension
					disable = { "" }, -- list of language that will be disabled
					additional_vim_regex_highlighting = true,
				},
				indent = { enable = true, disable = { "yaml" } },
				context_commentstring = { enable = true },
			})
		end,
	})

	--  Telescope
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- Bufferline
	use({
		"akinsho/bufferline.nvim",
		tag = "v3.*",
		requires = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({})
		end,
	})

	-- Gitsigns
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	})

	-- Debugger
	use({
		"rcarriga/nvim-dap-ui",
		requires = { "mfussenegger/nvim-dap" },
		config = function()
			require("dapui").setup()
		end,
	})

	use({ "ap/vim-css-color" })

	-- LuaLine
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("lualine").setup({
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "%f" },
					lualine_x = { "encoding", "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {},
			})
		end,
	})

	-- LSP and Completion
	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v1.x",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{ "williamboman/mason.nvim" }, -- Optional
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "hrsh7th/cmp-buffer" }, -- Optional
			{ "hrsh7th/cmp-path" }, -- Optional
			{ "saadparwaiz1/cmp_luasnip" }, -- Optional
			{ "hrsh7th/cmp-nvim-lua" }, -- Optional

			-- Snippets
			{ "L3MON4D3/LuaSnip" }, -- Required
			{ "rafamadriz/friendly-snippets" }, -- Optional
		},
	})

	-- Autopairs
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({
				disable_filetype = { "TelescopePrompt" },
			})
		end,
	})

	-- ToggleTerm
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			local toggleterm = require("toggleterm")
			toggleterm.setup({
				size = 70,
				direction = "float",
				float_opts = {
					border = "curved",
					winblend = 0,
					highlights = {
						border = "Normal",
						background = "Normal",
					},
				},
			})

			local Terminal = require("toggleterm.terminal").Terminal

			local htop = Terminal:new({ cmd = "htop", hidden = true })
			function _HTOP_TOGGLE()
				htop:toggle()
			end
		end,
	})

	-- Comments
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				---Add a space b/w comment and the line
				padding = true,
				---Whether the cursor should stay at its position
				sticky = true,
				---Lines to be ignored while (un)comment
				ignore = nil,
				---LHS of toggle mappings in NORMAL mode
				toggler = {
					---Line-comment toggle keymap
					line = "<leader>kc",
					---Block-comment toggle keymap
					block = "<leader>kb",
				},
				---LHS of operator-pending mappings in NORMAL and VISUAL mode
				opleader = {
					---Line-comment keymap
					line = "<leader>kc",
					---Block-comment keymap
					block = "<leader>kb",
				},
				---LHS of extra mappings
				extra = {
					---Add comment on the line above
					above = "<leader>kO",
					---Add comment on the line below
					below = "<leader>ko",
					---Add comment at the end of line
					eol = "<leader>kA",
				},
				---Enable keybindings
				---NOTE: If given `false` then the plugin won't create any mappings
				mappings = {
					---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
					basic = true,
					---Extra mapping; `gco`, `gcO`, `gcA`
					extra = true,
				},
				---Function to call before (un)comment
				pre_hook = nil,
				---Function to call after (un)comment
				post_hook = nil,
			})
		end,
	})

	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			local formatting = null_ls.builtins.formatting
			local diagnostics = null_ls.builtins.diagnostics
			null_ls.setup({
				debug = false,
				sources = {
					formatting.stylua,
					diagnostics.flake8,
          formatting.autopep8,
          formatting.isort,
				},
			})
		end,
	})
	---------------- MY PLUGINS END --------------------

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)

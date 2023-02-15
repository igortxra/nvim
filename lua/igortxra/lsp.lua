local status_ok, lsp = pcall(require, "lsp-zero")
if not status_ok then
	return
end

lsp.preset("recommended")

lsp.ensure_installed({
	"tsserver",
	"rust_analyzer",
})

-- Fix Undefined global 'vim'
lsp.configure("sumneko_lua", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-y>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings["<Tab>"] = nil
cmp_mappings["<S-Tab>"] = nil

-- Autopairs integrations with cmp
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
})

lsp.set_preferences({
	suggest_lsp_servers = false,
	sign_icons = {
		error = "E",
		warn = "W",
		hint = "H",
		info = "I",
	},
})

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "gr", function()
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "gs", function()
		vim.lsp.buf.signature_help()
	end, opts)
	vim.keymap.set("n", "gv", function()
		vim.diagnostic.open_float()
	end, opts)
	vim.keymap.set("n", "gk", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "gj", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "ga", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "gc", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting_sync()']])
	vim.keymap.set("n", "<C-f>", ":Format<cr>", opts)
	-- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
end)

lsp.setup()

vim.diagnostic.config({
	virtual_text = true,
})

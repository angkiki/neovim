return {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	version = "^1.0.0",
	init = function()
		vim.g.barbar_auto_setup = false
	end,
	config = function()
		require("barbar").setup({
			animation = true,
			auto_hide = false,
			tabpages = true,
			clickable = true,
			insert_at_end = true,
			sidebar_filetypes = {
				-- for nvim-tree offset
				NvimTree = true,
			},
		})

		-- example keymaps (optional)
		local map = vim.api.nvim_set_keymap
		local opts = { noremap = true, silent = true }

		-- Buffer navigation
		map("n", "<Tab>", "<Cmd>BufferNext<CR>", opts) -- next buffer
		map("n", "<S-Tab>", "<Cmd>BufferPrevious<CR>", opts) -- previous buffer

		-- Move buffers
		map("n", "<leader>bm", "<Cmd>BufferMoveNext<CR>", opts) -- move right
		map("n", "<leader>bM", "<Cmd>BufferMovePrevious<CR>", opts) -- move left

		-- Close buffer
		map("n", "<leader>bd", "<Cmd>BufferClose<CR>", opts)

		-- Close ALL buffers
		vim.keymap.set("n", "<leader>bD", function()
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, "buflisted") then
					vim.api.nvim_buf_delete(buf, { force = true })
				end
			end
		end, { desc = "Close all buffers" })

		-- Close all other buffers
		vim.keymap.set("n", "<leader>bO", function()
			local current = vim.api.nvim_get_current_buf()
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if
					buf ~= current
					and vim.api.nvim_buf_is_loaded(buf)
					and vim.api.nvim_buf_get_option(buf, "buflisted")
				then
					vim.api.nvim_buf_delete(buf, { force = true })
				end
			end
		end, { desc = "Close other buffers" })

		-- Pick buffer
		map("n", "<leader>bb", "<Cmd>BufferPick<CR>", opts)

		-- Pin buffer
		map("n", "<leader>bp", "<Cmd>BufferPin<CR>", opts)
	end,
}

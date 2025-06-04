return {
	"akinsho/toggleterm.nvim",
	config = function()
		local tt = require("toggleterm")
		tt.setup({
			direction = "float",
		})

		local term = require("toggleterm.terminal").Terminal
		local float_term = term:new({ direction = "float" })

		-- Helper function to exit terminal insert mode
		local function exit_terminal_mode()
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
		end

		vim.keymap.set("n", "<leader>tt", function()
			float_term:toggle()
		end, { desc = "Toggle floating terminal" })

		vim.keymap.set("t", "<leader>tt", function()
			exit_terminal_mode()
			float_term:toggle()
		end, { desc = "Toggle floating terminal (terminal mode)" })
	end,
}

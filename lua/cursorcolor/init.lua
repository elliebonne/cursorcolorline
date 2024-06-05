local M = {}

function M.setup(opts)
	vim.opt.cursorline = true
	local default = vim.api.nvim_get_hl(0, { name = "CursorLine" }).bg
	if not opts.normal then
		opts.normal = default
	end
	if not opts.insert then
		opts.insert = default
	end

	vim.api.nvim_set_hl(0, "CursorLine", { bg = opts.normal })

	vim.api.nvim_create_autocmd("ModeChanged", {
		callback = function()
			if not vim.api.nvim_get_all_options_info()["modifiable"] then
				vim.api.nvim_set_hl(0, "CursorLine", { bg = default })
				return
			end
			local mode = vim.api.nvim_get_mode().mode
			local color = default
			-- #vim.highlight.create("CursorLine", { guibg = "#3c3836" })
			if mode == "n" then
				color = opts.normal
			elseif mode == "i" then
				color = opts.insert
			end
			vim.api.nvim_set_hl(0, "CursorLine", { bg = color })
		end,
	})
end

return M

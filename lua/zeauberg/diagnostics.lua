vim.diagnostic.config {
	underline = true,
	virtual_text = {
		current_line = true
	},
	virtual_lines = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "e",
			[vim.diagnostic.severity.WARN] = "w",
			[vim.diagnostic.severity.HINT] = "h",
			[vim.diagnostic.severity.INFO] = "i",
		},
	},
	float = true, -- ??
	update_in_insert = false,
	severity_sort = true,
	jump = {
		float = true,
		wrap = true
	}
}

-- Ensure all the given formatters are installed
local format = package.loaded["conform"]
-- List of formatters to ignore during install
local ignore_install = {}

-- Helper function to find if value is in table.
local function table_contains(table, value)
	for _, v in ipairs(table) do
		if v == value then
			return true
		end
	end
	return false
end

-- Build a list of linters to install minus the ignored list.
local all_formatters = { "black", "isort", "shfmt", "stylelua" }
for _, v in pairs(format.formatters_by_ft) do
	for _, formatter in ipairs(v) do
		if not table_contains(ignore_install, formatter) then
			table.insert(all_formatters, formatter)
		end
	end
end

require("mason-conform").setup({
	-- List of formatters to ignore during install
	ensure_installed = all_formatters,
})

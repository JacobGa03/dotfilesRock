local options = {
	terminal = { provider = "none" },
}

require("claudecode").setup(options)

local function find_claude_pane()
	local win = vim.fn.system({ "tmux", "display-message", "-p", "#{window_id}" }):gsub("%s+$", "")
	local panes = vim.fn.system({ "tmux", "list-panes", "-t", win, "-F", "#{pane_id} #{pane_current_command}" })
	for pane_id, cmd in panes:gmatch("(%S+) (%S+)") do
		if cmd:match("^%d+%.%d+%.%d+$") or cmd == "claude" then
			return pane_id
		end
	end
	return nil
end

local function focus_claude_pane()
	local pane_id = find_claude_pane()
	if pane_id then
		vim.fn.system({ "tmux", "select-pane", "-t", pane_id })
	else
		vim.fn.system({ "tmux", "select-pane", "-t", "{last}" })
	end
end

local function send_to_claude_pane(text)
	local pane_id = find_claude_pane()
	if not pane_id then
		vim.notify("No Claude pane found", vim.log.levels.WARN)
		return
	end
	vim.fn.system({ "tmux", "load-buffer", "-b", "claudeq", "-" }, text)
	vim.fn.system({ "tmux", "paste-buffer", "-b", "claudeq", "-d", "-t", pane_id })
	vim.fn.system({ "tmux", "send-keys", "-t", pane_id, "Enter" })
end

vim.api.nvim_create_autocmd("User", {
	pattern = "ClaudeCodeSendComplete",
	callback = function()
		if vim.env.TMUX then
			focus_claude_pane()
		end
	end,
})

-- Ask Claude about selection with custom prompt
vim.keymap.set("v", "<leader>ccq", function()
	local prompt = vim.fn.input("Claude question: ")
	if prompt == "" then
		return
	end

	local start_line = vim.fn.getpos("'<")[2] - 1
	local end_line = vim.fn.getpos("'>")[2] - 1
	local start_col = vim.fn.getpos("'<")[3] - 1
	local end_col = vim.fn.getpos("'>")[3]

	local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line + 1, false)
	if start_line == end_line then
		lines[1] = lines[1]:sub(start_col + 1, end_col)
	else
		lines[1] = lines[1]:sub(start_col + 1)
		lines[#lines] = lines[#lines]:sub(1, end_col)
	end

	local selected_text = table.concat(lines, "\n")
	local message = prompt .. "\n\n" .. selected_text

	vim.fn.setreg("+", message)
	if vim.env.TMUX then
		send_to_claude_pane(message)
	else
		vim.notify("Not running in tmux; cannot send to Claude pane", vim.log.levels.WARN)
	end
end, { desc = "Ask Claude about selection" })

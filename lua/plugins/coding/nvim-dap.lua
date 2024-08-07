-- PLUGIN: nvim-dap
-- FUNCTIONALITY: debug for python
local map = vim.keymap.set
return {
	{
		"rcarriga/nvim-dap-ui",
		event = "VeryLazy",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		opts = {
			layouts = {
				{
					elements = {
						{
							id = "scopes",
							size = 0.60,
						},
						{
							id = "breakpoints",
							size = 0.2,
						},
						{
							id = "stacks",
							size = 0.10,
						},
						{
							id = "watches",
							size = 0.10,
						},
					},
					position = "right",
					size = 55,
				},
				{
					elements = {
						{
							id = "repl",
							size = 1.0,
						},
					},
					position = "bottom",
					size = 15,
				},
			},
		},
		config = function(_, opts)
			require("dapui").setup(opts)
		end,
	},
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			-- nvim-dap
			map("n", "<F5>", function()
				require("dap").continue()
			end, { desc = "DAP continue" })
			map("n", "<F10>", function()
				require("dap").step_over()
			end, { desc = "Step over" })
			map("n", "<F11>", function()
				require("dap").step_into()
			end, { desc = "Step into" })
			map("n", "<F12>", function()
				require("dap").step_out()
			end, { desc = "Step out" })
			map("n", "<leader>db", function()
				require("dap").toggle_breakpoint()
			end, { desc = "Toggle breqkpoint" })
			map("n", "<leader>ds", function()
				require("dap").set_breakpoint()
			end, { desc = "Set breakpoint" })
			map("n", "<leader>dr", function()
				require("dap").repl.open()
			end, { desc = "Open Repl" })

			map("n", "<leader>dt", function()
				require("dapui").toggle()
			end, { desc = "Toggle DAPui" })

			dap.adapters.python = {
				type = "executable",
				command = vim.g.python3_host_prog,
				args = { "-m", "debugpy.adapter" },
			}
			dap.configurations.python = {
				{
					-- The first three options are required by nvim-dap
					type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
					request = "launch",
					name = "Launch file",
					-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
					program = "${file}", -- This configuration will launch the current file if used.
					console = "internalConsole", --integratedTerminal",
					-- -- pythonPath = "~/miniconda3/envs/torch20/python.exe"
					-- pythonPath = function()
					--     local is_windows = function()
					--         return vim.loop.os_uname().sysname:find("Windows", 1, true) and true
					--     end
					--     local venv_path = os.getenv("CONDA_PREFIX")
					--     if venv_path then
					--         if is_windows() then
					--             return venv_path .. '\\python.exe'
					--         end
					--         return venv_path .. '/bin/python'
					--     end
					-- end
				},
			}
		end,
	},
}

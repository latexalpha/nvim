-- FUNCTION: debug for python
return {
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
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
					position = "left",
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
					-- -- pythonPath = "C:/Users/heihi/miniconda3/envs/torch20/python.exe"
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

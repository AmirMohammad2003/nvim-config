if vim.g.vscode then
	return {}
end

return {
	"mbbill/undotree",
	keys = {
		{
			mode = "n",
			"<Leader>U",
			function()
				vim.cmd.UndotreeToggle()
			end,
			desc = "Toggle undotree",
		},
	},
}

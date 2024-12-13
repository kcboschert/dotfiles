--[[
local highlight = {
  "CursorColumn",
  "Whitespace",
}
--]]

return {
	{
		"folke/snacks.nvim",
		opts = {
			indent = {
				-- your indent configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
		}
	},
	--[[
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      indent = { highlight = highlight, char = "" },
      whitespace = {
        highlight = highlight,
        remove_blankline_trail = false,
      },
      scope = { enabled = false },
    },
  },
	--]]
}

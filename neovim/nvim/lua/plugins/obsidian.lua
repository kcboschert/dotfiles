return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- latest release
  lazy = true,
  ft = "markdown",
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    workspaces = {
      {
        name = "Notes",
        path = "~/Notes",
      },
    },
    new_notes_location = "notes_subdir",
    daily_notes = {
      folder = "Daily",
      default_tags = { "daily" },
    },
    completion = {
      nvim_cmp = false,
      blink = true,
    },
    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will be given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'.
      -- You may have as many periods in the note ID as you'd like—the ".md" will be added automatically
      local suffix = ""
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. "-" .. suffix
    end,
    picker = { name = "snacks.pick" },
    sort_by = "accessed",
    ui = { enable = false },
    callbacks = {
      enter_note = function(_, note)
        vim.keymap.set("n", "gf", "<cmd>ObsidianFollowLink<cr>", {
          buffer = note.bufnr,
          desc = "Follow link under cursor",
        })
      end,
    },
  },
}

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true,
        number = true,
        spell = false,
        wrap = false,
        scrolloff = 10,
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      n = {
        L = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        H = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
        ["<Leader>r"] = { desc = "Competitive" },
        ["<Leader>rn"] = {
          function()
            local filename = vim.fn.input "Filename: "
            vim.cmd(string.format("!newc %s", filename))
          end,
          desc = "new",
        },
        ["<Leader>rr"] = { "<cmd>CompetiTest run<cr>", desc = "run testcases" },
        ["<Leader>rt"] = { "<cmd>CompetiTest receive testcases<cr>", desc = "retrieve testcases" },
        ["<Leader>ra"] = { "<cmd>CompetiTest add_testcase<cr>", desc = "add testcase" },
        ["<Leader>re"] = { "<cmd>CompetiTest edit_testcase<cr>", desc = "edit testcase" },
        ["<Leader>b"] = { desc = "Buffers" },
        ["<Leader>bD"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Pick to close",
        },
        ["<Leader>F"] = {
          function()
            if vim.opt.scrolloff._value ~= 10 then
              vim.opt.scrolloff = 10
            else
              vim.opt.scrolloff = 999
            end
          end,
          desc = "Keep cursor in middle",
        },
        -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
      },
      t = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
      },
    },
  },
}

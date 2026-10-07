return {
  "olimorris/codecompanion.nvim",
  config = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
     adapters = {
      http = {
        openai_chat = function()
          return require("codecompanion.adapters").extend("openai", {
            schema = {
              -- model = { default = "o3-mini-2025-01-31" },
            },
          })
        end,
      },
    },
    strategies = {
      chat = {
        adapter = "openai_chat",
        tools = {
          ["code_edit"] = {
            callback = "users.code_edit",
            description = "Update a buffer with the LLM's response",
          },
        },
        slash_commands = {
          ["file"] = {
            -- Location to the slash command in CodeCompanion
            callback = "strategies.chat.slash_commands.file",
            description = "Select a file using fzf",
            opts = {
              provider = "fzf_lua",
              contains_code = true,
            },
          },
          ["buffer"] = {
            -- Location to the slash command in CodeCompanion
            callback = "strategies.chat.slash_commands.buffer",
            description = "Select a buffer using fzf",
            opts = {
              provider = "fzf_lua",
              contains_code = true,
            },
          },
        },
      },
      inline = {
        adapter = "openai",
      },
    },
  }
}

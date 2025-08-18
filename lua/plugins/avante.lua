if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  "yetone/avante.nvim",
  opts = {
    provider = "claude",
    claude = {
      api_key_name = "cmd:bw get notes anthropic-api-key", -- the shell command must prefixed with `^cmd:(.*)`
      -- api_key_name = {"bw","get","notes","anthropic-api-key"}, -- if it is a table of string, then default to command.
    },
  },
}

-- thank you gemini
local keywords = { "anaconda3", "hatch" }
local function getPathFromKeyword(path)
  for _, keyword in ipairs(keywords) do
    -- Find the starting index of the keyword in the path
    -- The 'true' argument disables pattern matching so it reads as plain text
    local start_index = string.find(path, keyword, 1, true)
    if start_index then
      -- Return the substring from the keyword to the end of the string
      return string.sub(path, start_index)
    end
  end
  -- Return nil (or you could return the original path) if no keyword matches
  return path
end

return {
  "linux-cultist/venv-selector.nvim",
  cmd = "VenvSelect",
  opts = {
    options = {
      log_level = "NONE",
    },
    search = {
      mac_anaconda = {
        command = "$FD 'bin/python$' /opt/homebrew/anaconda3/envs/ --full-path --color never -I -a -L -E /proc -E .git/ -E .wine/ -E .steam/ -E Steam/ -E site-packages/",
        on_telescope_result_callback = getPathFromKeyword,
      },
      mac_hatch_pipx = {
        command = "$FD 'bin/python$' '/Users/marte/Library/Application Support/hatch/env/' --full-path --color never -I -a -L",
        on_telescope_result_callback = getPathFromKeyword,
      },
    },
  },
  --  Call config for Python files and load the cached venv automatically
  ft = "python",
  keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" } },
}

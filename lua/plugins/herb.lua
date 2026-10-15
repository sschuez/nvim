-- Herb ERB language server from the project-pinned mise tool
-- (npm:@herb-tools/language-server in .mise.toml), not Mason —
-- same pattern as ruby-lsp.lua.
--
-- Only some projects pin herb. Elsewhere the shim exits 1 with
-- "No version is set for shim", so ask mise whether the tool resolves
-- in this root before starting the server.
local shim = vim.fn.expand("~/.local/share/mise/shims/herb-language-server")

-- The shims are symlinks to the mise binary itself, so this is the mise
-- that owns them. nil when herb was never installed.
local mise = vim.uv.fs_realpath(shim)

local resolves = {}

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        herb_ls = {
          mason = false,
          cmd = { shim, "--stdio" },
          root_dir = function(bufnr, on_dir)
            if not mise then
              return
            end

            local root = vim.fs.root(bufnr, { "Gemfile", ".git" })
            if not root then
              return
            end

            if resolves[root] ~= nil then
              if resolves[root] then
                on_dir(root)
              end
              return
            end

            vim.system({ mise, "which", "herb-language-server" }, { cwd = root }, function(out)
              resolves[root] = out.code == 0
              if resolves[root] then
                vim.schedule(function()
                  on_dir(root)
                end)
              end
            end)
          end,
        },
      },
    },
  },
}

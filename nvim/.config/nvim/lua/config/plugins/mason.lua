return {
  {
    "williamboman/mason.nvim",
    lazy = false,     -- Load immediately to ensure PATH is set
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        -- LSP servers (matching your vim.lsp.enable() config)
        "lua-language-server",                 -- Lua LSP
        "gopls",                               -- Go LSP
        "typescript-language-server",          -- TypeScript LSP
        "intelephense",                        -- PHP LSP
        "tailwindcss-language-server",         -- Tailwind CSS LSP
        "html-lsp",                            -- HTML LSP
        "css-lsp",                             -- CSS LSP

        -- Formatters (for conform.nvim and general use)
        "stylua",
        "goimports",
        "prettier",

        -- Linters and diagnostics
        "golangci-lint",
        "eslint_d",
        "luacheck",         -- Lua linting

        -- Additional useful tools
        "delve",              -- Go debugger
        "shfmt",              -- Shell formatter
        "shellcheck",         -- Shell linter

        -- Optional but useful additions
        -- "markdownlint", -- Markdown linting
        -- "yamllint",     -- YAML linting
        -- "jsonlint",     -- JSON linting
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
    end,
  },
}

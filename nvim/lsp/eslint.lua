local get_monorepo_root = function(fname)
    local monorepo_markers = {
        ".git",
        "package.json",
        "pnpm-workspace.yaml",
        "lerna.json",
        "nx.json",
    }
    -- Try to find the root using common monorepo markers
    local root = util.root_pattern(unpack(monorepo_markers))(fname)
    if root then
        return root
    end

    -- Fallback to more explicit vim.fs.find (if on Neovim 0.7+)
    local found_root_file = vim.fs.find(monorepo_markers, { upward = true, path = fname })[1]
    if found_root_file then
        return vim.fs.dirname(found_root_file)
    end

    -- Final fallback to the current file's directory if no monorepo root is found
    return util.path.dirname(fname)
end

return {
    cmd = { "vscode-eslint-language-server", "--stdio" },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
        "vue",
        "svelte",
        "astro",
        "json",
        "jsonc",
    },
    root_markers = {
        ".git",
        "package-lock.json",
        ".eslintrc",
        ".eslintrc.js",
        ".eslintrc.json",
        ".eslintrc.yml",
        ".eslintrc.yaml",
        ".eslintrc.cjs",
        ".eslintrc.mjs",
        "tsconfig.json",
        "jsconfig.json",
    },
    settings = {
        validate = 'on',
        quiet = false,
        problems = {
            shortenToSingleLine = false,
        },
        experimental = {
            useFlagConfig = false,
        },
        -- nodePath configures the directory in which the eslint server should start its node_modules resolution.
        -- This path is relative to the workspace folder (root dir) of the server instance.
        nodePath = '',
        -- use the workspace folder location or the file location (if no workspace folder is open) as the working directory
        -- workingDirectory = { mode = 'location' },
        workingDirectory = {
            { mode = 'location' },
        }
    },
}

-- All configuration changes should go inside of the table below

-- You can think of a Lua "table" as a dictionary like data structure the
-- normal format is "key = value". These also handle array like data structures
-- where a value with no key simply has an implicit numeric key
local config = {

        -- Configure AstroNvim updates
        updater = {
                remote = "origin", -- remote to use
                channel = "stable", -- "stable" or "nightly"
                version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
                branch = "main", -- branch name (NIGHTLY ONLY)
                commit = nil, -- commit hash (NIGHTLY ONLY)
                pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
                skip_prompts = false, -- skip prompts about breaking changes
                show_changelog = true, -- show the changelog after performing an update
                auto_reload = false, -- automatically reload and sync packer after a successful update
                auto_quit = false, -- automatically quit the current session after a successful update
                -- remotes = { -- easily add new remotes to track
                --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
                --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
                --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
                -- ,
        },

        -- Set colorscheme to use
        colorscheme = "gruvbox",

        -- Add highlight groups in any theme
        highlights = {
                -- init = { -- this table overrides highlights in all themes
                --   Normal = { bg = "#000000" },
                -- }
                -- duskfox = { -- a table of overrides/changes to the duskfox theme
                --   Normal = { bg = "#000000" },
                -- },
        },

        -- set vim options here (vim.<first_key>.<second_key> = value)
        options = {
                opt = {
                        -- set to true or false etc.
                        guicursor = "",
                        relativenumber = true, -- sets vim.opt.relativenumber
                        number = true, -- sets vim.opt.number
                        spell = false, -- sets vim.opt.spell
                        signcolumn = "auto", -- sets vim.opt.signcolumn to auto
                        wrap = false, -- sets vim.opt.wrap
                        swapfile = false,
                        backup = false,
                        undodir = os.getenv "HOME" .. "/.vim/undodir",
                        undofile = true,
                        scrolloff = 8,
                        cursorline = true,
                        foldenable = false,
                        foldexpr = "nvim_treesitter#foldexpr()", -- set Treesitter based folding
                        foldmethod = "expr",
                },
                g = {
                        mapleader = " ", -- sets vim.g.mapleader
                        autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
                        cmp_enabled = true, -- enable completion at start
                        autopairs_enabled = true, -- enable autopairs at start
                        diagnostics_enabled = true, -- enable diagnostics at start
                        status_diagnostics_enabled = true, -- enable diagnostics in statusline
                        icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
                        ui_notifications_enabled = true, -- disable notifications when toggling UI elements
                        heirline_bufferline = true, -- enable new heirline based bufferline (requires :PackerSync after changing)
                },
        },
        -- If you need more control, you can use the function()...end notation
        -- options = function(local_vim)
        --   local_vim.opt.relativenumber = true
        --   local_vim.g.mapleader = " "
        --   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
        --   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
        --
        --   return local_vim
        -- end,

        -- Set dashboard header
        header = {
                " █████  ███████ ████████ ██████   ██████",
                "██   ██ ██         ██    ██   ██ ██    ██",
                "███████ ███████    ██    ██████  ██    ██",
                "██   ██      ██    ██    ██   ██ ██    ██",
                "██   ██ ███████    ██    ██   ██  ██████",
                " ",
                "    ███    ██ ██    ██ ██ ███    ███",
                "    ████   ██ ██    ██ ██ ████  ████",
                "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
                "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
                "    ██   ████   ████   ██ ██      ██",
        },

        -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
        diagnostics = {
                virtual_text = true,
                underline = true,
        },

        -- Extend LSP configuration
        lsp = {
                -- will be set up by rust-tools & the typescript plugin
                skip_setup = { "rust_analyzer", "tsserver" },
                -- enable servers that you already have installed without mason
                servers = {
                        -- "pyright"
                },
                formatting = {
                        -- control auto formatting on save
                        format_on_save = {
                                enabled = true, -- enable or disable format on save globally
                                allow_filetypes = { -- enable format on save for specified filetypes only
                                        -- "go",
                                },
                                ignore_filetypes = { -- disable format on save for specified filetypes
                                        -- "python",
                                },
                        },
                        disabled = { -- disable formatting capabilities for the listed language servers
                                -- "sumneko_lua",
                        },
                        timeout_ms = 1000, -- default format timeout
                        -- filter = function(client) -- fully override the default formatting function
                        --   return true
                        -- end
                },
                -- easily add or disable built in mappings added during LSP attaching
                mappings = {
                        n = {
                                -- ["<leader>lf"] = false -- disable formatting keymap
                        },
                },
                -- add to the global LSP on_attach function
                -- on_attach = function(client, bufnr)
                -- end,

                -- override the mason server-registration function
                -- server_registration = function(server, opts)
                --   require("lspconfig")[server].setup(opts)
                -- end,

                -- Add overrides for LSP server settings, the keys are the name of the server
                ["server-settings"] = {
                        -- example for addings schemas to yamlls
                        -- yamlls = { -- override table for require("lspconfig").yamlls.setup({...})
                        --   settings = {
                        --     yaml = {
                        --       schemas = {
                        --         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
                        --         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
                        --         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
                        --       },
                        --     },
                        --   },
                        -- },
                },
        },

        -- Mapping data with "desc" stored directly by vim.keymap.set().
        --
        -- Please use this mappings table to set keyboard mapping since this is the
        -- lower level configuration and more robust one. (which-key will
        -- automatically pick-up stored data by this setting.)
        mappings = {
                -- first key is the mode
                n = {
                        -- second key is the lefthand side of the map
                        -- mappings seen under group name "Buffer"
                        ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
                        ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
                        ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
                        ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
                        -- quick save
                        -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
                },
                t = {
                        -- setting a mapping to false will disable it
                        -- ["<esc>"] = false,
                },
        },

        -- Configure plugins
        plugins = {
                -- Customize Heirline options
                -- heirline = {
                --         -- -- Customize different separators between sections
                --         -- separators = {
                --         --   tab = { "", "" },
                --         -- },
                --         -- -- Customize colors for each element each element has a `_fg` and a `_bg`
                --         colors = function(colors)
                --                 colors.bg = "#282828"
                --                 colors.section_bg = "#282828"
                --                 colors.fg = "#458588"
                --                 colors.section_fg = "#458588"
                --                 return colors
                --         end,
                --         -- -- Customize attributes of highlighting in Heirline components
                --         attributes = {
                --                 -- styling choices for each heirline element, check possible attributes with `:h attr-list`
                --                 git_branch = { bold = true }, -- bold the git branch statusline component
                --                 mode = { bold = true },
                --         },
                --         -- -- Customize if icons should be highlighted
                --         icon_highlights = {
                --                 breadcrumbs = false, -- LSP symbols in the breadcrumbs
                --                 file_icon = {
                --                         winbar = false, -- Filetype icon in the winbar inactive windows
                --                         statusline = true, -- Filetype icon in the statusline
                --                 },
                --         },
                -- },
                init = {
                        -- You can disable default plugins as follows:
                        ["goolord/alpha-nvim"] = { disable = true },

                        -- You can also add new plugins here as well:
                        -- Add plugins, the packer syntax without the "use"
                        -- { "andweeb/presence.nvim" },
                        -- {
                        --   "ray-x/lsp_signature.nvim",
                        --   event = "BufRead",
                        --   config = function()
                        --     require("lsp_signature").setup()
                        --   end,
                        -- },

                        -- We also support a key value style plugin definition similar to NvChad:
                        -- ["ray-x/lsp_signature.nvim"] = {
                        --   event = "BufRead",
                        --   config = function()
                        --     require("lsp_signature").setup()
                        --   end,
                        -- },
                        -- pin function to the top
                        { "nvim-treesitter/nvim-treesitter-context" },
                        -- color scheme
                        { "ellisonleao/gruvbox.nvim" },
                        -- split maximizer
                        { "szw/vim-maximizer" },
                        --       -- Rust support
                        {
                                "simrat39/rust-tools.nvim",
                                after = { "mason-lspconfig.nvim" },
                                -- Is configured via the server_registration_override installed below!
                                config = function()
                                        require("rust-tools").setup {
                                                server = astronvim.lsp.server_settings "rust_analyzer",
                                                tools = {
                                                        inlay_hints = {
                                                                parameter_hints_prefix = "  ",
                                                                other_hints_prefix = "  ",
                                                        },
                                                },
                                        }
                                end,
                        },
                        {
                                "Saecki/crates.nvim",
                                after = "nvim-cmp",
                                config = function()
                                        require("crates").setup()
                                        astronvim.add_cmp_source { name = "crates", priority = 1100 }

                                        -- Crates mappings:
                                        local map = vim.api.nvim_set_keymap
                                        map("n", "<leader>Ct", ":lua require('crates').toggle()<cr>",
                                                { desc = "Toggle extra crates.io information" })
                                        map("n", "<leader>Cr", ":lua require('crates').reload()<cr>",
                                                { desc = "Reload information from crates.io" })
                                        map("n", "<leader>CU", ":lua require('crates').upgrade_crate()<cr>",
                                                { desc = "Upgrade a crate" })
                                        map("v", "<leader>CU", ":lua require('crates').upgrade_crates()<cr>",
                                                { desc = "Upgrade selected crates" })
                                        map("n", "<leader>CA", ":lua require('crates').upgrade_all_crates()<cr>",
                                                { desc = "Upgrade all crates" })
                                end,
                        },
                        -- typescript:
                        {
                                "jose-elias-alvarez/typescript.nvim",
                                after = "mason-lspconfig.nvim",
                                config = function() require("typescript").setup { server = astronvim.lsp.server_settings "tsserver" } end,
                        },
                        -- Tools
                        { "tpope/vim-fugitive" },
                        {
                                "kylechui/nvim-surround",
                                config = function() require("nvim-surround").setup {} end,
                        },
                        {
                                "ggandor/leap.nvim",
                                config = function() require("leap").set_default_keymaps() end,
                        },
                },
                -- All other entries override the require("<key>").setup({...}) call for default plugins
                ["null-ls"] = function(config) -- overrides `require("null-ls").setup(config)`
                        local null_ls = require "null-ls"
                        local vale = null_ls.builtins.diagnostics.vale
                        vale["filetypes"] = { "markdown", "tex", "asciidoc", "html" }
                        -- Check supported formatters and linters
                        config.sources = {
                                null_ls.builtins.code_actions.shellcheck,
                                -- Set a linter
                                null_ls.builtins.diagnostics.actionlint,
                                null_ls.builtins.diagnostics.eslint,
                                null_ls.builtins.diagnostics.fish,
                                null_ls.builtins.diagnostics.gitlint,
                                null_ls.builtins.diagnostics.luacheck,
                                null_ls.builtins.diagnostics.markdownlint,
                                null_ls.builtins.diagnostics.mypy,
                                null_ls.builtins.diagnostics.shellcheck,
                                vale,
                                null_ls.builtins.diagnostics.vulture,
                                null_ls.builtins.diagnostics.yamllint,
                                -- Set a formatter
                                null_ls.builtins.formatting.black,
                                null_ls.builtins.formatting.jq,
                                null_ls.builtins.formatting.prettier,
                                null_ls.builtins.formatting.shellharden,
                                null_ls.builtins.formatting.stylua,
                        }
                        return config
                        -- config variable is the default configuration table for the setup function call
                        -- local null_ls = require "null-ls"

                        -- Check supported formatters and linters
                        -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
                        -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
                        -- config.sources = {
                        -- Set a formatter
                        -- null_ls.builtins.formatting.stylua,
                        -- null_ls.builtins.formatting.prettier,
                        -- }
                        -- return config -- return final config table
                end,
                treesitter = { -- overrides `require("treesitter").setup(...)`
                        auto_install = true,
                        ensure_installed = {
                                "lua",
                                "vim",
                                "help",
                                "rust",
                                "typescript",
                                "tsx",
                                "javascript",
                                "kotlin",
                                "prisma",
                                "css",
                                "jsdoc",
                                "sql",
                                "scss",
                                "html",
                                "swift",
                                "markdown",
                        },
                },

                telescope = {
                        file_ignore_patterns = { "node_modules", ".idea" },
                },
                -- use mason-lspconfig to configure LSP installations
                ["mason-lspconfig"] = { -- overrides `require("mason-lspconfig").setup(...)`
                        ensure_installed = {
                                "tsserver",
                                "html",
                                "cssls",
                                "tailwindcss",
                                "sumneko_lua",
                                "emmet_ls",
                                "rust_analyzer",
                        },
                },
                -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
                ["mason-null-ls"] = { -- overrides `require("mason-null-ls").setup(...)`
                        ensure_installed = { "prettier", "stylua" },
                },
                ["mason-nvim-dap"] = { -- overrides `require("mason-nvim-dap").setup(...)`
                        -- ensure_installed = { "python" },
                },
        },

        -- LuaSnip Options
        luasnip = {
                -- Extend filetypes
                filetype_extend = {
                        -- javascript = { "javascriptreact" },
                },
                -- Configure luasnip loaders (vscode, lua, and/or snipmate)
                vscode = {
                        -- Add paths for including more VS Code style snippets in luasnip
                        paths = {},
                },
        },

        -- CMP Source Priorities
        -- modify here the priorities of default cmp sources
        -- higher value == higher priority
        -- The value can also be set to a boolean for disabling default sources:
        -- false == disabled
        -- true == 1000
        cmp = {
                source_priority = {
                        nvim_lsp = 1000,
                        luasnip = 750,
                        buffer = 500,
                        path = 250,
                },
        },

        -- Modify which-key registration (Use this with mappings table in the above.)
        ["which-key"] = {
                -- Add bindings which show up as group name
                register = {
                        -- first key is the mode, n == normal mode
                        n = {
                                -- second key is the prefix, <leader> prefixes
                                ["<leader>"] = {
                                        -- third key is the key to bring up next level and its displayed
                                        -- group name in which-key top level menu
                                        ["b"] = { name = "Buffer" },
                                },
                        },
                },
        },
        heirline = function(config)
                config[2] = nil
                return config
        end,

        -- This function is run last and is a good place to configuring
        -- augroups/autocommands and custom filetypes also this just pure lua so
        -- anything that doesn't fit in the normal config locations above can go here
        polish = function()
                local map = vim.api.nvim_set_keymap
                local unmap = vim.api.nvim_del_keymap
                unmap("n", "<leader>sm")
                map("n", "<leader>sm", ":MaximizerToggle<cr>", { desc = "close split" })

                vim.opt.background = "dark"
                -- Set up custom filetypes
                -- vim.filetype.add {
                --   extension = {
                --     foo = "fooscript",
                --   },
                --   filename = {
                --     ["Foofile"] = "fooscript",
                --   },
                --   pattern = {
                --     ["~/%.config/foo/.*"] = "fooscript",
                --   },
                -- }
        end,
}

return config

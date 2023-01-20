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
    },

    -- Set colorscheme to use
    colorscheme = "gruvbox",

    -- Add highlight groups in any theme
    highlights = {},

    -- set vim options here (vim.<first_key>.<second_key> = value)
    options = {
        opt = {
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
        servers = {},
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
        },
        -- easily add or disable built in mappings added during LSP attaching
        mappings = {
            n = {},
        },
        ["server-settings"] = {},
    },

    mappings = {
        -- first key is the mode
        n = {
            -- second key is the lefthand side of the map
            -- mappings seen under group name "Buffer"
            ["<leader>bb"] = {
                "<cmd>tabnew<cr>",
                desc = "New tab",
            },
            ["<leader>bc"] = {
                "<cmd>BufferLinePickClose<cr>",
                desc = "Pick to close",
            },
            ["<leader>bj"] = {
                "<cmd>BufferLinePick<cr>",
                desc = "Pick to jump",
            },
            ["<leader>bt"] = {
                "<cmd>BufferLineSortByTabs<cr>",
                desc = "Sort by tabs",
            },
        },
        t = {},
    },

    -- Customize Heirline options
    heirline = {
        colors = function(colors)
            colors.bg = "#282828"
            colors.section_bg = "#282828"
            colors.fg = "#458588"
            colors.section_fg = "#458588"
            return colors
        end,
        attributes = {
            git_branch = {
                bold = true,
            }, -- bold the git branch statusline component
            mode = {
                bold = true,
            },
        },
        -- -- Customize if icons should be highlighted
        icon_highlights = {
            breadcrumbs = false, -- LSP symbols in the breadcrumbs
            file_icon = {
                -- winbar = false, -- Filetype icon in the winbar inactive windows
                -- statusline = true, -- Filetype icon in the statusline
            },
        },
    },

    -- Configure plugins
    plugins = {
        ["heirline"] = function()
            return {
                -- Status line:
                {
                    hl = { fg = "fg", bg = "bg" },
                    astronvim.status.component.mode(),
                    astronvim.status.component.git_branch(),
                    astronvim.status.component.fill(),
                    astronvim.status.component.lsp(),
                    astronvim.status.component.treesitter(),
                    astronvim.status.component.nav { scrollbar = false, percentage = false, padding = { left = 1 } },
                    astronvim.status.component.mode { surround = { separator = "right" } },
                },
                -- Winbar:
                {
                    hl = { fg = "fg", bg = "bg" },
                    astronvim.status.component.file_info {
                        filename = { modify = ":p:." },
                        padding = { left = 1, right = 1 },
                    },
                    { provider = "::" },
                    astronvim.status.component.breadcrumbs { icon = { hl = true }, padding = { left = 1 } },
                    astronvim.status.component.fill(),
                    astronvim.status.component.git_diff(),
                    astronvim.status.component.diagnostics(),
                },
            }
        end,
        init = {
            -- You can disable default plugins as follows:
            ["goolord/alpha-nvim"] = {
                disable = true,
            },
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
                    astronvim.add_cmp_source {
                        name = "crates",
                        priority = 1100,
                    }

                    -- Crates mappings:
                    local map = vim.api.nvim_set_keymap
                    map("n", "<leader>Ct", ":lua require('crates').toggle()<cr>", {
                        desc = "Toggle extra crates.io information",
                    })
                    map("n", "<leader>Cr", ":lua require('crates').reload()<cr>", {
                        desc = "Reload information from crates.io",
                    })
                    map("n", "<leader>CU", ":lua require('crates').upgrade_crate()<cr>", {
                        desc = "Upgrade a crate",
                    })
                    map("v", "<leader>CU", ":lua require('crates').upgrade_crates()<cr>", {
                        desc = "Upgrade selected crates",
                    })
                    map("n", "<leader>CA", ":lua require('crates').upgrade_all_crates()<cr>", {
                        desc = "Upgrade all crates",
                    })
                end,
            },
            -- typescript:
            {
                "jose-elias-alvarez/typescript.nvim",
                after = "mason-lspconfig.nvim",
                config = function()
                    require("typescript").setup {
                        server = astronvim.lsp.server_settings "tsserver",
                    }
                end,
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

        ["null-ls"] = function(config) -- overrides `require("null-ls").setup(config)`
            local null_ls = require "null-ls"
            local vale = null_ls.builtins.diagnostics.vale
            vale["filetypes"] = { "markdown", "tex", "asciidoc", "html" }
            -- Check supported formatters and linters
            config.sources = {
                null_ls.builtins.code_actions.shellcheck, -- Set a linter
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
        ["mason-lspconfig"] = { -- overrides `require("mason-lspconfig").setup(...)`
            ensure_installed = { "tsserver", "html", "cssls", "tailwindcss", "sumneko_lua", "emmet_ls", "rust_analyzer" },
        },
        ["mason-null-ls"] = { -- overrides `require("mason-null-ls").setup(...)`
            ensure_installed = { "prettier", "stylua" },
        },
        ["mason-nvim-dap"] = { -- overrides `require("mason-nvim-dap").setup(...)`
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
        register = {
            n = {
                ["<leader>"] = {
                    ["b"] = {
                        name = "Buffer",
                    },
                },
            },
        },
    },

    polish = function()
        local map = vim.api.nvim_set_keymap
        local unmap = vim.api.nvim_del_keymap
        unmap("n", "<leader>sm")
        map("n", "<leader>sm", ":MaximizerToggle<cr>", {
            desc = "close split",
        })

        vim.opt.background = "dark"
    end,
}

return config

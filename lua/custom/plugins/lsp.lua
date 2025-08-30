-- LSP configuration
return {
  { 'folke/lazydev.nvim', ft = 'lua', opts = { library = { { path = '${3rd}/luv/library', words = { 'vim%.uv' } } } } },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      'saghen/blink.cmp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Diagnostic configuration
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            return diagnostic.message
          end,
        },
      }

      local lspconfig = require('lspconfig')
      local util = require('lspconfig.util')
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Use vue_ls as the Vue language server
      local vue_server = 'vue_ls'

      -- Resolve @vue/typescript-plugin from mason (with a safe fallback)
      local vue_plugin_location = vim.fn.stdpath('data') .. '/mason/packages/vue-language-server/node_modules/@vue/language-server'

      -- Monorepo-friendly root detector with sane fallback
      local function mono_root(fname)
        return util.root_pattern(
          'pnpm-workspace.yaml',
          'turbo.json',
          'lerna.json',
          'nx.json',
          'nuxt.config.ts',
          'nuxt.config.js',
          'tsconfig.json',
          'package.json',
          '.git'
        )(fname)
        or util.find_git_ancestor(fname)
        or util.path.dirname(fname)
      end

      -- TypeScript server with Vue support
      lspconfig.ts_ls.setup {
        capabilities = capabilities,
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
        root_dir = mono_root,
        init_options = {
          plugins = {
            {
              name = '@vue/typescript-plugin',
              location = vue_plugin_location,
              languages = { 'vue' },
            },
          },
        },
      }

      -- Vue language server (volar v3). Works with either 'vue_ls' or 'volar'
      lspconfig[vue_server].setup {
        capabilities = capabilities,
        filetypes = { 'vue' },
        init_options = { vue = { hybridMode = false } },
        root_dir = mono_root,
      }

      local servers = {
        -- CSS/SCSS support
        cssls = { filetypes = { 'css', 'scss', 'less' } },
        -- HTML support
        html = { filetypes = { 'html' } },
        -- Lua language server
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
            },
          },
        },
        -- Tailwind CSS support
        tailwindcss = {
          filetypes = { 'astro', 'astro-markdown', 'htmldjango', 'javascript', 'javascriptreact', 'markdown', 'svelte', 'typescript', 'typescriptreact', 'vue', 'html' }
        },
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
        'css-lsp',
        'html-lsp',
        'typescript-language-server',
        'vue-language-server',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      -- If you use mason-lspconfig handlers, skip these two so they aren't set up twice
      require('mason-lspconfig').setup {
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          function(server_name)
            if server_name == 'ts_ls' or server_name == 'vue_ls' or server_name == 'volar' then
              return
            end
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            lspconfig[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
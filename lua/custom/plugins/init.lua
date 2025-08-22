-- Custom plugins organized by category
return {
  -- Utility plugins
  'NMAC427/guess-indent.nvim',

  -- Import organized plugin modules
  { import = 'custom.plugins.ui' },
  { import = 'custom.plugins.telescope' },
  { import = 'custom.plugins.lsp' },
  { import = 'custom.plugins.coding' },
  { import = 'custom.plugins.git' },
}

local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
  'ansiblels',
  'bashls',
  'dockerls',
  'gopls', -- Golang
  'jedi_language_server', -- Python
  'jsonls',
  'marksman', -- Markdown
  'powershell_es',
  'sumneko_lua',
  'terraformls',
  'tsserver',
  'yamlls'
})

-- Fix Undefined global 'vim'
lsp.configure('sumneko_lua', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ['<C-Space>'] = cmp.mapping.complete(),
})

-- disable completion with tab
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
  suggest_lsp_servers = false,
})

lsp.on_attach(function(client, bufnr)
  require('custom-lsp.keymaps')
end)

lsp.setup()

local sev_text = function(diagnostic)
  if diagnostic.severity == vim.diagnostic.severity.ERROR then
    return 'ERROR'
  elseif diagnostic.severity == vim.diagnostic.severity.WARN then
    return 'WARN'
  elseif diagnostic.severity == vim.diagnostic.severity.INFO then
    return 'INFO'
  elseif diagnostic.severity == vim.diagnostic.severity.HINT then
    return 'HINT'
  end
end

local diag_text = function(diagnostic)
  local final_text = sev_text(diagnostic)
  if (IS_SHELL_FT) then
    final_text = final_text .. ' (' .. diagnostic.code .. ')'
  end
  final_text = final_text .. ': ' .. diagnostic.message
  return final_text
end

vim.diagnostic.config({
  virtual_text = false,
  signs = {
    severity = { min = vim.diagnostic.severity.WARN }
  },
  float = {
    header = '',
    border = 'single',
    format = function(diagnostic)
      return diag_text(diagnostic)
    end
  }
})


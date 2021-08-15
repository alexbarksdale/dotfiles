nnoremap <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <leader>gt <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <Leader>a <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap lc <cmd>lua vim.lsp.buf.incoming_calls()<CR>
nnoremap lr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap lo <cmd>lua vim.lsp.buf.outgoing_calls()<CR>
nnoremap li <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap lw <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap lb <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <S-k> <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <A-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
inoremap <A-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap [c <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap ]c <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <leader>gw :lua require('telescope').extensions.git_worktree.git_worktrees()<CR>

lua << EOF
local on_attach = function(client, bufnr)
    require "lsp_signature".setup({
        hint_prefix = "*"
    })
    require "lsp_signature".on_attach()
end

require'lspconfig'.tsserver.setup{ on_attach=on_attach }
require'lspconfig'.pyright.setup{ on_attach=on_attach }
require'lspconfig'.yamlls.setup{}
EOF

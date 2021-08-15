nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>gr <cmd>Telescope live_grep<cr>
nnoremap <leader>D <cmd>Telescope lsp_workspace_diagnostics<cr>
nnoremap <leader>d <cmd>Telescope lsp_document_diagnostics<cr>
nnoremap <leader>S <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
nnoremap <leader>s <cmd>Telescope lsp_document_symbols<cr>
nnoremap <leader>m <cmd>Telescope marks<cr>
nnoremap <leader>k <cmd>Telescope keymaps<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>

lua << EOF
require('telescope').setup{
    defaults = {
        layout_strategy = "vertical"
    }
}
EOF

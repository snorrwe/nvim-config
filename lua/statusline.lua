local lualine = require'lualine'

lualine.setup{
    options= {
        theme='neon',
        icons_enabled = false,
    },
    sections = {
        lualine_a = {'FugitiveHead' },
        lualine_c = { {  'filename', file_status=true, full_path=true } },
    },
    extensions = { 'fzf' }
}

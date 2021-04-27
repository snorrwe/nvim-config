local lualine = require'lualine'

lualine.setup{
    options= {
        theme='ayu_dark',
        icons_enabled = true,
    },
    sections = {
        lualine_a = {'FugitiveHead' },
        lualine_c = { {  'filename', file_status=true, full_path=true } },
    },
    extensions = { 'fzf' }
}

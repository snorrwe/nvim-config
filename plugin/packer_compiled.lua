-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "C:\\Users\\dkiss\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\share\\lua\\5.1\\?.lua;C:\\Users\\dkiss\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\share\\lua\\5.1\\?\\init.lua;C:\\Users\\dkiss\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\luarocks\\rocks-5.1\\?.lua;C:\\Users\\dkiss\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\luarocks\\rocks-5.1\\?\\init.lua"
local install_cpath_pattern = "C:\\Users\\dkiss\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\lua\\5.1\\?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Catppuccino.nvim"] = {
    loaded = true,
    path = "C:\\Users\\dkiss\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\Catppuccino.nvim",
    url = "https://github.com/Pocco81/Catppuccino.nvim"
  },
  ["bufferline.nvim"] = {
    loaded = true,
    path = "C:\\Users\\dkiss\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  ["coq.artifacts"] = {
    loaded = true,
    path = "C:\\Users\\dkiss\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\coq.artifacts",
    url = "https://github.com/ms-jpq/coq.artifacts"
  },
  coq_nvim = {
    loaded = true,
    path = "C:\\Users\\dkiss\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\coq_nvim",
    url = "https://github.com/ms-jpq/coq_nvim"
  },
  ["editorconfig-vim"] = {
    loaded = true,
    path = "C:\\Users\\dkiss\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\editorconfig-vim",
    url = "https://github.com/editorconfig/editorconfig-vim"
  },
  ["fern.vim"] = {
    loaded = true,
    path = "C:\\Users\\dkiss\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\fern.vim",
    url = "https://github.com/lambdalisue/fern.vim"
  },
  ["galaxyline.nvim"] = {
    loaded = true,
    path = "C:\\Users\\dkiss\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\galaxyline.nvim",
    url = "https://github.com/glepnir/galaxyline.nvim"
  },
  ["lsp_extensions.nvim"] = {
    loaded = true,
    path = "C:\\Users\\dkiss\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lsp_extensions.nvim",
    url = "https://github.com/tjdevries/lsp_extensions.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "C:\\Users\\dkiss\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "C:\\Users\\dkiss\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lspsaga.nvim",
    url = "https://github.com/glepnir/lspsaga.nvim"
  },
  ["nerd-galaxyline"] = {
    loaded = true,
    path = "C:\\Users\\dkiss\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nerd-galaxyline",
    url = "https://github.com/Avimitin/nerd-galaxyline"
  },
  nerdcommenter = {
    loaded = true,
    path = "C:\\Users\\dkiss\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nerdcommenter",
    url = "https://github.com/scrooloose/nerdcommenter"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "C:\\Users\\dkiss\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "C:\\Users\\dkiss\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "C:\\Users\\dkiss\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "C:\\Users\\dkiss\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "C:\\Users\\dkiss\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "C:\\Users\\dkiss\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "C:\\Users\\dkiss\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["symbols-outline.nvim"] = {
    loaded = true,
    path = "C:\\Users\\dkiss\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\symbols-outline.nvim",
    url = "https://github.com/simrat39/symbols-outline.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "C:\\Users\\dkiss\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["vifm.vim"] = {
    loaded = true,
    path = "C:\\Users\\dkiss\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vifm.vim",
    url = "https://github.com/vifm/vifm.vim"
  },
  ["vim-autoformat"] = {
    loaded = true,
    path = "C:\\Users\\dkiss\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-autoformat",
    url = "https://github.com/Chiel92/vim-autoformat"
  },
  ["vim-coloresque"] = {
    loaded = true,
    path = "C:\\Users\\dkiss\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-coloresque",
    url = "https://github.com/gko/vim-coloresque"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "C:\\Users\\dkiss\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "C:\\Users\\dkiss\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-rhubarb",
    url = "https://github.com/tpope/vim-rhubarb"
  },
  ["vim-smoothie"] = {
    loaded = true,
    path = "C:\\Users\\dkiss\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-smoothie",
    url = "https://github.com/psliwka/vim-smoothie"
  }
}

time([[Defining packer_plugins]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end

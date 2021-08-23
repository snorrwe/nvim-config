# Frenetiq NeoVim settings

## Install (Windows)

- Install neovim (0.6 nightly+)
- clone into your nvim directory (AppData/Local/nvim on Windows) `git clone https://github.com/snorrwe/nvim-config.git` 
- Init venv `python -m venv python3`
- Install the `neovim` python package in virtual environment
    ```
    python3/Scripts/activate
    pip install neovim pynvim
    ```
- Edit `init.vim` to your liking. Be sure to edit __HOME__ and __LLVM__
- Install plugins in vim `:PlugInstall`
- Install [Vifm](https://vifm.info/)
- Install [Telescope deps](https://github.com/nvim-telescope/telescope.nvim#optional-dependencies)
- Install LSPs
    - clangd
    - rust-analyser
    - etc.
- Install [Caskaydia Cove Nerd Font](https://www.nerdfonts.com/font-downloads) (optional)
- Profit


## Notes

Cached paths might cause probelms, try deleting the nvim_data directory

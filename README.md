# Frenetiq NeoVim settings

## Install (Windows)

- Install neovim
- clone into your nvim directory (AppData/Local/nvim on Windows) `git clone https://github.com/snorrwe/nvim-config.git` 
- Init venv `python -m venv python3`
- Install the `neovim` python package in virtual environment
    ```
    python3/Scripts/activate
    pip install neovim pynvim
    ```
- Install [CoC](https://github.com/neoclide/coc.nvim)
- Edit `init.vim` to your liking. Be sure to edit __HOME__ and __LLVM__
- Install plugins in vim `:PlugInstall`
- Install [Vifm](https://vifm.info/)
- Profit


## Notes

Cached paths might cause probelms, try deleting the nvim_data directory

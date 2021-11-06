# Frenetiq NeoVim settings

## Install (Windows)

-   Install neovim (0.6 nightly+)
-   clone into your nvim directory (`AppData/Local/nvim` on Windows, `~/.config/nvim` on Unix-like systems)
    e.g.
    ```
    cd ~/.config
    git clone https://github.com/snorrwe/nvim-config.git nvim
    ```
-   Init venv `python3 -m venv python3`
-   Install the `neovim` python package in virtual environment
    ```
    python3/bin/pip install wheel neovim pynvim
    ```
-   Edit `init.lua` to your liking. Be sure to edit **HOME**!
-  [Install packer](https://github.com/wbthomason/packer.nvim#quickstart)
-   Install plugins in vim
    `:PackerInstall`
    `:COQdeps`
-   Install [Vifm](https://vifm.info/)
-   Install [Telescope deps](https://github.com/nvim-telescope/telescope.nvim#optional-dependencies)
-   Install LSPs
    -   clangd
    -   rust-analyser
    -   etc.
-   Install [Caskaydia Cove Nerd Font](https://www.nerdfonts.com/font-downloads) (optional)
-   Profit

## Notes

Cached paths might cause probelms, try deleting the nvim_data directory

# nvim
My neovim setup

# Requirements
- npm
- ripgrep

# How to use this configuration
```bash
cd ~/.config/nvim
```
```bash
git clone https://github.com/igortxra/nvim.git .
```
```bash
. ./install.sh
```

# Directory structure
```
nvim
├── init.lua                  # Entry point for neovim (imports igortxra)
├── install.sh                # Installation Script
├── lua
│   └── igortxra
│       ├── colorscheme.lua   # Colorscheme used
│       ├── dap.lua           # Debugger configuration
│       ├── keymaps.lua       # Keyboard shortcuts
│       ├── lsp.lua           # Language Server Protocol
│       ├── options.lua       # Neovim options
│       └── plugins.lua       # Plugin manager and plugins configuration
└── plugin
    └── packer_compiled.lua
```

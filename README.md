# Kai's Neovim Configuration

**Personal Neovim dotfiles for Vue/Nuxt development at Ikigai & YourParkingSpace (minimum Vue 3)**

This is my personal Neovim configuration optimised for modern web development, with a focus on Vue.js, Nuxt.js, and TypeScript. Built for my work at [Ikigai](https://ikigai.agency), a web development agency specializing in Vue/Nuxt applications.

## Features

- **Vue/Nuxt Optimized**: Tailored LSP configuration for Vue SFC files and Nuxt projects
- **Monorepo Friendly**: Smart root detection for complex project structures
- **Modern Tooling**: Blink.cmp for completion, Telescope for fuzzy finding, Treesitter for syntax highlighting
- **TypeScript Ready**: Full TypeScript support with intelligent Vue integration
- **Developer Experience**: Carefully crafted keybindings and workflows for efficient coding

## Key Components

- **LSP**: Configured for TypeScript/JavaScript (vtsls) and Vue (vue-language-server) with monorepo support
- **Completion**: Blink.cmp with intelligent suggestions and snippets
- **File Navigation**: Telescope with custom keybindings optimized for Vue projects  
- **Syntax**: Treesitter with Vue, TypeScript, and web technology parsers
- **Git Integration**: Fugitive and other git tools for version control workflows
- **Terminal**: Integrated terminal support for development workflows

## Installation

```bash
git clone https://github.com/kaimacmaster/dotfiles.nvim ~/.config/nvim
```

## Structure

```
├── init.lua              # Entry point
├── lua/custom/
│   ├── keymaps.lua       # Custom keybindings
│   ├── options.lua       # Vim options and settings
│   └── plugins/          # Plugin configurations
│       ├── lsp.lua       # LSP setup (Vue/TS optimized)
│       ├── completion.lua # Blink.cmp configuration
│       └── ...
```

## Vue/Nuxt Specific Features

- Intelligent component navigation and auto-completion
- Nuxt auto-imports and composables support
- Vue SFC template/script/style block navigation
- Tailwind CSS integration for utility-first styling
- Monorepo workspace detection for complex Vue projects

### Getting Started

This configuration works best with Neovim 0.11+. Make sure you have the following dependencies installed:

- **Neovim** (>= 0.10)
- **Git** (for plugin management)
- **Node.js** (for LSP servers)
- **fd** or **find** (for Telescope)
- **ripgrep** (for searching)

### Customization

Feel free to fork and modify this configuration to suit your needs. The structure is modular and designed to be easily customizable:

- Add new plugins in `lua/custom/plugins/`
- Modify keybindings in `lua/custom/keymaps.lua`
- Adjust settings in `lua/custom/options.lua`

### Vue/Nuxt Development Tips

- Use `grd` on imports to jump to definitions across your project
- `:LspInfo` to verify TypeScript and Vue language servers are attached
- `<leader>my` to yank Neovim messages to system clipboard for debugging
- Telescope shortcuts optimized for Vue project navigation

---

### Install Recipes

Below you can find OS specific install instructions for Neovim and dependencies.

#### Windows Installation

<details><summary>Windows with Microsoft C++ Build Tools and CMake</summary>
Installation may require installing build tools and updating the run command for `telescope-fzf-native`

See `telescope-fzf-native` documentation for [more details](https://github.com/nvim-telescope/telescope-fzf-native.nvim#installation)

This requires:

- Install CMake and the Microsoft C++ Build Tools on Windows

```lua
{'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
```
</details>
<details><summary>Windows with gcc/make using chocolatey</summary>
Alternatively, one can install gcc and make which don't require changing the config,
the easiest way is to use choco:

1. install [chocolatey](https://chocolatey.org/install)
either follow the instructions on the page or use winget,
run in cmd as **admin**:
```
winget install --accept-source-agreements chocolatey.chocolatey
```

2. install all requirements using choco, exit the previous cmd and
open a new one so that choco path is set, and run in cmd as **admin**:
```
choco install -y neovim git ripgrep wget fd unzip gzip mingw make
```
</details>
<details><summary>WSL (Windows Subsystem for Linux)</summary>

```
wsl --install
wsl
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
```
</details>

#### Linux Install
<details><summary>Ubuntu Install Steps</summary>

```
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
```
</details>
<details><summary>Debian Install Steps</summary>

```
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip curl

# Now we install nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo mkdir -p /opt/nvim-linux-x86_64
sudo chmod a+rX /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

# make it available in /usr/local/bin, distro installs to /usr/bin
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/
```
</details>
<details><summary>Fedora Install Steps</summary>

```
sudo dnf install -y gcc make git ripgrep fd-find unzip neovim
```
</details>

<details><summary>Arch Install Steps</summary>

```
sudo pacman -S --noconfirm --needed gcc make git ripgrep fd unzip neovim
```
</details>

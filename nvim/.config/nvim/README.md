This is my personal neovim configuration that I use mostly for web development (typescript/React.js).

## Screenshots

## Getting started

### Requirements

- [neovim nightly (v0.7)](https://github.com/neovim/neovim/wiki/Installing-Neovim)
- [BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep#installation) (Optional - telescope's `live_grep` and `grep_string` features require it)
- [xclip]() (Optional - )
- a [nerd font](https://www.nerdfonts.com) (Optional - for icons)
- [prettierd](https://github.com/fsouza/prettierd) (Optional - for auto-formatting with prettier)
- [sqlite3](https://www.sqlite.org/index.html) (For smart telescope history)

### Installation

My configuration is based on [NvChad](https://github.com/NvChad/NvChad). Follow [their instructions](https://nvchad.github.io/getting-started/setup) and install it.
Then copy the `lua/custom` directory into your neovim configuration directory (`~/.config/nvim` in Linux):

```bash
git clone https://github.com/ahhshm/nvim
cp -r nvim/lua/custom ~/.config/nvim/lua/custom
```

The final folder structure should be something like this:

```
nvim
├── init.lua
├── LICENSE
├── lua
│   ├── colors
│   ├── core
│   ├── custom
│   └── plugins
```

## TODO

- [ ] setup `nvim-dap` for javascript and Rust
- [x] add `todo-comments.nvim` snippets
- [x] add more snippets for Rust
- [ ] lazy-load some of the custom plugins
- [ ] lazy-load plugin-specific keymaps
- [ ] remove `rafamadriz/friendly-snippets` when it's possible

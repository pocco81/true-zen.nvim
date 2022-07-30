<p align="center">
  <h2 align="center">🦝 true-zen.nvim</h2>
</p>

<p align="center">
	Clean and elegant distraction-free writing for NeoVim
</p>

<p align="center">
	<a href="https://github.com/Pocco81/true-zen.nvim/stargazers">
		<img alt="Stars" src="https://img.shields.io/github/stars/Pocco81/true-zen.nvim?style=for-the-badge&logo=starship&color=C9CBFF&logoColor=D9E0EE&labelColor=302D41"></a>
	<a href="https://github.com/Pocco81/true-zen.nvim/issues">
		<img alt="Issues" src="https://img.shields.io/github/issues/Pocco81/true-zen.nvim?style=for-the-badge&logo=bilibili&color=F5E0DC&logoColor=D9E0EE&labelColor=302D41"></a>
	<a href="https://github.com/Pocco81/true-zen.nvim">
		<img alt="Repo Size" src="https://img.shields.io/github/repo-size/Pocco81/true-zen.nvim?color=%23DDB6F2&label=SIZE&logo=codesandbox&style=for-the-badge&logoColor=D9E0EE&labelColor=302D41"/></a>
</p>

&nbsp;

<!-- <p align="center"> -->
<!-- </p> -->

https://user-images.githubusercontent.com/58336662/181860318-8834446a-e28f-4a75-acdc-c880082ef3a8.mp4

&nbsp;

### 📋 Features

-   has 4 different modes to unclutter your screen:
    -   Ataraxis: good ol' zen mode
    -   Minimalist: disable ui components (e.g. numbers, tabline, statusline)
    -   Narrow: narrow a text region for better focus
    -   Focus: focus the current window
-   customizable lua callbacks for each mode
-   works out of the box
-   integratons:
    -   [tmux](https://github.com/tmux/tmux)
    -   [kitty](https://sw.kovidgoyal.net/kitty/)
    -   [twilight.nvim](https://github.com/folke/twilight.nvim)

&nbsp;

### 📚 Requirements

-   Neovim >= 0.5.0

&nbsp;

### 📦 Installation

Install the plugin with your favourite package manager:

<details>
	<summary><a href="https://github.com/wbthomason/packer.nvim">Packer.nvim</a></summary>

```lua
use({
	"Pocco81/true-zen.nvim",
	config = function()
		 require("true-zen").setup {
			-- your config goes here
			-- or just leave it empty :)
		 }
	end,
})
```

</details>

<details>
	<summary><a href="https://github.com/junegunn/vim-plug">vim-plug</a></summary>

```vim
Plug 'Pocco81/true-zen.nvim'
lua << EOF
	require("true-zen").setup {
		-- your config goes here
		-- or just leave it empty :)
	}
EOF
```

</details>

&nbsp;

### ⚙️ Configuration

true-zen comes with the following defaults:

```lua
{
	modes = { -- configurations per mode
		ataraxis = {
			shade = "dark", -- if `dark` then dim the padding windows, otherwise if it's `light` it'll brighten said windows
			backdrop = 0, -- percentage by which padding windows should be dimmed/brightened. Must be a number between 0 and 1. Set to 0 to keep the same background color
			minimum_writing_area = { -- minimum size of main window
				width = 70,
				height = 44,
			},
			quit_untoggles = true, -- type :q or :qa to quit Ataraxis mode
			padding = { -- padding windows
				left = 52,
				right = 52,
				top = 0,
				bottom = 0,
			},
			open_callback = nil, -- run a function when opening Ataraxis mode
			close_callback = nil, -- run a function when closing Ataraxis mode
		},
		minimalist = {
			ignored_buf_types = { "nofile" }, -- save current options from any window except ones displaying these kinds of buffers
			options = { -- options to be disabled when entering Minimalist mode
				number = false,
				relativenumber = false,
				showtabline = 0,
				signcolumn = "no",
				statusline = "",
				cmdheight = 1,
				laststatus = 0,
				showcmd = false,
				showmode = false,
				ruler = false,
				numberwidth = 1
			},
			open_callback = nil, -- run a function when opening Minimalist mode
			close_callback = nil, -- run a function when closing Minimalist mode
		},
		narrow = {
			--- change the style of the fold lines. Set it to:
			--- `informative`: to get nice pre-baked folds
			--- `invisible`: hide them
			--- function() end: pass a custom func with your fold lines. See :h foldtext
			folds_style = "informative",
			run_ataraxis = true, -- display narrowed text in a Ataraxis session
			open_callback = nil, -- run a function when opening Narrow mode
			close_callback = nil, -- run a function when closing Narrow mode
		},
		focus = {
			open_callback = nil, -- run a function when opening Focus mode
			close_callback = nil, -- run a function when closing Focus mode
		}
	},
	integrations = {
		tmux = false, -- hide tmux status bar in (minimalist, ataraxis)
		kitty = { -- increment font size in Kitty. Note: you must set `allow_remote_control socket-only` and `listen_on unix:/tmp/kitty` in your personal config (ataraxis)
			enabled = false,
			font = "+3"
		},
		twilight = false -- enable twilight (ataraxis)
	},
}
```

Additionally you may want to set up some key mappings for each true-zen mode:

```lua
local api = vim.api

api.nvim_set_keymap("n", "<leader>n", ":TZNarrow<CR>", {})
api.nvim_set_keymap("v", "<leader>n", ":'<,'>TZNarrow<CR>", {})
api.nvim_set_keymap("n", "<leader>n", ":TZFocus<CR>", {})
api.nvim_set_keymap("n", "<leader>n", ":TZMinimalist<CR>", {})
api.nvim_set_keymap("n", "<leader>n", ":TZAtaraxis<CR>", {})
```

&nbsp;

### 🪴 Usage

-   `TZAtaraxis`: toggle ataraxis mode
-   `TZMinimalist`: toggle minimalist mode
-   `TZNarrow`: toggle narrow mode
-   `TZFocus`: toggle focus mode

&nbsp;

### 📜 License

Koy is released under the MIT license, which grants the following permissions:

-   Commercial use
-   Distribution
-   Modification
-   Private use

For more convoluted language, see the [LICENSE](https://github.com/true-zen.nvim/true-zen.nvim/blob/main/LICENSE).

&nbsp;

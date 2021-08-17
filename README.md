<h1 align="center">🦝 TrueZen.nvim</h1>

<p align="center">
	Clean and elegant distraction-free writing for NeoVim.
</p>

<p align="center">
    <a href="https://github.com/Pocco81/TrueZen.nvim"
        ><img
            src="https://img.shields.io/github/repo-size/Pocco81/TrueZen.nvim?style=flat-square"
            alt="GitHub repository size"
    /></a>
    <a href="https://github.com/Pocco81/TrueZen.nvim/issues"
        ><img
            src="https://img.shields.io/github/issues/Pocco81/TrueZen.nvim?style=flat-square"
            alt="Issues"
    /></a>
    <a href="https://github.com/Pocco81/TrueZen.nvim/blob/main/LICENSE"
        ><img
            src="https://img.shields.io/github/license/Pocco81/TrueZen.nvim?style=flat-square"
            alt="License"
    /><br />
    <a href="https://saythanks.io/to/Pocco81%40gmail.com"
        ><img
            src="https://img.shields.io/badge/say-thanks-modal.svg?style=flat-square"
            alt="Say thanks"/></a
    ></a>    <a href="https://github.com/Pocco81/whid.nvim/commits/main"
    <a href="https://github.com/Pocco81/TrueZen.nvim/commits/main"
		><img
			src="https://img.shields.io/github/last-commit/Pocco81/TrueZen.nvim?style=flat-square"
			alt="Latest commit"
    /></a>
    <a href="https://github.com/Pocco81/TrueZen.nvim/stargazers"
        ><img
            src="https://img.shields.io/github/stars/Pocco81/TrueZen.nvim?style=flat-square"
            alt="Repository's starts"
    /></a>
</p>


<kbd><img src ="https://i.imgur.com/yIimuJF.png"></kbd>
<p align="center">
	Ataraxis Mode
</p><hr>

<kbd><img src ="https://i.imgur.com/3PpBwSB.png"></kbd>
<p align="center">
	Minimalist Mode
</p><hr>

<kbd><img src ="https://i.imgur.com/atGxfOm.gif"></kbd>
<p align="center">
	Focus Mode
</p>


# TL;DR

<div style="text-align: justify">
	TrueZen.nvim is a NeoVim plugin written in Lua that aims to provide a cleaner and less cluttered interface [than usual] when toggled in either of it's three different modes (Ataraxis, Minimalist and Focus). It can be installed with your favorite plugin manager and has some sane defaults so that you can just execute ':TZAtaraxis' to get started!
</div>

# 🌲 Table of Contents

* [Features](#-features)
* [Notices](#-notices)
* [Installation](#-installation)
	* [Prerequisites](#prerequisites)
	* [Adding the plugin](#adding-the-plugin)
	* [Setup Configuration](#setup-configuration)
		* [For init.lua](#for-initlua)
		* [For init.vim](#for-initvim)
	* [Updating](#updating)
* [Usage (commands)](#-usage-commands)
	* [Default](#default)
	+ [UI Elements](#ui-elements)
	+ [On/Off](#onoff)
* [Configuration](#-configuration)
	+ [UI](#ui)
	+ [Modes](#modes)
		+ [Ataraxis](#ataraxis)
		+ [Focus](#focus)
	* [Integrations](#integrations)
	* [Misc](#misc)
	* [Events](#events)
* [Key Bindings](#-key-bindings)
* [Contribute](#-contribute)
* [Inspirations](#-inspirations)
* [License](#-license)
* [FAQ](#-faq)
* [To-Do](#-to-do)

# 🎁 Features
+ Can deactivate UI components separately
	+ Left: (relative)numbers, signcolumn
	+ Top: tabline
	+ Bottom: laststatus, ruler, showmode, showcmd, cmdheight
+ Three different modes!
	+ Minimalist mode: hides UI components.
	+ Focus mode: maximizes current window. (has two different focusing methods)
	+ Ataraxis mode: same as 'Minimalist mode' but adds "padding" and other cool stuff (e.g. setting an ideal writing area width).
		+ Padding can be set manually or automatically.
+ Highly customizable
+ Custom cursor that changes shape according to current vi-mode
+ You can still cycle through open buffers even when you can't see them in the UI
+ Non nonsensical
+ Can launch at startup if needed
+ Can execute code at certain events
+ Integrations with other plugins/stuff
	+ [vim-airline](https://github.com/vim-airline/vim-airline)
	+ [Tmux](https://github.com/tmux/tmux)
	+ [galaxyline.nvim](https://github.com/glepnir/galaxyline.nvim)
	+ [Powerline](https://github.com/powerline/powerline)
	+ [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
	+ [nvim-bufferline.lua](https://github.com/akinsho/nvim-bufferline.lua)
	+ [express_line.nvim](https://github.com/tjdevries/express_line.nvim)
	+ [vim-gitgutter](https://github.com/airblade/vim-gitgutter)
	+ [vim-signify](https://github.com/mhinz/vim-signify)
	+ [limelight.vim](https://github.com/junegunn/limelight.vim)
	+ [lightline.vim](https://github.com/itchyny/lightline.vim)
	+ [twilight.nvim](https://github.com/folke/twilight.nvim)
	+ [lualine.nvim](https://github.com/hoob3rt/lualine.nvim)

# 📺 Notices

<ul>
  <li><b>19-07-21</b>: Feat #56: added lightline.vim integration.</li>
  <li><b>19-07-21</b>: Feat (#53): resize Ataraxis padding when nvim's size changes!.</li>
  <li><b>15-07-21</b>: Fixed #54: only set win opts for TrueZen windows.</li>
  <li><b>15-07-21</b>: After #50, assert the possibility of performing operations by `<something>On\Off` commands.</li>
</ul>

<details>
<summary>Old notices...</summary>
<p>
<ul>
  <li><b>27-07-21</b>: Added Twilight.nvim integration (requested by #47).</li>
  <li><b>19-07-21</b>: Fix #46.</li>
  <li><b>15-07-21</b>: Added feature #45. Now the `custom_bg` setting changed.</li>
  <li><b>21-07-21</b>: Fix #41, #42, #43 and #44</li>
  <li><b>19-07-21</b>: Feat #49 added.</li>
  <li><b>15-07-21</b>: Fixed #36.</li>
  <li><b>14-07-21</b>: Added feature requested by #35.</li>
  <li><b>06-07-21</b>: Added lualine integration.</li>
  <li><b>03-07-21</b>: Fixed #31</li>
  <li><b>30-06-21</b>: Everything was refactored, improved and simplified.</li>
  <li><b>29-06-21</b>: Added nvim-bufferline.lua integration + Ataraxis mode doesn't break anymore if the window layout changes.</li>
  <li><b>19-06-21</b>: Fixed bug with Focus mode.</li>
  <li><b>18-06-21</b>: Fixed small bugs with various features (hi groups, storing settings, ...)</li>
  <li><b>04-06-21</b>: Added setting for controlling Hi Groups affected by TrueZen.</li>
  <li><b>03-06-21</b>: Added events for the mode Focus.</li>
  <li><b>28-05-21</b>: Added option to keep default fold fillchars.</li>
  <li><b>08-05-21</b>: Added option for using :q to untoggle Ataraxis.</li>
  <li><b>06-05-21</b>: Added option for setting arbitrary padding for each one of the sides before entering Ataraxis. Also, fixed Galaxyline bug.</li>
  <li><b>05-05-21</b>: Added option for storing and restoring user settings for Minimalist mode, Ataraxis mode and UI related.</li>
</ul>
</p>
</details>


# 📦 Installation

## Prerequisites

- [NeoVim nightly](https://github.com/neovim/neovim/releases/tag/nightly) (>=v0.5.0)

## Adding the plugin
You can use your favorite plugin manager for this. Here are some examples with the most popular ones:

### Vim-plug

```lua
Plug 'Pocco81/TrueZen.nvim'
```
### Packer.nvim

```lua
use "Pocco81/TrueZen.nvim"
```

### Vundle

```lua
Plugin 'Pocco81/TrueZen.nvim'
```

### NeoBundle
```lua
NeoBundleFetch 'Pocco81/TrueZen.nvim'
```

## Setup (configuration)
These are the default settings:

```lua
ui = {
	bottom = {
		laststatus = 0,
		ruler = false,
		showmode = false,
		showcmd = false,
		cmdheight = 1,
	},
	top = {
		showtabline = 0,
	},
	left = {
		number = false,
		relativenumber = false,
		signcolumn = "no",
	},
},
modes = {
	ataraxis = {
		left_padding = 32,
		right_padding = 32,
		top_padding = 1,
		bottom_padding = 1,
		ideal_writing_area_width = {0},
		auto_padding = true,
		keep_default_fold_fillchars = true,
		custom_bg = {"none", ""},
		bg_configuration = true,
		quit = "untoggle",
		ignore_floating_windows = true,
		affected_higroups = {NonText = {}, FoldColumn = {}, ColorColumn = {}, VertSplit = {}, StatusLine = {}, StatusLineNC = {}, SignColumn = {}}
	},
	focus = {
		margin_of_error = 5,
		focus_method = "experimental"
	},
},
integrations = {
	vim_gitgutter = false,
	galaxyline = false,
	tmux = false,
	gitsigns = false,
	nvim_bufferline = false,
	limelight = false,
	twilight = false,
	vim_airline = false,
	vim_powerline = false,
	vim_signify = false,
	express_line = false,
	lualine = false,
	lightline = false
},
misc = {
	on_off_commands = false,
	ui_elements_commands = false,
	cursor_by_mode = false,
}
```

The way you setup the settings on your config varies on whether you are using vimL for this or Lua.

<details>
    <summary>For init.lua</summary>
<p>

```lua
local true_zen = require("true-zen")

true_zen.setup({
	ui = {
		bottom = {
			laststatus = 0,
			ruler = false,
			showmode = false,
			showcmd = false,
			cmdheight = 1,
		},
		top = {
			showtabline = 0,
		},
		left = {
			number = false,
			relativenumber = false,
			signcolumn = "no",
		},
	},
	modes = {
		ataraxis = {
			left_padding = 32,
			right_padding = 32,
			top_padding = 1,
			bottom_padding = 1,
			ideal_writing_area_width = {0},
			auto_padding = true,
			keep_default_fold_fillchars = true,
			custom_bg = {"none", ""},
			bg_configuration = true,
			quit = "untoggle",
			ignore_floating_windows = true,
			affected_higroups = {NonText = {}, FoldColumn = {}, ColorColumn = {}, VertSplit = {}, StatusLine = {}, StatusLineNC = {}, SignColumn = {}}
		},
		focus = {
			margin_of_error = 5,
			focus_method = "experimental"
		},
	},
	integrations = {
		vim_gitgutter = false,
		galaxyline = false,
		tmux = false,
		gitsigns = false,
		nvim_bufferline = false,
		limelight = false,
		twilight = false,
		vim_airline = false,
		vim_powerline = false,
		vim_signify = false,
		express_line = false,
		lualine = false,
		lightline = false
	},
	misc = {
		on_off_commands = false,
		ui_elements_commands = false,
		cursor_by_mode = false,
	}
})
```
<br />
</details>


<details>
    <summary>For init.vim</summary>
<p>

```lua
lua << EOF
local true_zen = require("true-zen")

true_zen.setup({
	ui = {
		bottom = {
			laststatus = 0,
			ruler = false,
			showmode = false,
			showcmd = false,
			cmdheight = 1,
		},
		top = {
			showtabline = 0,
		},
		left = {
			number = false,
			relativenumber = false,
			signcolumn = "no",
		},
	},
	modes = {
		ataraxis = {
			left_padding = 32,
			right_padding = 32,
			top_padding = 1,
			bottom_padding = 1,
			ideal_writing_area_width = {0},
			auto_padding = true,
			keep_default_fold_fillchars = true,
			custom_bg = {"none", ""},
			bg_configuration = true,
			quit = "untoggle",
			ignore_floating_windows = true,
			affected_higroups = {NonText = {}, FoldColumn = {}, ColorColumn = {}, VertSplit = {}, StatusLine = {}, StatusLineNC = {}, SignColumn = {}}
		},
		focus = {
			margin_of_error = 5,
			focus_method = "experimental"
		},
	},
	integrations = {
		vim_gitgutter = false,
		galaxyline = false,
		tmux = false,
		gitsigns = false,
		nvim_bufferline = false,
		limelight = false,
		twilight = false,
		vim_airline = false,
		vim_powerline = false,
		vim_signify = false,
		express_line = false,
		lualine = false,
		lightline = false
	},
	misc = {
		on_off_commands = false,
		ui_elements_commands = false,
		cursor_by_mode = false,
	}
})
EOF
```
<br />
</details>

For instructions on how to configure the plugin, check out the [configuration](#configuration) section.

## Updating
This depends on your plugin manager. If, for example, you are using Packer.nvim, you can update it with this command:
```lua
:PackerUpdate
```

# 🤖 Usage (commands)
All the commands follow the *camel casing* naming convention and have the `TZ` prefix so that it's easy to remember that they are part of this plugin. These are all of them:

## Default
- `:TZMinimalist` toggles Minimalist mode. Activates/deactivates NeoVim's UI components from the left, bottom and top of NeoVim on all the buffers you enter in the current session.
- `:TZFocus` toggles Focus mode. Maximizes/minimizes the current window.
- `:TZAtaraxis` toggles Ataraxis mode. Ataraxis is kind of a "super extension" of Minimalist mode that uses it for deactivating UI components, however, it also provides padding to all buffers in the current session + makes use of the different integrations. Furthermore, you could also set values for the padding of the left (`l`), right (`r`), top (`t`), and bottom (`b`) of the Ataraxis instance you are about to spawn. This values are optional and when given their equivalent from the config is ignored. They should be separated by spaces and the format they should have is: `<(l)eft/(r)ight>/(t)op/(b)ottom<number_of_cells>`. Here is an example:

```
:TZAtaraxis l10 r10 t3 b1
```
Note: it's not mandatory to give all four of them.

## UI Elements
- `:TZBottom` toggles the bottom part of NeoVim's UI. It toggles: laststatus, ruler, showmode, showcmd, and cmdheight.
- `:TZTop` toggles the top part of NeoVim's UI. It toggles: tabline.
- `:TZLeft` toggles the left part of NeoVim's UI. It toggles: numbers, relative numbers, and signcolumn.

## On/Off
- `:TZAtaraxisOn` turns on Ataraxis mode.
- `:TZAtaraxisOff` turns off Ataraxis mode.
- `:TZMinimalistOn` turns on Minimalist mode.
- `:TZMinimalistOff` turns off Minimalist mode.
- `:TZFocusOn` turns on Focus mode
- `:TZFocusOff` turns off Focus mode

The following commands are enabled is the `ui_elements_commands` setting is set to true as well:

- `:TZBottomOn` show bottom UI parts.
- `:TZBottomOff` hide bottom UI parts.
- `:TZTopOn` show top UI parts.
- `:TZTopOff` hide top UI parts.
- `:TZLeftOn` show left UI parts.
- `:TZLeftOff` hide left UI parts

# 🍉 Configuration
Although settings already have self-explanatory names, here is where you can find info about each one of them and their classifications!

## UI
These settings are part of the `ui = {}` table and control Nvim's UI when toggling either Minimalist or Ataraxis mode. Those settings have the exact same names they have in NeoVim, so there is no need to explain what they do. If you need help with any of them use `:help <setting_name>`. Note that every setting belongs to a table that represents the part of the UI they are part of, for example: the setting `showtabline` is part of the `top = {}` table because visually it's part of the top part of NeoVim.

## Modes
They are part of the `modes = {}` table and control the settings for the different modes TrueZen provides!

### Ataraxis
+ `left_padding`: (Integer) sets padding for the left.
+ `right_padding`: (Integer) sets padding for the right.
+ `top_padding`: (Integer) sets padding for the top.
+ `bottom_padding`: (Integer) sets padding for the bottom.
+ `auto_padding`: (Boolean) if true, it will ignore `left_padding` and `right_padding` and will set them for you.
+ `keep_default_fold_fillchars`: (Boolean) Keep default fold fillchars. Useful if you want the mouse to keep working.
+ `ideal_writing_area_width`: (Table) sets an ideal width for the writing area. It can receive up to 3 values (`{<int -> min_width>, <int -> max_width>, <str -> "min"/"max">}`) but only one is needed for it to work. Passing a `0` to the table disables it, anything grater than does the opposite. It simply ensures a writing area of the given size regardless of the ui's proportions where possible. If only `<min_width>` is passed, then that value is the ideal writing area. Useful for people with multiple monitors that **don't use a terminal multiplexer or resize it often**. If `<min_width>` and `<max_width>` are passed, it defines a range to pick the writing area from, where the first value is the minimum width it can have and the second value is the maximum. Useful for people with **terminal multiplexers/that resize the terminal a lot**. If `<min_width>`, `<max_width>` and `<"min"/"max">` are passed, the same as passing the two values will happen but it will try pick either the "max" or the "min" width where possible.
+ `affected_higroups`: (Table) receives a table with all of the Hi Groups that get affected by TrueZen. Every key must match the name of an existing hi group and every value must be an empty table or `"ignore"` in case you want that hi groups to be completely ignored.
+ `bg_configuration`: (Boolean) if true, allows TrueZen to interact with the user's background. Set it to false only if you are having problems with it. (Note: Refer to the FAQ about this)
+ `quit`: (String - "untoggle", "close", nil) changes the behaviour of the `quit` command while on Ataraxis mode. if "untoggle", quit will untoggle Ataraxis mode, but if set to "close" it will close the original window from where it was first called. To simply use quit as always set it to `nil`.
+ `ignore_floating_windows`: (Boolean) if true, will avoid restoring TrueZen's layout after exiting a floating window. If you use plugins that depend on floating windows that disappear/appear constantly (e.g. [lspsaga.nvim](https://github.com/glepnir/lspsaga.nvim)), then you are not gonna want TrueZen to be "closing" them all the time. However, if x plugin creates a floating window that you [usually] interact with once then this isn't needed.
+ `custom_bg` (Table): used for adding custom bg (or none) used by the paddings and for tranquilizing the given `hi groups`. It receives two value, where value one is the style, and value two is the background propery/colors. If value one is `"solid"` then it will set the given hex color (value two) (e.g. `custom_bg = {"solid", "#1a1d1e"}`). If value one is `"darken"` it will darken the padding by the given degree between 1 and 0.0 (value two), where `1` is the same as the background and `0.0` is the completly dark (e.g. `custom_bg = {"darken", 0.87}`). Finally, if the value one is `"none"` then it the given color (value two) will only be using for tranquilizing the `hi groups` (e.g. `custom_bg = {"none", ""}`).

used for setting a backgroups color if your colorscheme doesn't provide one already/you don't want to set one for Nvim as a whole but only for TrueZen.nvim. If you already have a BG color, leave the quotes empty. Refer to the FAQ about this.

### Focus
+ `margin_of_error`: (Integer > 1) adjusts MOE (margin of error). Less = more precision, however, it's recommended to keep the defaults, or at least a number >= 2. This only matters if `focus_method` is set to `"native"`.
+ `focus_method`: (String: "native"/"experimental") sets focusing method. `"native"` uses "vim's way" of focusing windows. The drawback of this method is that it tends to break if you resize the terminal. `"experimental"` is a new way of focusing windows that allows for free terminal resizing.

## Integrations
These settings are part of the `integrations = {}` table and can be used to enable or disable integrations.

- `galaxyline`: (Boolean) if true, hides galaxyline when Ataraxis mode is on and toggles it back on after exiting it.
- `vim_airline`: (Boolean) if true, hides vim airline when Ataraxis mode is on and toggles it back on after exiting it.
- `vim_powerline`: (Boolean) if true, hides vim powerline when Ataraxis mode is on and toggles it back on after exiting it.
- `express_line`: (Boolean) if true, hides expressline when Ataraxis mode is on and toggles it back on after exiting it.
- `lualine`: (Boolean) if true, hides lualine when Ataraxis mode is on and toggles it back on after exiting it.
- `tmux`: (Boolean) if true, hides Tmuxs' statusline when Ataraxis mode is on and toggles it back on after exiting it.
- `gitgutter`: (Boolean) if true, disables Gitgutter when Ataraxis mode is on and toggles it back on after exiting it.
- `vim_signify`: (Boolean) if true, disables Vim Signify when Ataraxis mode is on and toggles it back on after exiting it.
- `limelight`: (Boolean) if true, enables Limelight when Ataraxis mode is on and toggles it back off after exiting it.
- `twilight`: (Boolean) if true, enables Twilight when Ataraxis mode is on and toggles it back off after exiting it.
- `gitsigns`: (Boolean) if true, disables Gitsigns' elements when Ataraxis mode is on and enables them after exiting it.
- `lightline`: (Boolean) if true, hides lightline when Ataraxis mode is on and toggles it back on after exiting it.

## Misc
+ `on_off_commands`: (Boolean) if true, enables [On/Off commands](#onoff).
+ `ui_elements_commands`: (Boolean) if true, enables [commands for the UI elements](#ui-elements).
+ `cursor_by_mode`: (Boolean) if true, changes the cursors' shape according to the current Vi mode. Useful for when the statuline and showmode are hidden so that one can easily identify the current mode.

## Events
Use them to execute code at certain events [described by the names they have]. These are the ones available:

| Mode       | Function Name              |
|------------|----------------------------|
| Focus      | before_mode_focus_on       |
| Focus      | after_mode_focus_on        |
| Focus      | before_mode_focus_off      |
| Focus      | after_mode_focus_off       |
| Minimalist | before_mode_minimalist_on  |
| Minimalist | after_mode_minimalist_on   |
| Minimalist | before_mode_minimalist_off |
| Minimalist | after_mode_minimalist_off  |
| Ataraxis   | before_mode_ataraxis_on    |
| Ataraxis   | after_mode_ataraxis_on     |
| Ataraxis   | before_mode_ataraxis_off   |
| Ataraxis   | after_mode_ataraxis_off    |

They can be used like so:

```lua
local true_zen = require("true-zen")

true_zen.after_mode_ataraxis_on = function ()
	print("hi!")
end
```

# 🧻 Key-bindings
There are no default key-bindings. However,  you can set them on your own as you'd normally do! Here is an example mapping `<F12>` to toggle `Ataraxis` mode:

**For init.lua**
```lua
vim.api.nvim_set_keymap("n", "<F12>", [[<Cmd>TZAtaraxis<CR>]], opt)
```

**For init.vim**
```vimscript
map <F12> :TZAtaraxis<CR>
```

# 🙋 FAQ

- Q: ***"How can I make it launch at startup?"***
- A: Easy! Just copy and paste this:

For **init.lua**:
```lua
vim.cmd("autocmd VimEnter * TZAtaraxis")
```

For **init.vim**:
```vimscript
autocmd VimEnter * TZAtaraxis
```

- Q: ***"How can I view the doc from NeoVim?"***
- A: Use `:help TrueZen.nvim`

- Q: ***"Why isn't my statusline being hidden when I toggle Ataraxis mode?"***
- A: If your statusline does not have an integration, TrueZen will try its best to hide it. If it fails, then open an issue and request for the integration, and in the mean time use the built-in [events](#events).

- Q: ***Getting this error: `E420: BG color unknown`. How do I solve this?***
- A: This issue occurs because:
1. You don't have `set termguicolors` in your init.vim (or `vim.cmd("set termguicolors")` in your init.lua). If that didn't help, use the `custom_bg` setting to set a bg color for TrueZen, this solution *should* deffinately work. This will set a bg for TrueZen to use. If possible try to set it to match your normal Nvim background color.

and/or

2. Your current colorscheme doesn't provide a background (bg) color. To test the latter, run this command: `highlight StatusLineNC ctermfg=bg ctermbg=bg guibg=bg guifg=bg`. If you get an error, you can follow the above case's intructions to set it only for TrueZen or you could add the *hi* so that it'll affect nvim as a whole:
```
hi NORMAL guibg=<color/hex_code>
" e.g.:
" hi NORMAL guibg=#1e222a
```

If you don't fit in either of the above cases/the fixes didn't work for you, then disable BG interaction between TrueZen and NeoVim (your colorscheme in this case) with the `disable_bg_configuration` setting under the `ataraxis = {}` table.


If you already tried everything of the above and *nothing worked* (which I doubt), then it's an issue with your Colorscheme, not a TrueZen.nvim one!

# 🫂 Contribute

Pull Requests are welcomed as long as they are properly justified and there are no conflicts. If your PR has something to do with the README or in general related with the documentation, I'll gladly merge it! Also, when writing code for the project **you must** use the [.editorconfig](https://github.com/Pocco81/TrueZen.nvim/blob/main/.editorconfig) file on your editor so as to "maintain consistent coding styles". For instructions on how to use this file refer to [EditorConfig's website](https://editorconfig.org/).

# 💭 Inspirations

The following projects inspired the creation of TrueZen.nvim. If possible, go check them out to see why they are so amazing :]
- [junegunn/goyo.vim](https://github.com/junegunn/goyo.vim): Distraction-free writing in Vim.
- [IntelliJ IDEA's Zen Mode](https://www.jetbrains.com/help/idea/ide-viewing-modes.html): Combines the Full Screen and Distraction-free modes.
- [toggle-line.vim](https://github.com/pirey/toggle-line.vim): toggle statusline and tabline (and tmux statusline) simultaneously.

# 📜 License

TrueZen.nvim is released under the GPL v3.0 license. It grants open-source permissions for users including:

+ The right to download and run the software freely
+ The right to make changes to the software as desired
+ The right to redistribute copies of the software
+ The right to modify and distribute copies of new versions of the software

For more convoluted language, see the [LICENSE file](https://github.com/Pocco81/TrueZen.nvim/blob/main/README.md).

# 📋 TO-DO

**High Priority:**
+ None

**Low Priority:**
+ None

<hr>
<p align="center">
	Enjoy!
</p>

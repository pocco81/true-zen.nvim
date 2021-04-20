# 🪶 true-zen.nvim

<p align="center">
	Clean and elegant distraction free mode for NeoVim.
</p>

<p align="center">
    <a href="https://github.com/kdav5758/whid.nvim"
        ><img
            src="https://img.shields.io/github/repo-size/kdav5758/TrueZen.nvim"
            alt="GitHub repository size"
    /></a>
    <a href="https://github.com/kdav5758/TrueZen.nvim/issues"
        ><img
            src="https://img.shields.io/github/issues/kdav5758/TrueZen.nvim"
            alt="Issues"
    /></a>
    <a href="https://github.com/kdav5758/TrueZen.nvim/blob/main/LICENSE"
        ><img
            src="https://img.shields.io/github/license/kdav5758/TrueZen.nvim"
            alt="License"
    /><br />
    <a href="https://saythanks.io/to/kdav5758"
        ><img
            src="https://img.shields.io/badge/say-thanks-modal.svg"
            alt="Say thanks"/></a
    ></a>    <a href="https://github.com/kdav5758/whid.nvim/commits/main"
            ><img
            src="https://img.shields.io/github/last-commit/kdav5758/TrueZen.nvim"
            alt="Latest commit"
    /></a>
    <a href="https://github.com/kdav5758/whid.nvim/stargazers"
        ><img
            src="https://img.shields.io/github/stars/kdav5758/whid.nvim"
            alt="Repository's starts"
    /></a>
</p>


<kbd><img src ="https://i.imgur.com/vvq4CLr.png"></kbd>
<p align="center">
	Ataraxis Mode on
</p><hr>

<kbd><img src ="https://i.imgur.com/qYf0nE1.png"></kbd>
<p align="center">
	Minimalist Mode on
</p>

# TL;DR

<div style="text-align: justify">
	TrueZen.nvim is a NeoVim plugin written mostly in Lua that aims to provided a cleaner and less cluttered interface [than usual] when toggled in either of it's two different modes (minimalist mode and ataraxis mode). It can be installed with your favorite plugin manager and has some sane defaults so that you can just execute ':TZAtaraxis' to get started!
</div>



# 🌲 Table of Contents

* [Features](#-features)
* [Installation](#-installation)
	* [Prerequisites](#prerequisites)
	* [Adding the plugin](#adding-the-plugin)
	* [Setup Configuration](#setup-configuration)
		* [For init.lua](#for-initlua)
		* [For init.vim](#for-initvim)
	* [Updating](#updating)
* [Usage (commands)](#-usage-commands)
	* [Default](#default)
	* [Extra (True/False)](#extra-truefalse)

* [Configuration](#-configuration)
	* [General Structure](#general-structure)
	* [List of settings](#list-of-settings)
		* [General](#general)
		* [Bottom](#bottom)
		* [Top](#top)
		* [Left](#left)
		* [Ataraxis](#ataraxis)
* [Key Bindings](#-key-bindings)
* [Inspirations](#-inspirations)
* [License](#-license)
* [Do you...](#-do-you)
* [To-Do](#-to-do)

# 🎁 Features
- Hide UI components (e.g. statusline, numbers, buffer list)
- Two different modes!
	- Minimalist mode: hides UI components.
	- Ataraxis mode: same as 'Minimalist mode' but adds "padding" to all the buffers in the current session.
- Highly customizable
- Can deactivate UI components separately
	- Left: (relative)numbers, signcolumn
	- Top: tabline
	- Bottom: laststatus, ruler, showmode, showcmd, cmdheight
- Custom cursor that changes shape according to current vi-mode
- You can still cycle through open buffers even when you can't see them in the UI
- Non nonsensical

# 📦 Installation

## Prerequisites

- [NeoVim nightly](https://github.com/neovim/neovim/releases/tag/nightly) (>=v0.5.0)
- A nice color scheme to complement your experience ;)

## Adding the plugin
You can use your favorite plugin manager for this. Here are some examples with the most popular ones:

### Vim-plug

```lua
Plug 'kdav5758/TrueZen.nvim'
```
### Packer.nvim

```lua
use "kdav5758/TrueZen.nvim"
```

### Vundle

```lua
Plugin 'kdav5758/TrueZen.nvim'
```

### NeoBundle
```lua
NeoBundleFetch 'kdav5758/TrueZen.nvim'
```

## Setup (configuration)
As it's mentioned in the TL;DR, there are already some sane defaults that you may like, however you can change them to match your taste. This are the defaults:
```lua
true_false_commands = false,
cursor_by_mode = false,
bottom = {
	hidden_laststatus = 0,
	hidden_ruler = false,
	hidden_showmode = false,
	hidden_showcmd = false,
	hidden_cmdheight = 1,

	shown_laststatus = 2,
	shown_ruler = true,
	shown_showmode = false,
	shown_showcmd = false,
	shown_cmdheight = 1
},
top = {
	hidden_showtabline = 0,

	shown_showtabline = 2
},
left = {
	hidden_number = false,
	hidden_relativenumber = false,
	hidden_signcolumn = "no",

	shown_number = true,
	shown_relativenumber = false,
	shown_signcolumn = "no"
},
ataraxis = {
	left_right_padding = 40
}
```

The way you setup the settings on your config vary on whether you are using vimL for this or Lua.

### For init.lua
```lua
-- setup for TrueZen.nvim
require("true-zen").setup({

    true_false_commands = false,
	cursor_by_mode = false,
	bottom = {
		hidden_laststatus = 0,
		hidden_ruler = false,
		hidden_showmode = false,
		hidden_showcmd = false,
		hidden_cmdheight = 1,

		shown_laststatus = 2,
		shown_ruler = true,
		shown_showmode = false,
		shown_showcmd = false,
		shown_cmdheight = 1
	},
	top = {
		hidden_showtabline = 0,

		shown_showtabline = 2
	},
	left = {
		hidden_number = false,
		hidden_relativenumber = false,
		hidden_signcolumn = "no",

		shown_number = true,
		shown_relativenumber = false,
		shown_signcolumn = "no"
	},
	ataraxis = {
		left_right_padding = 40
	}
})
```
### For init.vim
```
lua << EOF
-- setup for TrueZen.nvim
require("true-zen").setup({

    true_false_commands = false,
	cursor_by_mode = false,
	bottom = {
		hidden_laststatus = 0,
		hidden_ruler = false,
		hidden_showmode = false,
		hidden_showcmd = false,
		hidden_cmdheight = 1,

		shown_laststatus = 2,
		shown_ruler = true,
		shown_showmode = false,
		shown_showcmd = false,
		shown_cmdheight = 1
	},
	top = {
		hidden_showtabline = 0,

		shown_showtabline = 2
	},
	left = {
		hidden_number = false,
		hidden_relativenumber = false,
		hidden_signcolumn = "no",

		shown_number = true,
		shown_relativenumber = false,
		shown_signcolumn = "no"
	},
	ataraxis = {
		left_right_padding = 40
	}
})
EOF
```

For configuration instructions check out the [configuration](#configuration) section.

## Updating
This depends on your plugin manager. If, for example, you are using Packer.nvim, you can update it with this command:
```lua
:PackerUpdate
```

# 🤖 Usage (commands)
All the commands follow the *camel casing* naming convention and have the `TZ` prefix so that it's easy to remember that they are part of the TrueZen.nvim plugin. These are all of them:

## Default
- `:TZAtaraxis` toggles Ataraxis mode. Ataraxis is a combination of Minimalist mode that provides padding to all the buffers in the current session
- `:TZMinimalist` toggles Minimalist mode. Activated/deactivates NeoVim's UI components from the left, bottom and top of NeoVim
- `:TZBottom` toggles the bottom part of NeoVim's UI. It toggles: laststatus, ruler, showmode, showcmd, and cmdheight.
- `:TZTop` toggles the top part of NeoVim's UI. It toggles: tabline.
- `:TZLeft` toggles the left part of NeoVim's UI. It toggles: numbers, relative numbers, and signcolumn.

## Extra (True/False)
These are the commands that can be enabled if `true_false_commands` is set to `true`. They are simply the "true or false" version of each one of the default commands. They have a `T` (for `true`) or an `F` (for `false`) suffix indicating what they do: True = show and False = hide (e.g.  `TZLeftT` will show the left UI part of Nvim). These are all of then:

- `:TZAtaraxisT` show every UI component (Left, Top, Bottom) and add padding to every buffers.
- `:TZAtaraxisF` hide every UI component (Left, Top, Bottom) and remove padding from every buffer.
- `:TZMinimalistT` show every UI component (Left, Top, Bottom).
- `:TZMinimalistF` hide every UI component (Left, Top, Bottom).
- `:TZBottomT` show bottom UI parts.
- `:TZBottomF` hide bottom UI parts.
- `:TZTopT` show top UI parts.
- `:TZTopF` hide top UI parts.
- `:TZLeftT` show left UI parts.
- `:TZLeftF` hide left UI parts

# 🍉 Configuration
There are individual settings and settings that are tables. Settings that are not a table do not depend on whether TrueZen is toggled or not to work. However, `bottom`, `top`, and `left` are tables that indicate what happen to each one of the UI components when TrueZen is toggled *supposing they are clasified in their location groups (e.g Left controls (relative)numbers and the signcolumn)*. The table `ataraxis` has settings that control what happens when you toggle/untoggle `Ataraxis mode`.

## General structure
Almost every setting inside a table has a prefix indicating the state where that setting is going to be executed (e.g. `hidden_number` modifies what happens to the number line when the `Left` UI part of NeoVim is hidden).

## List of settings
Note: remember that `<prefix>` can either be "shown" or "hidden."

### General
- `true_false_commands`: (Boolean) enables true/false extra commands.
- `cursor_by_mode`: (Boolean) changes cursor according to current Vi mode. Useful for when statuline and showmode are hidden so that one can easily identify the current mode.

### Bottom
- `<prefix>_laststatus`: (Integer) gives information about the status of a buffer with the default statusline including the path, permissions, line and a percentage representation of where you are in the file.
- `<prefix>_ruler`: (Boolean) it displays the line number, the column number, the virtual column number, and the relative position of the cursor in the file (as a percentage).
- `<prefix>_showmode`: (Boolean) show current vi mode.
- `<prefix>_showcmd`: (Boolean) shows partial commands in the last line of the screen.
- `<prefix>_cmdheight`: (Integer)height of the space you use to type commands.

### Top
- `<prefix>_showtabline`: (Integer) show the tabline with current buffers.

### Left
- `<prefix>_number`: (Boolean) show numberline.
- `<prefix>_relativenumber`: (Boolean) show realative numberline.
- `<prefix>_signcolumn`: (String: "yes"/"no") show sign column.

### Ataraxis
- `left_right_padding`: (Integer) padding for the text.


## 🧻 Key-bindings
There are no default key-bindings. However you can set them on your own as you'd normally do! Here is an example mapping `<F12>` to toggle `Ataraxis` mode:

**For init.lua**
```lua
vim.api.nvim_set_keymap("n", "<F12>", [[<Cmd>TZAtaraxis<CR>]], opt)
```

**For init.vim**
```vimscript
map <F12> :TZAtaraxis<CR>
```

## 🙋 FAQ

- Q: ***"How can I make it launch at startup?"***
- A: Easy! Just copy and paste this:

For **init.lua**:
```lua
require("tz_main").main(4, 3)
```

For **init.vim**:
```vimscript
lua << EOF
require("tz_main").main(4, 3)
EOF
```

## 💭 Inspirations

The following projects inspired the creation of TrueZen.nvim. If possible, go check them out to see why they are so amazing :]
- [junegunn/goyo.vim](https://github.com/junegunn/goyo.vim): Distraction-free writing in Vim
- [IntelliJ IDEA's Zen Mode](https://www.jetbrains.com/help/idea/ide-viewing-modes.html): Combines the Full Screen and Distraction-free modes

## 📜 License

TrueZen.nvim is released under the GPL v3.0 license. It grants open-source permissions for users including:

- The right to download and run the software freely
- The right to make changes to the software as desired
- The right to redistribute copies of the software
- The right to modify and distribute copies of new versions of the software

For more convoluted language, see the [LICENSE file](https://github.com/kdav5758/TrueZen.nvim/blob/main/README.md).

## ✋ Do you...

- Have a question? Start a [discussion](https://github.com/kdav5758/TrueZen.nvim/discussions)
- Have a problem? Make an [issue](https://github.com/kdav5758/TrueZen.nvim/issues)
- Hava an idea? Create a [pull request](https://github.com/kdav5758/TrueZen.nvim/pulls)

## 📋 TO-DO

**High Priority**
- Fix bug that causes cursor to appear on the left hand side split when Ataraxis mode is launched at startup.

**Low Priority**
- Tmux integration
- Kitty terminal integration



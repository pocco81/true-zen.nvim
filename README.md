# 🪶 TrueZen.nvim

<p align="center">
	Clean and elegant distraction-free writing for NeoVim.
</p>

<p align="center">
    <a href="https://github.com/kdav5758/TrueZen.nvim"
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
    <a href="https://github.com/kdav5758/TrueZen.nvim/commits/main"
		><img
			src="https://img.shields.io/github/last-commit/kdav5758/TrueZen.nvim"
			alt="Latest commit"
    /></a>
    <a href="https://github.com/kdav5758/TrueZen.nvim/stargazers"
        ><img
            src="https://img.shields.io/github/stars/kdav5758/TrueZen.nvim"
            alt="Repository's starts"
    /></a>
</p>


<kbd><img src ="https://i.imgur.com/n71fn6R.png"></kbd>
<p align="center">
	Ataraxis Mode
</p><hr>

<kbd><img src ="https://i.imgur.com/q0MoTfN.png"></kbd>
<p align="center">
	Minimalist Mode
</p><hr>

<kbd><img src ="https://i.imgur.com/ALDtKie.gif"></kbd>
<p align="center">
	Focus Mode
</p>


# TL;DR

<div style="text-align: justify">
	TrueZen.nvim is a NeoVim plugin written mostly in Lua that aims to provide a cleaner and less cluttered interface [than usual] when toggled in either of it's three different modes (Ataraxis, Minimalist and Focus). It can be installed with your favorite plugin manager and has some sane defaults so that you can just execute ':TZAtaraxis' to get started!
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
	* [General](#general)
	* [UI Elements](#ui-elements)
	* [Events](#events)
	* [Integrations](#integrations)
	* [Ataraxis](#ataraxis)
	* [Focus](#focus)
* [Key Bindings](#-key-bindings)
* [Inspirations](#-inspirations)
* [License](#-license)
* [FAQ](#-faq)
* [Do you...](#-do-you)
* [To-Do](#-to-do)

# 🎁 Features
- Hide UI components (e.g. statusline, numbers, buffer list).
- Three different modes!
	- Minimalist mode: hides UI components.
	- Focus mode: maximizes current window. (offers two different focusing methods)
	- Ataraxis mode: same as 'Minimalist mode' but adds "padding" and other cool stuff (e.g. setting an ideal writing area width).
		- Padding can be set manually or automatically.
- Highly customizable
- Can deactivate UI components separately
	- Left: (relative)numbers, signcolumn
	- Top: tabline
	- Bottom: laststatus, ruler, showmode, showcmd, cmdheight
- Custom cursor that changes shape according to current vi-mode
- You can still cycle through open buffers even when you can't see them in the UI
- Non nonsensical
- Can launch at startup if needed
- Can execute code at certain events
	- Before Minimalist mode hides everything
	- Before Minimalist mode shows everything
	- After Minimalist mode hides everything
	- After Minimalist mode hides everything
- Loads on demand, so it won't affect your startup time
- Integrations with other plugins/stuff
	- Vim Airline integration
	- Tmux integration
	- Galaxyline integration
	- Vim powerline integration
	- Express line integration
	- Gitgutter integration
	- Vim Signify integration
	- Limelight integration
	- `TZFocus` and `TZAtaraxis` integration
	- Gitsigns integration


# 📦 Installation

## Prerequisites

- [NeoVim nightly](https://github.com/neovim/neovim/releases/tag/nightly) (>=v0.5.0)
- [Lua ver. >= 5.3](https://www.lua.org/manual/5.3/readme.html#changes)
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
As it's stated in the TL;DR, there are already some sane defaults that you may like, however you can change them to match your taste. These are the defaults:
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
	ideal_writing_area_width = 0
	just_do_it_for_me = false,
	left_padding = 40,
	right_padding = 40,
	top_padding = 0,
	bottom_padding = 0,
	custome_bg = "",
	disable_bg_configuration = false,
	disable_fillchars_configuration = false,
	force_when_plus_one_window = false,
	force_hide_statusline = true
},
focus = {
	margin_of_error = 5,
	focus_method = "experimental"
},
events = {
	before_minimalist_mode_shown = false,
	before_minimalist_mode_hidden = false,
	after_minimalist_mode_shown = false,
	after_minimalist_mode_hidden = false
},
integrations = {
	integration_galaxyline = false,
	integration_vim_airline = false,
	integration_vim_powerline = false,
	integration_tmux = false,
	integration_express_line = false,
	integration_gitgutter = false,
	integration_vim_signify = false,
	integration_limelight = false,
	integration_tzfocus_tzataraxis = false,
	integration_gitsigns = false
}
```

The way you setup the settings on your config varies on whether you are using vimL for this or Lua.


<details>
    <summary>For init.lua</summary>
<p>

```lua
local true_zen = require("true-zen")

-- setup for TrueZen.nvim
true_zen.setup({
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
		ideal_writing_area_width = 0,
		just_do_it_for_me = false,
		left_padding = 40,
		right_padding = 40,
		top_padding = 0,
		bottom_padding = 0,
		custome_bg = "",
		disable_bg_configuration = false,
		disable_fillchars_configuration = false,
		force_when_plus_one_window = false,
		force_hide_statusline = true
	},
	focus = {
		margin_of_error = 5,
		focus_method = "experimental"
	},
	events = {
		before_minimalist_mode_shown = false,
		before_minimalist_mode_hidden = false,
		after_minimalist_mode_shown = false,
		after_minimalist_mode_hidden = false
	},
	integrations = {
		integration_galaxyline = false,
		integration_vim_airline = false,
		integration_vim_powerline = false,
		integration_tmux = false,
		integration_express_line = false,
		integration_gitgutter = false,
		integration_vim_signify = false,
		integration_limelight = false,
		integration_tzfocus_tzataraxis = false,
		integration_gitsigns = false
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

-- setup for TrueZen.nvim
true_zen.setup({
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
		ideal_writing_area_width = 0,
		just_do_it_for_me = false,
		left_padding = 40,
		right_padding = 40,
		top_padding = 0,
		bottom_padding = 0,
		custome_bg = "",
		disable_bg_configuration = false,
		disable_fillchars_configuration = false,
		force_when_plus_one_window = false,
		force_hide_statusline = true
	},
	focus = {
		margin_of_error = 5,
		focus_method = "experimental"
	},
	events = {
		before_minimalist_mode_shown = false,
		before_minimalist_mode_hidden = false,
		after_minimalist_mode_shown = false,
		after_minimalist_mode_hidden = false
	},
	integrations = {
		integration_galaxyline = false,
		integration_vim_airline = false,
		integration_vim_powerline = false,
		integration_tmux = false,
		integration_express_line = false,
		integration_gitgutter = false,
		integration_vim_signify = false,
		integration_limelight = false,
		integration_tzfocus_tzataraxis = false,
		integration_gitsigns = false
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
All the commands follow the *camel casing* naming convention and have the `TZ` prefix so that it's easy to remember that they are part of the TrueZen.nvim plugin. These are all of them:

## Default
- `:TZMinimalist` toggles Minimalist mode. Activates/deactivates NeoVim's UI components from the left, bottom and top of NeoVim on all the buffers you enter in the current session.
- `:TZFocus` toggle focus mode. Focus mode maximizes the current window. It has two defferent focusing methods too! Due to the fact that there is no way to check whether a window is maximized or not, it compares different factors in order to determine it; that's why it has the `margin_of_error` setting.
- `:TZAtaraxis` toggles Ataraxis mode. Ataraxis is kind of a "super extension" of Minimalist mode that uses it for deactivating UI components, however, it also provides padding to all buffers in the current session + makes use of the different integrations.
- `:TZBottom` toggles the bottom part of NeoVim's UI. It toggles: laststatus, ruler, showmode, showcmd, and cmdheight.
- `:TZTop` toggles the top part of NeoVim's UI. It toggles: tabline.
- `:TZLeft` toggles the left part of NeoVim's UI. It toggles: numbers, relative numbers, and signcolumn.

## Extra (True/False)
These are the commands that can be enabled if `true_false_commands` is set to `true`. They are simply the "true or false" version of each one of the default commands. They have a `T` (for `true`) or an `F` (for `false`) suffix indicating what they do: True = show and False = hide (e.g.  `TZLeftT` will show the left UI part of Nvim). These are all of then:

- `:TZAtaraxisT` show every UI component (Left, Top, Bottom) and add padding to every buffers + integrations.
- `:TZAtaraxisF` hide every UI component (Left, Top, Bottom) and remove padding from every buffer + integrations.
- `:TZMinimalistT` show every UI component (Left, Top, Bottom).
- `:TZMinimalistF` hide every UI component (Left, Top, Bottom).
- `:TZBottomT` show bottom UI parts.
- `:TZBottomF` hide bottom UI parts.
- `:TZTopT` show top UI parts.
- `:TZTopF` hide top UI parts.
- `:TZLeftT` show left UI parts.
- `:TZLeftF` hide left UI parts
- `:TZFocusT` focus current window
- `:TZFocusF` unfocus current window

# 🍉 Configuration
Although settings already have self-explanatory names, here is where you can find info about each one of them and their classifications! There are individual settings and settings that are tables. Settings that are tables are simply *settings with subsettings*.

## General
This settings are unrelated to any group and are independent.
- `true_false_commands`: (Boolean) if true, enables true/false extra commands.
- `cursor_by_mode`: (Boolean) if true, changes cursor according to current Vi mode. Useful for when the statuline and showmode are hidden so that one can easily identify the current mode.

## UI elements
Every setting that makes part of a UI component (Left, Top, Bottom) has a prefix indicating the state when that setting is going to be executed (e.g. `hidden_number` modifies what happens to the number line when the `Left` UI part of NeoVim is hidden). Note: remember that `<prefix>` can either be "shown" or "hidden." In the case of settings that receive a booleans: `true` = set the setting and `false` = do not set the setting (e.g `hidden_number = true`: will *set* (show) the numberline when the Left UI part is hidden.)

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

## Events
Use them to execute code at certain events [described by the name of each one of them]. Needless to say, they belong on the `events = {}` table.

- `before_minimalist_mode_shown`: (Boolean) allows code to be executed before Minimalist mode shows UI components
- `before_minimalist_mode_hidden`: (Boolean) allows code to be executed before Minimalist mode hides UI components
- `after_minimalist_mode_shown`: (Boolean) allows code to be executed after Minimalist mode shows UI components
- `after_minimalist_mode_hidden`: (Boolean) allows code to be executed after Minimalist mode hides UI components

The code that executes in any of this circumstances is set by a function by the same name of the setting (e.g require('true-zen').after_minimalist_mode_hidden). This is are some examples for each one of this events:

```lua
local true_zen = require("true-zen")

true_zen.after_minimalist_mode_hidden = function ()
	vim.cmd("echo 'I ran after minimalist mode hid everything :)'")
end

true_zen.before_minimalist_mode_hidden = function ()
	vim.cmd("echo 'I ran before minimalist mode hid everything :)'")
end

true_zen.after_minimalist_mode_shown = function ()
	vim.cmd("echo 'I ran after minimalist mode showed everything :)'")
end

true_zen.before_minimalist_mode_shown = function ()
	vim.cmd("echo 'I ran before minimalist mode showed everything :)'")
end

```

## Integrations
Integrations are a way for providing support for certain (Neo)Vim plugins/stuff in order for TrueZen to integrate nicely with them. Needless to say, these settings can be set in the `integrations = {}` table. For obvious reasons, integrations only work if you have the specific plugin/thing installed. Enabling any of them in the case you don't have that specific element installed will result in an error. In this case, `true` will *enable* the extension, and `false` will *disable* it; this **does not mean** that if you set *x* integration to `false` you'll get the exact opposite behaviour as if it was `true`.


### General integrations
- `integration_tmux`: (Boolean) if set to true, hides Tmux tab bar when Ataraxis mode is toggled.
- `integration_gitgutter`: (Boolean) if set to true, disables Gitgutter when Ataraxis mode is toggled.
- `integration_vim_signify`: (Boolean) if set to true, disables Vim Signify when Ataraxis mode is toggled.
- `integration_limelight`: (Boolean) if set to true, enables Limelight when Ataraxis mode is toggled.
- `integration_tzfocus_tzataraxis`: (Boolean) if set to true, it will focus current window and then enter Ataraxis mode, and the opposite happens if you unfocus it. This integration only works if the `focus_method` setting under the `Focus` table is set to `"experimental"`.
- `integration_gitsigns`: (Boolean) if set to true, it will deactive Gitsigns' elements and restore to their previous state once Ataraxis mode is untoggled.

### Statuslines integrations:
Not all statuslines obey a simple `set statusline=-`, that's why this integrations are crucials for you to have nice experience when using Ataraxis mode. This will ensure that that specific statusline is hidden. If the statusline that you use does not have an integration, consider opening an issue in the GitHub repository and if possible mention how to toggle/untoggle your specific statusline. In the meantime, you have three options:
1. Let Ataraxis mode try to hide it.
2. Set the `force_hide_statusline` setting on the `Ataraxis` table to `true`.
3. Use the `after_minimalist_mode_hidden` and the `after_minimalist_mode_shown` events to hide/show it yourself.

- `integration_galaxyline`: (Boolean) if set to true, hides galaxyline when Ataraxis mode hides everything.
- `integration_vim_airline`: (Boolean) if set to true, hides vim airline when Ataraxis mode hides everythinge.
- `integration_vim_powerline`: (Boolean) if set to true, hides vim powerline when Ataraxis mode hides everything.
- `integration_express_line`: (Boolean) if set to true, hides expressline when Ataraxis mode hides everything.

Note for Vim Powerline users: toggling/untoggling your statusline is a little bit slow, but since you are using it then you must know that already.


## Ataraxis
- `ideal_writing_area_width`: (Integer) sets an ideal width for the writing area. Setting it to `0` disables it, any number greater than `0` does the opposite, which will then ignore the `just_do_it_for_me`, the `left_padding`, and the `right_padding` settings for obvious reasons. For example: if you set it to `20` you will always get a writing area or `20` and both the `left` and the `right` hand side paddings will be set automatically. This feature is useful for people with various monitors with different sizes.
- `just_do_it_for_me`: (Boolean) if set to true, will ignore `left_padding` and `right_padding` and will set them for you.
- `left_padding`: (Integer) sets padding for the left.
- `right_padding`: (Integer) sets padding for the right.
- `top_padding`: (Integer) sets padding for the top.
- `bottom_padding`: (Integer) sets padding for the bottom.
- `custome_bg` (String) used for setting a bg color if your coloscheme doesn't provide one already/you don't want to set one for Nvim as a whole but only for TrueZen.nvim. If you already have a BG color, leave the quotes empty. Refer to the FAQ about this.
- `disable_bg_configuration`: (Boolean) disable any background configuration/interaction. Use it only if you have issues with the backgrounds (although I strongly recommend checkgin the FAQ about this and/or using the `custome_bg` setting for this)
- `disable_fillchars_configuration`: (Boolean) disables fillchars interactions. By default the plugin hides them all to give that "clean" look. If you are having issues with the fillchars try setting them on your config (`:help 'fillchars'`), but if that didn' help either, then set this option to `true`.
- `force_when_plus_one_window`: (Boolean) by default you can't toggle Ataraxis if there is more than one window open, this is to prevent layout issues. If set to `true`, TrueZen will quits all the other windows (not buffers) before entering Ataraxis mode on the current window. As a workaround, check the `integration_tzfocus_tzataraxis` integration and the `"experimental"` `focus_method`.
- `force_hide_statusline`: (Boolean) forcefully hide the statusline if it isn't being compliant.


## Focus
- `margin_of_error`: (Integer > 1) adjusts MOE (margin of error) for focus mode. Less = more precision, however, it's recommended to keep the defaults, or at least a number >= 2. This only matters if `focus_method` is set to `"native"`.
- `focus_method`: (String: "native"/"experimental") sets focusing method. `"native"` uses "vim's way" of focusing windows. The drawback of this method is that it tends to break if you resize the terminal. `"experimental"` is a new way of focusing windows that allows for free terminal resizing. It works by creating a buffer of the current window and opening it in "fullscreen". This focusing method is crucial for the `integration_tzfocus_tzataraxis` integration and will also allow you to toggle `Ataraxis` on a window that's being focused!


# 🧻 Key-bindings
There are no default key-bindings. However you can set them on your own as you'd normally do! Here is an example mapping `<F12>` to toggle `Ataraxis` mode:

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
Keep in mind that there are some plugins, for instance, Galaxyline, that no matter what you do will load themselves only after everything else has been loaded. If this is your case, try playing around with the different **events** TrueZen.nvim offers to get your desired behaviour!

- Q: ***"How can I view the doc from NeoVim?"***
- A: Use `:help TrueZen.nvim`

- Q: ***"Why isn't my statusline being hidden when I toggle Ataraxis mode?"***
- A: If your statusline does not have an integration, TrueZen will try its best to hide it. If it fails then try using the `force_hide_statusline` setting under the `ataraxis = {}` table. If it does have an integration and you have `force_hide_statusline` set to true, but even then it fails to hide the statusline, then is an issue with your statusline. Every, single, statusline, works differently. If this happens to you, try using another statusline and see if you are still getting this issue. The only known statusline were the latter happens is `Galaxyline`. Sometimes it shows it self when it shouldn't and vice versa.

- Q: ***Getting this error: `E420: BG color unknown`. How do I solve this?***
- A: This issue occurs because:
1. You don't have `set termguicolors` in your init.vim (or `vim.cmd("set termguicolors")` in your init.lua). If that didn't help, use the `custome_bg = "<hex_code>/<normal_color>"` setting to set a bg color for TrueZen, this solution *should* deffinately work. This will set a bg for TrueZen to use. If possible try to set it to match your normal Nvim background color.

and/or

2. Your current colorscheme doesn't provide a background (bg) color. To test the latter, run this command: `highlight StatusLineNC ctermfg=bg ctermbg=bg guibg=bg guifg=bg`. If you get an error, you can follow the above case's intructions to set it only for TrueZen or you could add the *hi* so that it'll affect nvim as a whole:
```
hi NORMAL guibg=<color/hex_code>
" e.g.:
" hi NORMAL guibg=#1e222a
```

If you don't fit in either of the above cases/the fixes didn't for you, then disable BG interaction between TrueZen and NeoVim (your colorscheme in this case) with the `disable_bg_configuration` setting under the `ataraxis = {}` table.


If you already tried everything of the obove and *nothing worked* (which I doubt), then it's an issue with your Colorscheme, not a TrueZen.nvim one!

# 💭 Inspirations

The following projects inspired the creation of TrueZen.nvim. If possible, go check them out to see why they are so amazing :]
- [junegunn/goyo.vim](https://github.com/junegunn/goyo.vim): Distraction-free writing in Vim.
- [IntelliJ IDEA's Zen Mode](https://www.jetbrains.com/help/idea/ide-viewing-modes.html): Combines the Full Screen and Distraction-free modes.
- [toggle-line.vim](https://github.com/pirey/toggle-line.vim): toggle statusline and tabline (and tmux statusline) simultaneously.

# 📜 License

TrueZen.nvim is released under the GPL v3.0 license. It grants open-source permissions for users including:

- The right to download and run the software freely
- The right to make changes to the software as desired
- The right to redistribute copies of the software
- The right to modify and distribute copies of new versions of the software

For more convoluted language, see the [LICENSE file](https://github.com/kdav5758/TrueZen.nvim/blob/main/README.md).

# ✋ Do you...

- Have a question? Start a [discussion](https://github.com/kdav5758/TrueZen.nvim/discussions).
- Have a problem? Make an [issue](https://github.com/kdav5758/TrueZen.nvim/issues). Remember to include an appropriate label.
- Hava an idea? Create a [pull request](https://github.com/kdav5758/TrueZen.nvim/pulls).

# 📋 TO-DO
The current To-Do's can be found in [this public Trello.com board](https://trello.com/b/nGGv2jk7/truezennvim). Just keep in mind each tag meaning:
- Purple = bug
- Green = low priority
- Yellow = medium priority
- Red = high priority

Note: If you are part of the colorblind spectrum enable "Color blind friendly mode".



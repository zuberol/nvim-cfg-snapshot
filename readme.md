
## Custom vim commands repository
https://github.com/zuberol/nvim-scratches

## Feature: custom colorscheme implementation

File: lua/plugins/midnightcrawler.lua - initialization
Implementation: `https://github.com/zuberol/midnightcrawler.nvim`

## Feature: emacs like remaps

File: lua/zeauberg/emacs-cmdwind.lua

The non-trivial implementation of `<Tab>` completion of builtin nvim completion is implemented here. No need to `<C-y>` to accept the completed item.

## Feature: telescope.nvim advanced overrides

File: lua/zeauberg/telescope.lua

## Feature: Bash script detection

File: lua/zeauberg/filetype.lua

This one allows to detect the bash script filetype in unnamed buffer, which helps to load syntax highlighting and other filetype plugins. Eg, "ftplugin/bash_override.lua" will be loaded.

## Feature: lsp hover window linebreak

File: lua/zeauberg/lsp.lua

This one fixes the line wraps of the "on hover window". The words in a float are no longer cut in half which highly improves code reading.

## Feature: ordered-grep

File: lua/zeauberg/ordered-grep.lua

It allows to pass the multiple grep filters in a single prompt. Unused right know, but can be used as an example of telescope.nvim extension.

## Feature: quickfix text manipulation

File: lua/zeauberg/qftextfunc.lua

This one manipulates quickfix entry view to render it's title only.

## Feature: telescope builtin help_tags picker fixed

File: lua/zeauberg/send_qf.lua

Default implementation of help_tags picker is broken when it comes to using quickfix. It allows jumps to the appropriate file where vim tag can be found, but it omits the tag location in the file. This implementation fixes this bug.

## Feature: ':Tab' command

File: lua/zeauberg/switchtab.lua

Allows to open arbitrary vim tab. Can be used with a shortcut like Alt+tab_number.

## Feature: tabline implementation

File: lua/zeauberg/tabline.lua

Renders tab names and when there is a git root directory in the upper working directory, renders and highlights the 'git root directory' using appropriate highlight.
It call the 'git' cli under the hood.

## Feature: Detach window

File: plugin/detach.lua

It allows to detach the arbitrary nvim window and make it a floating one. The float can be made a normal window with <C-W>HJKL builtin keymap.

## Feature: ':LsBuffers' ':LsWindows'

A set of util commands useful for debugging UI. Shows the windows/buffers metadata.

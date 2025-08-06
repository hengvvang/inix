{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.yazi.enable && config.myHome.dotfiles.yazi.method == "direct") {
    
    home.file.".config/yazi/yazi.toml" = {
      text = ''
        # Yazi 文件管理器配置
        # 配置方式: direct - 直接文件配置

        [manager]
        ratio          = [ 1, 4, 3 ]
        sort_by        = "alphabetical"
        sort_sensitive = false
        sort_reverse   = false
        sort_dir_first = true
        linemode       = "none"
        show_hidden    = false
        show_symlink   = true

        [preview]
        tab_size        = 2
        max_width       = 600
        max_height      = 900
        cache_dir       = ""
        image_filter    = "triangle"
        image_quality   = 75
        sixel_fraction  = 15

        [opener]
        edit = [
          { run = '${pkgs.vim}/bin/vim "$1"', desc = "Edit with Vim", block = true },
        ]
        open = [
          { run = 'xdg-open "$1"', desc = "Open", orphan = true },
        ]
        reveal = [
          { run = 'open -R "$1"', desc = "Reveal in Finder" },
        ]
        extract = [
          { run = 'unar "$1"', desc = "Extract here", block = true },
        ]
        play = [
          { run = 'mpv "$1"', desc = "Play with mpv", orphan = true },
        ]

        [open]
        rules = [
          { name = "*/", use = [ "edit", "open", "reveal" ] },
          { mime = "text/*", use = [ "edit", "reveal" ] },
          { mime = "image/*", use = [ "open", "reveal" ] },
          { mime = "video/*", use = [ "play", "reveal" ] },
          { mime = "audio/*", use = [ "play", "reveal" ] },
          { mime = "inode/x-empty", use = [ "edit", "reveal" ] },
          { mime = "application/json", use = [ "edit", "reveal" ] },
          { mime = "*/javascript", use = [ "edit", "reveal" ] },
          { mime = "application/zip", use = [ "extract", "reveal" ] },
          { mime = "application/gzip", use = [ "extract", "reveal" ] },
          { mime = "application/x-tar", use = [ "extract", "reveal" ] },
          { mime = "application/x-bzip2", use = [ "extract", "reveal" ] },
          { mime = "application/x-7z-compressed", use = [ "extract", "reveal" ] },
          { mime = "application/x-rar", use = [ "extract", "reveal" ] },
        ]

        [tasks]
        micro_workers    = 10
        macro_workers    = 25
        bizarre_retry    = 5
        image_alloc      = 536870912  # 512MB
        image_bound      = [ 0, 0 ]
        suppress_preload = false

        [plugin]
        preloaders = [
          { name = "*", cond = "!mime", run = "mime", multi = true, prio = "high" },
        ]
        previewers = [
          { name = "*/", run = "folder", sync = true },
          { mime = "text/*", run = "code" },
          { mime = "*/xml", run = "code" },
          { mime = "*/javascript", run = "code" },
          { mime = "*/x-wine-extension-ini", run = "code" },
          { mime = "image/*", run = "image" },
          { mime = "video/*", run = "video" },
          { mime = "application/pdf", run = "pdf" },
          { mime = "application/zip", run = "archive" },
          { mime = "application/gzip", run = "archive" },
          { mime = "application/x-tar", run = "archive" },
          { mime = "application/x-bzip2", run = "archive" },
          { mime = "application/x-7z-compressed", run = "archive" },
          { mime = "application/x-rar", run = "archive" },
          { mime = "application/json", run = "json" },
        ]

        [input]
        cursor_blink = false

        [select]
        open_title  = "Open with:"
        open_origin = "hovered"
        open_offset = [ 0, 1 ]

        [which]
        sort_by        = "none"
        sort_sensitive = false
        sort_reverse   = false

        [log]
        enabled = false
      '';
    };

    home.file.".config/yazi/keymap.toml" = {
      text = ''
        # Yazi 按键绑定配置

        [manager]
        keymap = [
          { on = [ "<Esc>" ], exec = "escape",             desc = "Exit visual mode, clear selected, or cancel search" },
          { on = [ "q" ],     exec = "quit",               desc = "Exit the process" },
          { on = [ "Q" ],     exec = "quit --no-cwd-file", desc = "Exit the process without writing cwd-file" },
          { on = [ "<C-q>" ], exec = "close",              desc = "Close the current tab, or quit if it is last tab" },
          { on = [ "<C-z>" ], exec = "suspend",            desc = "Suspend the process" },

          # Navigation
          { on = [ "k" ], exec = "arrow -1", desc = "Move cursor up" },
          { on = [ "j" ], exec = "arrow 1",  desc = "Move cursor down" },

          { on = [ "<Up>" ],   exec = "arrow -1", desc = "Move cursor up" },
          { on = [ "<Down>" ], exec = "arrow 1",  desc = "Move cursor down" },

          { on = [ "<C-u>" ], exec = "arrow -50%", desc = "Move cursor up half page" },
          { on = [ "<C-d>" ], exec = "arrow 50%",  desc = "Move cursor down half page" },

          { on = [ "<C-b>" ], exec = "arrow -100%", desc = "Move cursor up one page" },
          { on = [ "<C-f>" ], exec = "arrow 100%",  desc = "Move cursor down one page" },

          { on = [ "<S-Up>" ],   exec = "arrow -5", desc = "Move cursor up 5 lines" },
          { on = [ "<S-Down>" ], exec = "arrow 5",  desc = "Move cursor down 5 lines" },

          { on = [ "h" ], exec = "leave", desc = "Go back to the parent directory" },
          { on = [ "l" ], exec = "enter", desc = "Enter the child directory" },

          { on = [ "<Left>" ],  exec = "leave", desc = "Go back to the parent directory" },
          { on = [ "<Right>" ], exec = "enter", desc = "Enter the child directory" },

          { on = [ "g", "g" ], exec = "arrow -99999999", desc = "Move cursor to the top" },
          { on = [ "G" ],      exec = "arrow 99999999",  desc = "Move cursor to the bottom" },

          # Selection
          { on = [ "<Space>" ], exec = [ "select --state=none", "arrow 1" ], desc = "Toggle the current selection state" },
          { on = [ "v" ],       exec = "visual_mode",                        desc = "Enter visual mode (selection mode)" },
          { on = [ "V" ],       exec = "visual_mode --unset",                desc = "Enter visual mode (unset mode)" },
          { on = [ "<C-a>" ],   exec = "select_all --state=true",            desc = "Select all files" },
          { on = [ "<C-r>" ],   exec = "select_all --state=none",            desc = "Inverse selection of all files" },

          # Operation
          { on = [ "o" ],         exec = "open",                    desc = "Open the selected files" },
          { on = [ "O" ],         exec = "open --interactive",      desc = "Open the selected files interactively" },
          { on = [ "<Enter>" ],   exec = "open",                    desc = "Open the selected files" },
          { on = [ "<C-Enter>" ], exec = "open --interactive",      desc = "Open the selected files interactively" },
          { on = [ "y" ],         exec = [ "yank", "escape --visual" ], desc = "Copy the selected files" },
          { on = [ "x" ],         exec = [ "yank --cut", "escape --visual" ], desc = "Cut the selected files" },
          { on = [ "p" ],         exec = "paste",                   desc = "Paste the files" },
          { on = [ "P" ],         exec = "paste --force",           desc = "Paste the files (overwrite if the destination exists)" },
          { on = [ "-" ],         exec = "link",                    desc = "Symlink the absolute path of files" },
          { on = [ "_" ],         exec = "link --relative",         desc = "Symlink the relative path of files" },
          { on = [ "d" ],         exec = [ "remove", "escape --visual" ], desc = "Move the files to the trash" },
          { on = [ "D" ],         exec = [ "remove --permanently", "escape --visual" ], desc = "Permanently delete the files" },
          { on = [ "a" ],         exec = "create",                  desc = "Create a file or directory (ends with / for directories)" },
          { on = [ "r" ],         exec = "rename --cursor=before_ext", desc = "Rename a file or directory" },
          { on = [ ";" ],         exec = "shell",                   desc = "Run a shell command" },
          { on = [ ":" ],         exec = "shell --block",           desc = "Run a shell command (block the UI until the command finishes)" },
          { on = [ "." ],         exec = "hidden toggle",           desc = "Toggle the visibility of hidden files" },
          { on = [ "s" ],         exec = "search fd",               desc = "Search files by name using fd" },
          { on = [ "S" ],         exec = "search rg",               desc = "Search files by content using ripgrep" },
          { on = [ "<C-s>" ],     exec = "search none",             desc = "Cancel the ongoing search" },
          { on = [ "z" ],         exec = "jump zoxide",             desc = "Jump to a directory using zoxide" },
          { on = [ "Z" ],         exec = "jump fzf",                desc = "Jump to a directory, or reveal a file using fzf" },

          # Linemode
          { on = [ "m", "s" ], exec = "linemode size",        desc = "Set linemode to size" },
          { on = [ "m", "p" ], exec = "linemode permissions", desc = "Set linemode to permissions" },
          { on = [ "m", "m" ], exec = "linemode mtime",       desc = "Set linemode to mtime" },
          { on = [ "m", "n" ], exec = "linemode none",        desc = "Set linemode to none" },

          # Copy
          { on = [ "c", "c" ], exec = "copy path",             desc = "Copy the absolute path" },
          { on = [ "c", "d" ], exec = "copy dirname",          desc = "Copy the path of the parent directory" },
          { on = [ "c", "f" ], exec = "copy filename",         desc = "Copy the name of the file" },
          { on = [ "c", "n" ], exec = "copy name_without_ext", desc = "Copy the name of the file without the extension" },

          # Filter
          { on = [ "f" ], exec = "filter --smart", desc = "Filter the files" },

          # Find
          { on = [ "/" ], exec = "find --smart",            desc = "Find next file" },
          { on = [ "?" ], exec = "find --previous --smart", desc = "Find previous file" },
          { on = [ "n" ], exec = "find_arrow",              desc = "Go to next found file" },
          { on = [ "N" ], exec = "find_arrow --previous",   desc = "Go to previous found file" },

          # Sorting
          { on = [ ",", "m" ], exec = "sort modified --dir-first",               desc = "Sort by modified time" },
          { on = [ ",", "M" ], exec = "sort modified --reverse --dir-first",     desc = "Sort by modified time (reverse)" },
          { on = [ ",", "c" ], exec = "sort created --dir-first",                desc = "Sort by created time" },
          { on = [ ",", "C" ], exec = "sort created --reverse --dir-first",      desc = "Sort by created time (reverse)" },
          { on = [ ",", "e" ], exec = "sort extension --dir-first",              desc = "Sort by extension" },
          { on = [ ",", "E" ], exec = "sort extension --reverse --dir-first",    desc = "Sort by extension (reverse)" },
          { on = [ ",", "a" ], exec = "sort alphabetical --dir-first",           desc = "Sort alphabetically" },
          { on = [ ",", "A" ], exec = "sort alphabetical --reverse --dir-first", desc = "Sort alphabetically (reverse)" },
          { on = [ ",", "n" ], exec = "sort natural --dir-first",                desc = "Sort naturally" },
          { on = [ ",", "N" ], exec = "sort natural --reverse --dir-first",      desc = "Sort naturally (reverse)" },
          { on = [ ",", "s" ], exec = "sort size --dir-first",                   desc = "Sort by size" },
          { on = [ ",", "S" ], exec = "sort size --reverse --dir-first",         desc = "Sort by size (reverse)" },

          # Tabs
          { on = [ "t" ], exec = "tab_create --current", desc = "Create a new tab using the current path" },

          { on = [ "1" ], exec = "tab_switch 0", desc = "Switch to the first tab" },
          { on = [ "2" ], exec = "tab_switch 1", desc = "Switch to the second tab" },
          { on = [ "3" ], exec = "tab_switch 2", desc = "Switch to the third tab" },
          { on = [ "4" ], exec = "tab_switch 3", desc = "Switch to the fourth tab" },
          { on = [ "5" ], exec = "tab_switch 4", desc = "Switch to the fifth tab" },
          { on = [ "6" ], exec = "tab_switch 5", desc = "Switch to the sixth tab" },
          { on = [ "7" ], exec = "tab_switch 6", desc = "Switch to the seventh tab" },
          { on = [ "8" ], exec = "tab_switch 7", desc = "Switch to the eighth tab" },
          { on = [ "9" ], exec = "tab_switch 8", desc = "Switch to the ninth tab" },

          { on = [ "[" ], exec = "tab_switch -1 --relative", desc = "Switch to the previous tab" },
          { on = [ "]" ], exec = "tab_switch 1 --relative",  desc = "Switch to the next tab" },

          { on = [ "{" ], exec = "tab_swap -1", desc = "Swap the current tab with the previous tab" },
          { on = [ "}" ], exec = "tab_swap 1",  desc = "Swap the current tab with the next tab" },

          # Tasks
          { on = [ "w" ], exec = "tasks_show", desc = "Show the tasks manager" },

          # Goto
          { on = [ "g", "h" ],       exec = "cd ~",             desc = "Go to the home directory" },
          { on = [ "g", "c" ],       exec = "cd ~/.config",     desc = "Go to the config directory" },
          { on = [ "g", "d" ],       exec = "cd ~/Downloads",   desc = "Go to the downloads directory" },
          { on = [ "g", "t" ],       exec = "cd /tmp",          desc = "Go to the temporary directory" },
          { on = [ "g", "<Space>" ], exec = "cd --interactive", desc = "Go to a directory interactively" },

          # Help
          { on = [ "~" ], exec = "help", desc = "Open help" },
        ]

        [tasks]
        keymap = [
          { on = [ "<Esc>" ], exec = "close", desc = "Hide the task manager" },
          { on = [ "<C-q>" ], exec = "close", desc = "Hide the task manager" },
          { on = [ "w" ],     exec = "close", desc = "Hide the task manager" },

          { on = [ "k" ], exec = "arrow -1", desc = "Move cursor up" },
          { on = [ "j" ], exec = "arrow 1",  desc = "Move cursor down" },

          { on = [ "<Up>" ],   exec = "arrow -1", desc = "Move cursor up" },
          { on = [ "<Down>" ], exec = "arrow 1",  desc = "Move cursor down" },

          { on = [ "<Enter>" ], exec = "inspect", desc = "Inspect the task" },
          { on = [ "x" ],       exec = "cancel",  desc = "Cancel the task" },

          { on = [ "~" ], exec = "help", desc = "Open help" }
        ]

        [select]
        keymap = [
          { on = [ "<C-q>" ],   exec = "close",          desc = "Cancel selection" },
          { on = [ "<Esc>" ],   exec = "close",          desc = "Cancel selection" },
          { on = [ "<Enter>" ], exec = "close --submit", desc = "Submit the selection" },

          { on = [ "k" ], exec = "arrow -1", desc = "Move cursor up" },
          { on = [ "j" ], exec = "arrow 1",  desc = "Move cursor down" },

          { on = [ "<Up>" ],   exec = "arrow -1", desc = "Move cursor up" },
          { on = [ "<Down>" ], exec = "arrow 1",  desc = "Move cursor down" },

          { on = [ "~" ], exec = "help", desc = "Open help" }
        ]

        [input]
        keymap = [
          { on = [ "<C-q>" ],   exec = "close",          desc = "Cancel input" },
          { on = [ "<Esc>" ],   exec = "close",          desc = "Cancel input" },
          { on = [ "<Enter>" ], exec = "close --submit", desc = "Submit the input" },
          { on = [ "<C-u>" ],   exec = "kill_backward",  desc = "Kill backwards" },
          { on = [ "<C-k>" ],   exec = "kill_forward",   desc = "Kill forwards" },
          { on = [ "<C-h>" ],   exec = "backspace",      desc = "Backspace" },
          { on = [ "<C-d>" ],   exec = "delete",         desc = "Delete" },
          { on = [ "<C-a>" ],   exec = "move_start",     desc = "Move to the beginning of the input" },
          { on = [ "<C-e>" ],   exec = "move_end",       desc = "Move to the end of the input" },
          { on = [ "<C-b>" ],   exec = "move_backward",  desc = "Move cursor one character backwards" },
          { on = [ "<C-f>" ],   exec = "move_forward",   desc = "Move cursor one character forwards" },

          { on = [ "<Left>" ],  exec = "move_backward",  desc = "Move cursor one character backwards" },
          { on = [ "<Right>" ], exec = "move_forward",   desc = "Move cursor one character forwards" },

          { on = [ "~" ], exec = "help", desc = "Open help" }
        ]

        [help]
        keymap = [
          { on = [ "<Esc>" ], exec = "escape", desc = "Clear the filter, or hide the help" },
          { on = [ "q" ],     exec = "close",  desc = "Exit the process" },
          { on = [ "<C-q>" ], exec = "close",  desc = "Hide the help" },

          # Navigation
          { on = [ "k" ], exec = "arrow -1", desc = "Move cursor up" },
          { on = [ "j" ], exec = "arrow 1",  desc = "Move cursor down" },

          { on = [ "<Up>" ],   exec = "arrow -1", desc = "Move cursor up" },
          { on = [ "<Down>" ], exec = "arrow 1",  desc = "Move cursor down" },

          # Filtering
          { on = [ "/" ], exec = "filter", desc = "Apply a filter for the help items" },
        ]
      '';
    };

    home.file.".config/yazi/theme.toml" = {
      text = ''
        # Yazi 主题配置 - GitHub Dark

        [manager]
        cwd = { fg = "#58a6ff" }

        # Hovered
        hovered         = { fg = "#c9d1d9", bg = "#21262d" }
        preview_hovered = { underline = true }

        # Find
        find_keyword  = { fg = "#f0883e", italic = true }
        find_position = { fg = "#da77f2", bg = "reset", italic = true }

        # Marker
        marker_selected = { fg = "#7ee787", bg = "#7ee787" }
        marker_copied   = { fg = "#f0883e", bg = "#f0883e" }
        marker_cut      = { fg = "#ff7b72", bg = "#ff7b72" }

        # Tab
        tab_active   = { fg = "#c9d1d9", bg = "#0d1117" }
        tab_inactive = { fg = "#7d8590", bg = "#21262d" }
        tab_width    = 1

        # Border
        border_symbol = "│"
        border_style  = { fg = "#30363d" }

        # Highlighting
        syntect_theme = "~/.config/yazi/Catppuccin-mocha.tmTheme"

        [status]
        separator_open  = ""
        separator_close = ""
        separator_style = { fg = "#30363d", bg = "#30363d" }

        # Mode
        mode_normal = { fg = "#0d1117", bg = "#58a6ff", bold = true }
        mode_select = { fg = "#0d1117", bg = "#7ee787", bold = true }
        mode_unset  = { fg = "#0d1117", bg = "#f85149", bold = true }

        # Progress
        progress_label  = { fg = "#c9d1d9", bold = true }
        progress_normal = { fg = "#58a6ff", bg = "#21262d" }
        progress_error  = { fg = "#ff7b72", bg = "#21262d" }

        # Permissions
        permissions_t = { fg = "#7ee787" }
        permissions_r = { fg = "#f0883e" }
        permissions_w = { fg = "#ff7b72" }
        permissions_x = { fg = "#58a6ff" }
        permissions_s = { fg = "#7d8590" }

        [select]
        border   = { fg = "#58a6ff" }
        active   = { fg = "#da77f2" }
        inactive = { }

        [input]
        border   = { fg = "#58a6ff" }
        title    = { }
        value    = { }
        selected = { reversed = true }

        [completion]
        border   = { fg = "#58a6ff" }
        active   = { bg = "#21262d" }
        inactive = { }

        [tasks]
        border  = { fg = "#58a6ff" }
        title   = { }
        hovered = { underline = true }

        [which]
        mask            = { bg = "#0d1117" }
        cand            = { fg = "#58a6ff" }
        rest            = { fg = "#7d8590" }
        desc            = { fg = "#da77f2" }
        separator       = "  "
        separator_style = { fg = "#30363d" }

        [help]
        on      = { fg = "#da77f2" }
        exec    = { fg = "#58a6ff" }
        desc    = { fg = "#7d8590" }
        hovered = { bg = "#21262d", bold = true }
        footer  = { fg = "#c9d1d9", bg = "#21262d" }

        [filetype]
        rules = [
          # Images
          { mime = "image/*", fg = "#da77f2" },

          # Videos
          { mime = "video/*", fg = "#f0883e" },
          { mime = "audio/*", fg = "#f0883e" },

          # Archives
          { mime = "application/zip",             fg = "#ff7b72" },
          { mime = "application/gzip",            fg = "#ff7b72" },
          { mime = "application/x-tar",           fg = "#ff7b72" },
          { mime = "application/x-bzip",          fg = "#ff7b72" },
          { mime = "application/x-bzip2",         fg = "#ff7b72" },
          { mime = "application/x-7z-compressed", fg = "#ff7b72" },
          { mime = "application/x-rar",           fg = "#ff7b72" },

          # Documents
          { mime = "application/pdf", fg = "#58a6ff" },

          # Fallback
          { name = "*", fg = "#c9d1d9" },
          { name = "*/", fg = "#58a6ff" }
        ]
      '';
    };
  };
}

{ config, lib, pkgs, ... }:

{
  yaziToml = ''
    [mgr]
    ratio = [1, 3, 4]
    sort_by = "natural"
    sort_sensitive = true
    sort_reverse = false
    sort_dir_first = true
    linemode = "permissions"
    show_hidden = true
    show_symlink = true
    scrolloff = 5
    
    [preview]
    tab_size = 2
    max_width = 600
    max_height = 900
    cache_dir = ""
    
    [opener]
    edit = [
      { run = '${pkgs.vim}/bin/vim "$@"', desc = "Edit with vim", orphan = true },
    ]
    open = [
      { run = 'xdg-open "$@"', desc = "Open", orphan = true },
    ]
    
    [open]
    rules = [
      { name = "*/", use = [ "edit", "open", "reveal" ] },
      { mime = "text/*", use = [ "edit", "reveal" ] },
      { mime = "image/*", use = [ "open", "reveal" ] },
      { mime = "video/*", use = [ "open", "reveal" ] },
      { mime = "audio/*", use = [ "open", "reveal" ] },
      { mime = "inode/x-empty", use = [ "edit", "reveal" ] },
    ]
    
    [tasks]
    micro_workers = 10
    macro_workers = 25
    bizarre_retry = 5
    image_alloc = 536870912
    image_bound = [2, 2]
    suppress_preload = false
    
    [plugin]
    fetchers = [
      { id = "git", name = "*", run = "git" },
      { id = "git", name = "*/", run = "git" },
    ]
    preloaders = [
      { name = "*/", run = "folder", multi = true },
      { mime = "image/*", run = "image" },
      { mime = "video/*", run = "video" },
      { mime = "application/pdf", run = "pdf" },
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
    ]
  '';

  keymapToml = ''
    [manager]
    keymap = [
      { on = [ "<Esc>" ], run = "escape",             desc = "Exit visual mode, clear selected, or cancel search" },
      { on = [ "<C-[>" ], run = "escape",             desc = "Exit visual mode, clear selected, or cancel search" },
      { on = [ "q" ],     run = "quit",               desc = "Exit the process" },
      { on = [ "Q" ],     run = "quit --no-cwd-file", desc = "Exit the process without writing cwd-file" },
      { on = [ "<C-q>" ], run = "close",              desc = "Close the current tab, or quit if it is last tab" },
      { on = [ "<C-z>" ], run = "suspend",            desc = "Suspend the process" },
      
      # Navigation
      { on = [ "k" ], run = "arrow -1", desc = "Move cursor up" },
      { on = [ "j" ], run = "arrow 1",  desc = "Move cursor down" },
      
      { on = [ "<Up>" ],   run = "arrow -1", desc = "Move cursor up" },
      { on = [ "<Down>" ], run = "arrow 1",  desc = "Move cursor down" },
      
      { on = [ "<C-u>" ], run = "arrow -50%", desc = "Move cursor up half page" },
      { on = [ "<C-d>" ], run = "arrow 50%",  desc = "Move cursor down half page" },
      
      { on = [ "<C-b>" ], run = "arrow -100%", desc = "Move cursor up one page" },
      { on = [ "<C-f>" ], run = "arrow 100%",  desc = "Move cursor down one page" },
      
      { on = [ "<S-Up>" ],   run = "arrow -5", desc = "Move cursor up 5 lines" },
      { on = [ "<S-Down>" ], run = "arrow 5",  desc = "Move cursor down 5 lines" },
      
      { on = [ "<A-k>" ], run = "arrow -5", desc = "Move cursor up 5 lines" },
      { on = [ "<A-j>" ], run = "arrow 5",  desc = "Move cursor down 5 lines" },
      
      # Movement
      { on = [ "h" ], run = "leave", desc = "Go back to the parent directory" },
      { on = [ "l" ], run = "enter", desc = "Enter the child directory" },
      
      { on = [ "<Left>" ],  run = "leave", desc = "Go back to the parent directory" },
      { on = [ "<Right>" ], run = "enter", desc = "Enter the child directory" },
      
      { on = [ "H" ], run = "back",    desc = "Go back to the previous directory" },
      { on = [ "L" ], run = "forward", desc = "Go forward to the next directory" },
    ]
  '';

  themeToml = ''
    [flavor]
    use = ""
    
    [manager]
    cwd = { fg = "cyan" }
    
    hovered         = { fg = "black", bg = "lightblue" }
    preview_hovered = { underline = true }
    
    find_keyword  = { fg = "yellow", italic = true }
    find_position = { fg = "magenta", bg = "reset", italic = true }
    
    marker_selected = { fg = "lightgreen", bg = "lightgreen" }
    marker_copied   = { fg = "lightyellow", bg = "lightyellow" }
    marker_cut      = { fg = "lightred", bg = "lightred" }
    
    tab_active   = { fg = "lightblue", bg = "reset" }
    tab_inactive = { fg = "white", bg = "reset" }
    tab_width    = 1
    
    border_symbol = "│"
    border_style  = { fg = "gray" }
    
    highlighting = "underline"
    
    syntect_theme = ""
    
    [status]
    separator_open  = ""
    separator_close = ""
    separator_style = { fg = "gray", bg = "gray" }
    
    mode_normal = { fg = "black", bg = "lightblue", bold = true }
    mode_select = { fg = "black", bg = "lightgreen", bold = true }
    mode_unset  = { fg = "black", bg = "lightred", bold = true }
    
    progress_label  = { bold = true }
    progress_normal = { fg = "blue", bg = "black" }
    progress_error  = { fg = "red", bg = "black" }
    
    permissions_t = { fg = "lightgreen" }
    permissions_r = { fg = "lightyellow" }
    permissions_w = { fg = "lightred" }
    permissions_x = { fg = "lightcyan" }
    permissions_s = { fg = "lightmagenta" }
    
    [select]
    border   = { fg = "blue" }
    active   = { fg = "magenta" }
    inactive = { fg = "white" }
    
    [input]
    border   = { fg = "blue" }
    title    = { fg = "white" }
    value    = { fg = "magenta" }
    selected = { reversed = true }
    
    [completion]
    border   = { fg = "blue" }
    active   = { bg = "gray" }
    inactive = { fg = "white" }
    
    icon_file    = ""
    icon_folder  = ""
    icon_command = ""
    
    [tasks]
    border  = { fg = "blue" }
    title   = { fg = "white" }
    hovered = { underline = true }
    
    [which]
    mask            = { bg = "black" }
    cand            = { fg = "lightcyan" }
    rest            = { fg = "lightgray" }
    desc            = { fg = "magenta" }
    separator       = "  "
    separator_style = { fg = "gray" }
    
    [help]
    on      = { fg = "magenta" }
    exec    = { fg = "cyan" }
    desc    = { fg = "gray" }
    hovered = { bg = "gray", bold = true }
    footer  = { fg = "black", bg = "white" }
    
    [filetype]
    
    rules = [
        # Images
        { mime = "image/*", fg = "cyan" },
        
        # Videos
        { mime = "video/*", fg = "yellow" },
        { mime = "audio/*", fg = "yellow" },
        
        # Archives
        { mime = "application/zip",             fg = "magenta" },
        { mime = "application/gzip",            fg = "magenta" },
        { mime = "application/x-tar",           fg = "magenta" },
        { mime = "application/x-bzip2",         fg = "magenta" },
        { mime = "application/x-7z-compressed", fg = "magenta" },
        { mime = "application/x-rar",           fg = "magenta" },
        
        # Documents
        { mime = "application/pdf", fg = "green" },
        
        # Fallback
        { name = "*", fg = "white" },
        { name = "*/", fg = "blue" }
    ]
  '';

  initLua = ''
    -- Yazi init.lua configuration
    require("plugins")
  '';
}

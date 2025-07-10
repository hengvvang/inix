{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.yazi.enable && config.myHome.dotfiles.yazi.method == "direct") {
    # 方式2: 直接文件写入
    home.file.".config/yazi/yazi.toml".text = ''
      # Yazi 文件管理器配置 - 直接文件写入方式
      
      [manager]
      ratio = [1, 4, 3]
      sort_by = "alphabetical"
      sort_sensitive = false
      sort_reverse = false
      sort_dir_first = true
      linemode = "size"
      show_hidden = false
      show_symlink = true
      scrolloff = 5
      
      [preview]
      tab_size = 2
      max_width = 600
      max_height = 900
      cache_dir = ""
      
      [opener]
      edit = [
        { run = 'vim "$@"', block = true, for = "unix" },
      ]
      open = [
        { run = 'xdg-open "$@"', desc = "Open" },
      ]
      reveal = [
        { run = 'xdg-open "$(dirname "$0")"', desc = "Reveal" },
      ]
      extract = [
        { run = 'unar "$@"', desc = "Extract here" },
      ]
      play = [
        { run = 'mpv "$@"', orphan = true, for = "unix" },
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
        { mime = "application/x-bzip", use = [ "extract", "reveal" ] },
        { mime = "application/x-bzip2", use = [ "extract", "reveal" ] },
        { mime = "application/x-7z-compressed", use = [ "extract", "reveal" ] },
        { mime = "application/x-rar", use = [ "extract", "reveal" ] },
      ]
    '';
    
    home.file.".config/yazi/keymap.toml".text = ''
      # Yazi 键位绑定配置 - 直接文件写入方式
      
      [manager]
      prepend_keymap = [
        { on = [ "<C-s>" ], run = "search fd", desc = "Search files by name using fd" },
        { on = [ "<C-f>" ], run = "search rg", desc = "Search files by content using ripgrep" },
        { on = [ "<C-n>" ], run = "create", desc = "Create a file or directory" },
        { on = [ "Y" ], run = [ "yank --cut" ], desc = "Cut the selected files" },
        { on = [ "X" ], run = [ "unyank" ], desc = "Cancel the yank status of files" },
        { on = [ "T" ], run = "plugin --sync smart-enter", desc = "Enter the child directory, or open the file" },
        { on = [ "<C-t>" ], run = "plugin --sync hide-preview", desc = "Hide or show the preview pane" },
      ]
      
      [[manager.prepend_keymap]]
      on = [ "m" ]
      run = "plugin bookmarks --args=save"
      desc = "Save current position as a bookmark"
      
      [[manager.prepend_keymap]]
      on = [ "'" ]
      run = "plugin bookmarks --args=jump"
      desc = "Jump to a bookmark"
      
      [[manager.prepend_keymap]]
      on = [ "b", "d" ]
      run = "plugin bookmarks --args=delete"
      desc = "Delete a bookmark"
      
      [[manager.prepend_keymap]]
      on = [ "b", "D" ]
      run = "plugin bookmarks --args=delete_all"
      desc = "Delete all bookmarks"
    '';
    
    home.file.".config/yazi/theme.toml".text = ''
      # Yazi 主题配置 - 直接文件写入方式
      
      [manager]
      cwd = { fg = "cyan" }
      
      # Hovered
      hovered         = { fg = "black", bg = "lightblue" }
      preview_hovered = { underline = true }
      
      # Find
      find_keyword  = { fg = "yellow", italic = true }
      find_position = { fg = "magenta", bg = "reset", italic = true }
      
      # Marker
      marker_selected = { fg = "lightgreen", bg = "lightgreen" }
      marker_copied   = { fg = "lightyellow", bg = "lightyellow" }
      marker_cut      = { fg = "lightred", bg = "lightred" }
      
      # Tab
      tab_active   = { fg = "black", bg = "lightblue" }
      tab_inactive = { fg = "white", bg = "darkgray" }
      tab_width    = 1
      
      # Border
      border_symbol = "│"
      border_style  = { fg = "gray" }
      
      [status]
      separator_open  = ""
      separator_close = ""
      separator_style = { fg = "darkgray", bg = "darkgray" }
      
      # Mode
      mode_normal = { fg = "black", bg = "lightblue", bold = true }
      mode_select = { fg = "black", bg = "lightgreen", bold = true }
      mode_unset  = { fg = "black", bg = "lightmagenta", bold = true }
      
      # Progress
      progress_label  = { bold = true }
      progress_normal = { fg = "blue", bg = "black" }
      progress_error  = { fg = "red", bg = "black" }
      
      # Permissions
      permissions_t = { fg = "lightgreen" }
      permissions_r = { fg = "lightyellow" }
      permissions_w = { fg = "lightred" }
      permissions_x = { fg = "lightcyan" }
      permissions_s = { fg = "darkgray" }
      
      [select]
      border   = { fg = "blue" }
      active   = { fg = "magenta" }
      inactive = {}
      
      [input]
      border   = { fg = "blue" }
      title    = {}
      value    = {}
      selected = { reversed = true }
      
      [completion]
      border   = { fg = "blue" }
      active   = { bg = "darkgray" }
      inactive = {}
      
      # Icons
      [icon]
      "Desktop/"     = ""
      "Documents/"   = ""
      "Downloads/"   = ""
      "Pictures/"    = ""
      "Music/"       = ""
      "Movies/"      = ""
      "Videos/"      = ""
      "Public/"      = ""
      "Library/"     = ""
      "Development/" = ""
      ".config/"     = ""
      ".git/"        = ""
      ".github/"     = ""
      ".gitignore"   = ""
      ".gitmodules"  = ""
      ".gitattributes" = ""
      "node_modules/" = ""
      "favicon.ico"  = ""
      "package.json" = ""
      "webpack.config.js" = ""
      ".ds_store"    = ""
      ".localized"   = ""
      "dockerfile"   = ""
      "docker-compose.yml" = ""
    '';
  };
}

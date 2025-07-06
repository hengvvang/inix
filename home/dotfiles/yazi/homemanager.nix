{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.yazi.enable && config.myHome.dotfiles.yazi.method == "homemanager") {
    # 方式5: Home Manager 程序配置 + 自定义扩展
    programs.yazi = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      
      settings = {
        manager = {
          ratio = [ 1 4 3 ];
          sort_by = "alphabetical";
          sort_sensitive = false;
          sort_reverse = false;
          sort_dir_first = true;
          linemode = "size";
          show_hidden = false;
          show_symlink = true;
          scrolloff = 5;
        };
        
        preview = {
          tab_size = 2;
          max_width = 600;
          max_height = 900;
          cache_dir = "";
        };
        
        opener = {
          edit = [
            { run = ''vim "$@"''; block = true; for = "unix"; }
          ];
          open = [
            { run = ''xdg-open "$@"''; desc = "Open"; }
          ];
          reveal = [
            { run = ''xdg-open "$(dirname "$0")"''; desc = "Reveal"; }
          ];
          extract = [
            { run = ''unar "$@"''; desc = "Extract here"; }
          ];
          play = [
            { run = ''mpv "$@"''; orphan = true; for = "unix"; }
          ];
        };
        
        open.rules = [
          { name = "*/"; use = [ "edit" "open" "reveal" ]; }
          { mime = "text/*"; use = [ "edit" "reveal" ]; }
          { mime = "image/*"; use = [ "open" "reveal" ]; }
          { mime = "video/*"; use = [ "play" "reveal" ]; }
          { mime = "audio/*"; use = [ "play" "reveal" ]; }
          { mime = "inode/x-empty"; use = [ "edit" "reveal" ]; }
          { mime = "application/json"; use = [ "edit" "reveal" ]; }
          { mime = "*/javascript"; use = [ "edit" "reveal" ]; }
          { mime = "application/zip"; use = [ "extract" "reveal" ]; }
          { mime = "application/gzip"; use = [ "extract" "reveal" ]; }
          { mime = "application/x-tar"; use = [ "extract" "reveal" ]; }
          { mime = "application/x-bzip"; use = [ "extract" "reveal" ]; }
          { mime = "application/x-bzip2"; use = [ "extract" "reveal" ]; }
          { mime = "application/x-7z-compressed"; use = [ "extract" "reveal" ]; }
          { mime = "application/x-rar"; use = [ "extract" "reveal" ]; }
        ];
      };
      
      keymap = {
        manager.prepend_keymap = [
          { on = [ "<C-s>" ]; run = "search fd"; desc = "Search files by name using fd"; }
          { on = [ "<C-f>" ]; run = "search rg"; desc = "Search files by content using ripgrep"; }
          { on = [ "<C-n>" ]; run = "create"; desc = "Create a file or directory"; }
          { on = [ "Y" ]; run = [ "yank --cut" ]; desc = "Cut the selected files"; }
          { on = [ "X" ]; run = [ "unyank" ]; desc = "Cancel the yank status of files"; }
          { on = [ "T" ]; run = "plugin --sync smart-enter"; desc = "Enter the child directory, or open the file"; }
          { on = [ "<C-t>" ]; run = "plugin --sync hide-preview"; desc = "Hide or show the preview pane"; }
          { on = [ "m" ]; run = "plugin bookmarks --args=save"; desc = "Save current position as a bookmark"; }
          { on = [ "'" ]; run = "plugin bookmarks --args=jump"; desc = "Jump to a bookmark"; }
          { on = [ "b" "d" ]; run = "plugin bookmarks --args=delete"; desc = "Delete a bookmark"; }
          { on = [ "b" "D" ]; run = "plugin bookmarks --args=delete_all"; desc = "Delete all bookmarks"; }
        ];
      };
      
      theme = {
        manager = {
          cwd = { fg = "cyan"; };
          hovered = { fg = "black"; bg = "lightblue"; };
          preview_hovered = { underline = true; };
          find_keyword = { fg = "yellow"; italic = true; };
          find_position = { fg = "magenta"; bg = "reset"; italic = true; };
          marker_selected = { fg = "lightgreen"; bg = "lightgreen"; };
          marker_copied = { fg = "lightyellow"; bg = "lightyellow"; };
          marker_cut = { fg = "lightred"; bg = "lightred"; };
          tab_active = { fg = "black"; bg = "lightblue"; };
          tab_inactive = { fg = "white"; bg = "darkgray"; };
          tab_width = 1;
          border_symbol = "│";
          border_style = { fg = "gray"; };
        };
        
        status = {
          separator_open = "";
          separator_close = "";
          separator_style = { fg = "darkgray"; bg = "darkgray"; };
          mode_normal = { fg = "black"; bg = "lightblue"; bold = true; };
          mode_select = { fg = "black"; bg = "lightgreen"; bold = true; };
          mode_unset = { fg = "black"; bg = "lightmagenta"; bold = true; };
          progress_label = { bold = true; };
          progress_normal = { fg = "blue"; bg = "black"; };
          progress_error = { fg = "red"; bg = "black"; };
          permissions_t = { fg = "lightgreen"; };
          permissions_r = { fg = "lightyellow"; };
          permissions_w = { fg = "lightred"; };
          permissions_x = { fg = "lightcyan"; };
          permissions_s = { fg = "darkgray"; };
        };
        
        select = {
          border = { fg = "blue"; };
          active = { fg = "magenta"; };
          inactive = { };
        };
        
        input = {
          border = { fg = "blue"; };
          title = { };
          value = { };
          selected = { reversed = true; };
        };
        
        completion = {
          border = { fg = "blue"; };
          active = { bg = "darkgray"; };
          inactive = { };
        };
        
        icon = {
          "Desktop/" = "";
          "Documents/" = "";
          "Downloads/" = "";
          "Pictures/" = "";
          "Music/" = "";
          "Movies/" = "";
          "Videos/" = "";
          "Public/" = "";
          "Library/" = "";
          "Development/" = "";
          ".config/" = "";
          ".git/" = "";
          ".github/" = "";
          ".gitignore" = "";
          ".gitmodules" = "";
          ".gitattributes" = "";
          "node_modules/" = "";
          "favicon.ico" = "";
          "package.json" = "";
          "webpack.config.js" = "";
          ".ds_store" = "";
          ".localized" = "";
          "dockerfile" = "";
          "docker-compose.yml" = "";
        };
      };
    };
    
    # 额外的插件和扩展配置
    home.file.".config/yazi/plugins/.keep".text = "";
    home.file.".config/yazi/flavors/.keep".text = "";
  };
}

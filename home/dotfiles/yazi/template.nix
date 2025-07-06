{ config, lib, pkgs, ... }:

{
  # 模板配置选项在 default.nix 中定义
  config = lib.mkIf (config.myHome.dotfiles.yazi.enable && config.myHome.dotfiles.yazi.method == "template") {
    # 方式4: 模板化配置
    programs.yazi = 
      let
        cfg = config.myHome.dotfiles.yazi;
      in {
        enable = true;
        enableBashIntegration = cfg.enableShellIntegration;
        enableFishIntegration = cfg.enableShellIntegration;
        enableZshIntegration = cfg.enableShellIntegration;
        enableNushellIntegration = cfg.enableShellIntegration;
        
        settings = {
          manager = {
            ratio = cfg.managerRatio;
            sort_by = cfg.sortBy;
            sort_sensitive = cfg.sortSensitive;
            sort_reverse = cfg.sortReverse;
            sort_dir_first = cfg.sortDirFirst;
            linemode = cfg.lineMode;
            show_hidden = cfg.showHidden;
            show_symlink = cfg.showSymlink;
            scrolloff = cfg.scrolloff;
          };
          
          preview = {
            tab_size = cfg.tabSize;
            max_width = cfg.previewMaxWidth;
            max_height = cfg.previewMaxHeight;
            cache_dir = "";
          };
          
          opener = {
            edit = [
              { run = ''${cfg.editor} "$@"''; block = true; for = "unix"; }
            ];
            open = [
              { run = ''${cfg.fileOpener} "$@"''; desc = "Open"; }
            ];
            reveal = [
              { run = ''${cfg.fileOpener} "$(dirname "$0")"''; desc = "Reveal"; }
            ];
            extract = [
              { run = ''${cfg.archiveExtractor} "$@"''; desc = "Extract here"; }
            ];
            play = [
              { run = ''${cfg.mediaPlayer} "$@"''; orphan = true; for = "unix"; }
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
          ] ++ cfg.extraKeymaps;
        };
        
        theme = {
          manager = {
            cwd = { fg = cfg.theme.colors.cyan; };
            hovered = { fg = cfg.theme.colors.hovered.fg; bg = cfg.theme.colors.hovered.bg; };
            preview_hovered = { underline = true; };
            find_keyword = { fg = cfg.theme.colors.yellow; italic = true; };
            find_position = { fg = cfg.theme.colors.magenta; bg = "reset"; italic = true; };
            marker_selected = { fg = cfg.theme.colors.green; bg = cfg.theme.colors.green; };
            marker_copied = { fg = cfg.theme.colors.yellow; bg = cfg.theme.colors.yellow; };
            marker_cut = { fg = cfg.theme.colors.red; bg = cfg.theme.colors.red; };
            tab_active = { fg = cfg.theme.colors.tab.active.fg; bg = cfg.theme.colors.tab.active.bg; };
            tab_inactive = { fg = cfg.theme.colors.tab.inactive.fg; bg = cfg.theme.colors.tab.inactive.bg; };
            tab_width = 1;
            border_symbol = "│";
            border_style = { fg = cfg.theme.colors.gray; };
          };
          
          status = {
            separator_open = "";
            separator_close = "";
            separator_style = { fg = cfg.theme.colors.darkgray; bg = cfg.theme.colors.darkgray; };
            mode_normal = { fg = "black"; bg = cfg.theme.colors.blue; bold = true; };
            mode_select = { fg = "black"; bg = cfg.theme.colors.green; bold = true; };
            mode_unset = { fg = "black"; bg = cfg.theme.colors.magenta; bold = true; };
            progress_label = { bold = true; };
            progress_normal = { fg = cfg.theme.colors.blue; bg = "black"; };
            progress_error = { fg = cfg.theme.colors.red; bg = "black"; };
            permissions_t = { fg = cfg.theme.colors.green; };
            permissions_r = { fg = cfg.theme.colors.yellow; };
            permissions_w = { fg = cfg.theme.colors.red; };
            permissions_x = { fg = cfg.theme.colors.cyan; };
            permissions_s = { fg = cfg.theme.colors.darkgray; };
          };
          
          select = {
            border = { fg = cfg.theme.colors.blue; };
            active = { fg = cfg.theme.colors.magenta; };
            inactive = { };
          };
          
          input = {
            border = { fg = cfg.theme.colors.blue; };
            title = { };
            value = { };
            selected = { reversed = true; };
          };
          
          completion = {
            border = { fg = cfg.theme.colors.blue; };
            active = { bg = cfg.theme.colors.darkgray; };
            inactive = { };
          };
          
          icon = cfg.theme.icons;
        };
      };
    
    # 额外的插件和扩展目录
    home.file.".config/yazi/plugins/.keep".text = "";
    home.file.".config/yazi/flavors/.keep".text = "";
  };
}

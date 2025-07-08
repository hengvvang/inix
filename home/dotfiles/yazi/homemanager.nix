{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.yazi.enable && config.myHome.dotfiles.yazi.method == "homemanager") {
    programs.yazi = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      
      settings = {
        manager = {
          show_hidden = false;
          show_symlink = true;
          sort_by = "alphabetical";
          sort_dir_first = true;
          sort_reverse = false;
          linemode = "none";
          mouse_events = [ "click" "scroll" ];
          scrolloff = 5;
          ratio = [ 1 4 3 ];
        };
        
        preview = {
          tab_size = 2;
          max_width = 600;
          max_height = 900;
          cache_dir = "";
          image_filter = "triangle";
          image_quality = 75;
          sixel_fraction = 15;
          ueberzug_scale = 1.0;
          ueberzug_offset = [ 0 0 0 0 ];
        };
        
        opener = {
          edit = [
            { run = "vim \"$@\""; desc = "Edit with Vim"; }
            { run = "code \"$@\""; desc = "Edit with VS Code"; }
          ];
          open = [
            { run = "xdg-open \"$@\""; desc = "Open with default app"; }
          ];
          reveal = [
            { run = "xdg-open \"$(dirname \"$0\")\""; desc = "Reveal in file manager"; }
          ];
          extract = [
            { run = "unar \"$@\""; desc = "Extract archive"; }
          ];
          play = [
            { run = "mpv \"$@\""; desc = "Play with mpv"; }
          ];
        };
        
        open = {
          rules = [
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
          ];
        };
      };
      
      keymap = {
        manager.prepend_keymap = [
          { on = [ "l" ]; run = "plugin --sync smart-enter"; desc = "Enter the child directory, or open the file"; }
          { on = [ "h" ]; run = "leave"; desc = "Go back to the parent directory"; }
          { on = [ "y" "y" ]; run = "copy"; desc = "Copy the selected files"; }
          { on = [ "d" "d" ]; run = "cut"; desc = "Cut the selected files"; }
          { on = [ "p" ]; run = "paste"; desc = "Paste the files"; }
          { on = [ "t" ]; run = "create"; desc = "Create a new file or directory"; }
          { on = [ "r" ]; run = "rename --cursor=before_ext"; desc = "Rename a file or directory"; }
          { on = [ "D" ]; run = "remove"; desc = "Move the files to the trash"; }
          { on = [ "f" ]; run = "filter --smart"; desc = "Filter the files"; }
          { on = [ "F" ]; run = "find --smart"; desc = "Find files by name"; }
          { on = [ "s" ]; run = "search fd"; desc = "Search files by content"; }
          { on = [ "S" ]; run = "search rg"; desc = "Search files by content using ripgrep"; }
          { on = [ "z" ]; run = "plugin zoxide"; desc = "Jump to a directory using zoxide"; }
          { on = [ "c" "m" ]; run = "plugin chmod"; desc = "Change permissions"; }
          { on = [ "c" "d" ]; run = "cd"; desc = "Change directory"; }
          { on = [ "g" "h" ]; run = "cd ~"; desc = "Go to home directory"; }
          { on = [ "g" "c" ]; run = "cd ~/.config"; desc = "Go to config directory"; }
          { on = [ "g" "d" ]; run = "cd ~/Downloads"; desc = "Go to downloads directory"; }
          { on = [ "g" "t" ]; run = "cd /tmp"; desc = "Go to temporary directory"; }
          { on = [ "g" "D" ]; run = "cd ~/Desktop"; desc = "Go to desktop directory"; }
          { on = [ "g" "." ]; run = "cd ~/.local/share"; desc = "Go to local share directory"; }
        ];
        
        input.prepend_keymap = [
          { on = [ "Enter" ]; run = "close --submit"; desc = "Submit the input"; }
          { on = [ "Escape" ]; run = "close"; desc = "Cancel the input"; }
          { on = [ "C-c" ]; run = "close"; desc = "Cancel the input"; }
        ];
      };
      
      theme = {
        status = {
          separator_open = "";
          separator_close = "";
          separator_style = { fg = "#45475a"; bg = "#45475a"; };
        };
        
        filetype = {
          rules = [
            { mime = "image/*"; fg = "#f9e2af"; }
            { mime = "video/*"; fg = "#fab387"; }
            { mime = "audio/*"; fg = "#89b4fa"; }
            { mime = "application/zip"; fg = "#f38ba8"; }
            { mime = "application/gzip"; fg = "#f38ba8"; }
            { mime = "application/x-tar"; fg = "#f38ba8"; }
            { mime = "application/x-bzip2"; fg = "#f38ba8"; }
            { mime = "application/x-7z-compressed"; fg = "#f38ba8"; }
            { mime = "application/x-rar"; fg = "#f38ba8"; }
            { mime = "application/pdf"; fg = "#f7768e"; }
            { name = "*/"; fg = "#7aa2f7"; }
            { name = "*"; fg = "#c0caf5"; }
          ];
        };
      };
    };
  };
}

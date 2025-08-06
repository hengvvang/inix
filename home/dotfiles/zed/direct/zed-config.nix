{ config, lib, pkgs, ... }:

{
  settings = {
    "theme" = {
      "mode" = "dark";
      "light" = "One Light";
      "dark" = "One Dark";
    };
    "ui_font_size" = 16;
    "buffer_font_size" = 14;
    "buffer_font_family" = "JetBrains Mono";
    "ui_font_family" = "Inter";
    "vim_mode" = true;
    "cursor_blink" = false;
    "relative_line_numbers" = true;
    "scrollbar" = {
      "show" = "auto";
    };
    "vertical_scroll_margin" = 3;
    "soft_wrap" = "editor_width";
    "tab_size" = 2;
    "hard_tabs" = false;
    "show_whitespaces" = "selection";
    "use_autoclose" = true;
    "auto_update" = true;
    "format_on_save" = "on";
    "ensure_final_newline_on_save" = true;
    "remove_trailing_whitespace_on_save" = true;
    "git" = {
      "git_gutter" = "tracked_files";
      "inline_blame" = {
        "enabled" = true;
      };
    };
    "project_panel" = {
      "button" = true;
      "default_width" = 240;
      "dock" = "left";
      "file_icons" = true;
      "folder_icons" = true;
      "git_status" = true;
      "indent_size" = 20;
      "auto_reveal_entries" = true;
    };
    "outline_panel" = {
      "button" = true;
      "default_width" = 240;
      "dock" = "right";
      "file_icons" = true;
      "folder_icons" = true;
      "indent_size" = 20;
      "auto_reveal_entries" = true;
    };
    "collaboration_panel" = {
      "button" = false;
    };
    "chat_panel" = {
      "button" = false;
    };
    "notification_panel" = {
      "button" = true;
      "dock" = "bottom";
      "default_height" = 200;
    };
    "terminal" = {
      "button" = true;
      "dock" = "bottom";
      "default_height" = 320;
      "font_family" = "JetBrains Mono";
      "font_size" = 14;
      "working_directory" = "current_project_directory";
      "blinking" = "terminal_controlled";
      "alternate_scroll" = "off";
      "option_as_meta" = false;
      "copy_on_select" = false;
      "env" = {
        "TERM" = "xterm-256color";
      };
    };
    "assistant" = {
      "default_model" = {
        "provider" = "zed.dev";
        "model" = "claude-3-5-sonnet-20241022";
      };
      "version" = "2";
    };
  };

  keymap = [
    {
      "context" = "Workspace";
      "bindings" = {
        "ctrl-shift-e" = "workspace::ToggleLeftDock";
        "ctrl-shift-f" = "search::Deploy";
        "ctrl-shift-g" = "search::DeployReplace";
        "ctrl-shift-h" = "search::ToggleReplace";
        "ctrl-`" = "terminal_panel::ToggleFocus";
      };
    }
    {
      "context" = "Editor";
      "bindings" = {
        "ctrl-/" = "editor::ToggleComments";
        "ctrl-shift-k" = "editor::DeleteLine";
        "alt-up" = "editor::MoveLineUp";
        "alt-down" = "editor::MoveLineDown";
        "ctrl-d" = "editor::SelectNext";
        "ctrl-shift-d" = "editor::SelectPrevious";
        "ctrl-u" = "editor::UndoSelection";
        "escape" = "editor::Cancel";
      };
    }
    {
      "context" = "VimControl && !menu";
      "bindings" = {
        "space f f" = "file_finder::Toggle";
        "space f r" = "recent_projects::Toggle";
        "space space" = "command_palette::Toggle";
        "space e" = "workspace::ToggleLeftDock";
        "space t" = "terminal_panel::ToggleFocus";
      };
    }
  ];
}

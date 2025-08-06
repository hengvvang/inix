{ config, lib, pkgs, ... }:

{
  # Zed 配置内容
  zedSettings = ''
    {
      // Zed 编辑器配置 - Direct Mode
      "assistant": {
        "default_model": {
          "provider": "zed.dev",
          "model": "claude-3-5-sonnet-20241022"
        },
        "version": "2"
      },
      "vim_mode": false,
      "ui_font_size": 16,
      "buffer_font_size": 16,
      "buffer_font_family": "JetBrains Mono",
      "theme": {
        "mode": "system",
        "light": "One Light",
        "dark": "GitHub Dark"
      },
      "tab_size": 4,
      "hard_tabs": false,
      "soft_wrap": "editor_width",
      "show_whitespaces": "selection",
      "remove_trailing_whitespace_on_save": true,
      "ensure_final_newline_on_save": true,
      "format_on_save": "on",
      "autosave": "after_delay",
      "git": {
        "git_gutter": "tracked_files",
        "inline_blame": {
          "enabled": true
        }
      },
      "outline_panel": {
        "dock": "right"
      },
      "project_panel": {
        "dock": "left",
        "default_width": 300
      },
      "terminal": {
        "dock": "bottom",
        "default_height": 400,
        "font_family": "JetBrains Mono",
        "font_size": 14
      },
      "lsp": {
        "typescript-language-server": {
          "initialization_options": {
            "preferences": {
              "includeInlayParameterNameHints": "all",
              "includeInlayParameterNameHintsWhenArgumentMatchesName": true,
              "includeInlayFunctionParameterTypeHints": true,
              "includeInlayVariableTypeHints": true,
              "includeInlayPropertyDeclarationTypeHints": true,
              "includeInlayFunctionLikeReturnTypeHints": true,
              "includeInlayEnumMemberValueHints": true
            }
          }
        }
      },
      "languages": {
        "TypeScript": {
          "code_actions_on_format": {
            "source.organizeImports": true
          }
        },
        "TSX": {
          "code_actions_on_format": {
            "source.organizeImports": true
          }
        },
        "JavaScript": {
          "code_actions_on_format": {
            "source.organizeImports": true
          }
        },
        "Nix": {
          "language_servers": ["nil"],
          "formatter": {
            "external": {
              "command": "nixpkgs-fmt",
              "arguments": []
            }
          }
        }
      }
    }
  '';

  zedKeymap = ''
    [
      {
        "context": "Workspace",
        "bindings": {
          "cmd-shift-e": "workspace::ToggleLeftDock",
          "cmd-j": "workspace::ToggleBottomDock",
          "cmd-shift-f": "pane::Deploy search",
          "cmd-shift-h": "search::ToggleReplace"
        }
      },
      {
        "context": "Editor",
        "bindings": {
          "cmd-/": "editor::ToggleComments",
          "alt-up": "editor::MoveLineUp",
          "alt-down": "editor::MoveLineDown",
          "cmd-d": "editor::SelectNext",
          "cmd-u": "editor::UndoSelection",
          "cmd-shift-l": "editor::SelectAllMatches"
        }
      }
    ]
  '';
}

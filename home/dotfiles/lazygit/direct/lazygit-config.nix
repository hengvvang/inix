{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.lazygit.enable && config.myHome.dotfiles.lazygit.method == "direct") {
    
    home.file.".config/lazygit/config.yml" = {
      text = ''
        # Lazygit 配置文件
        # 配置方式: direct - 直接文件配置

        gui:
          # 界面设置
          scrollHeight: 2
          scrollPastBottom: true
          sidePanelWidth: 0.3333
          expandFocusedSidePanel: false
          mainPanelSplitMode: 'flexible'
          language: 'auto'
          timeFormat: '02 Jan 06'
          shortTimeFormat: '15:04'
          theme:
            activeBorderColor:
              - '#58a6ff'
              - bold
            inactiveBorderColor:
              - '#30363d'
            optionsTextColor:
              - '#58a6ff'
            selectedLineBgColor:
              - '#21262d'
            selectedRangeBgColor:
              - '#21262d'
            cherryPickedCommitBgColor:
              - '#58a6ff'
            cherryPickedCommitFgColor:
              - '#0d1117'
            unstagedChangesColor:
              - '#ff7b72'
            defaultFgColor:
              - '#c9d1d9'
          commitLength:
            show: true
          mouseEvents: true
          skipDiscardChangeWarning: false
          skipStashWarning: false
          showFileTree: true
          showListFooter: true
          showRandomTip: true
          showBranchCommitHash: false
          showBottomLine: true
          showPanelJumps: true
          showCommandLog: true
          showIcons: false

        git:
          paging:
            colorArg: always
            pager: delta --dark --paging=never
          commit:
            signOff: false
          merging:
            manualCommit: false
            args: ''
          log:
            order: 'topo-order'
            showGraph: 'when-maximised'
            showWholeGraph: false
          skipHookPrefix: WIP
          autoFetch: true
          autoRefresh: true
          fetchAll: true
          branchLogCmd: 'git log --graph --color=always --abbrev-commit --decorate --date=relative --pretty=medium {{branchName}} --'
          allBranchesLogCmd: 'git log --graph --all --color=always --abbrev-commit --decorate --date=relative  --pretty=medium'
          overrideGpg: false
          disableForcePushing: false
          parseEmoji: false
          diffContextSize: 3

        update:
          method: prompt
          days: 14

        refresher:
          refreshInterval: 10
          fetchInterval: 60

        confirmOnQuit: false
        quitOnTopLevelReturn: false

        keybinding:
          universal:
            quit: 'q'
            quit-alt1: '<c-c>'
            return: '<esc>'
            quitWithoutChangingDirectory: 'Q'
            togglePanel: '<tab>'
            prevItem: '<up>'
            nextItem: '<down>'
            prevItem-alt: 'k'
            nextItem-alt: 'j'
            prevPage: ','
            nextPage: '.'
            scrollLeft: 'H'
            scrollRight: 'L'
            gotoTop: '<'
            gotoBottom: '>'
            prevBlock: '<left>'
            nextBlock: '<right>'
            prevBlock-alt: 'h'
            nextBlock-alt: 'l'
            jumpToBlock: ['1', '2', '3', '4', '5']
            nextMatch: 'n'
            prevMatch: 'N'
            optionMenu: null
            optionMenu-alt1: '?'
            select: '<space>'
            goInto: '<enter>'
            openRecentRepos: '<c-r>'
            confirm: '<enter>'
            confirm-alt1: 'y'
            remove: 'd'
            new: 'n'
            edit: 'e'
            openFile: 'o'
            scrollUpMain: '<pgup>'
            scrollDownMain: '<pgdown>'
            scrollUpMain-alt1: 'K'
            scrollDownMain-alt1: 'J'
            scrollUpMain-alt2: '<c-u>'
            scrollDownMain-alt2: '<c-d>'
            executeCustomCommand: ':'
            createRebaseOptionsMenu: 'm'
            pushFiles: 'P'
            pullFiles: 'p'
            refresh: 'R'
            createPatchOptionsMenu: '<c-p>'
            nextTab: ']'
            prevTab: '['
            nextScreenMode: '+'
            prevScreenMode: '_'
            undo: 'z'
            redo: '<c-z>'
            filteringMenu: '<c-s>'
            diffingMenu: 'W'
            diffingMenu-alt: '<c-e>'
            copyToClipboard: '<c-o>'
            submitEditorText: '<enter>'
            extrasMenu: '@'
            toggleWhitespaceInDiffView: '<c-w>'
            increaseContextInDiffView: '}'
            decreaseContextInDiffView: '{'

        os:
          copyToClipboardCmd: ''
          readFromClipboardCmd: ''
          openCmd: ''
          openLinkCmd: ''

        disableStartupPopups: false
        customCommands: []
        services: {}
        notARepository: 'prompt'
        promptToReturnFromSubprocess: true
      '';
    };
  };
}

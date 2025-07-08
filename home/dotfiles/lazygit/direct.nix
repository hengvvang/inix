{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.lazygit.enable && config.myHome.dotfiles.lazygit.method == "direct") {
    home.file.".config/lazygit/config.yml".text = ''
      gui:
        showIcons: true
        nerdFontsVersion: "3"
        theme:
          lightTheme: false
          activeBorderColor:
            - "#89b4fa"
            - bold
          inactiveBorderColor:
            - "#45475a"
          optionsTextColor:
            - "#89b4fa"
          selectedLineBgColor:
            - "#313244"
          selectedRangeBgColor:
            - "#313244"
          cherryPickedCommitBgColor:
            - "#45475a"
          cherryPickedCommitFgColor:
            - "#89b4fa"
          unstagedChangesColor:
            - "#f38ba8"
        scrollHeight: 2
        scrollPastBottom: true
        sidePanelWidth: 0.3333
        expandFocusedSidePanel: false
        mainPanelSplitMode: "flexible"
        language: "en"
        timeFormat: "02 Jan 06 15:04 MST"
        shortTimeFormat: "15:04"
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
        showFileIcons: true
        commandLogSize: 8
        splitDiff: "auto"
        skipRewordInEditorWarning: false
        border: "single"
        
      git:
        paging:
          colorArg: always
          pager: delta --dark --paging=never
        commit:
          signOff: false
        merging:
          manualCommit: false
          args: ""
        log:
          order: "topo-order"
          showGraph: "when-maximised"
          showWholeGraph: false
        skipHookPrefix: WIP
        autoFetch: true
        autoRefresh: true
        fetchAll: true
        branchLogCmd: "git log --graph --color=always --abbrev-commit --decorate --date=relative --pretty=medium {{branchName}} --"
        allBranchesLogCmd: "git log --graph --all --color=always --abbrev-commit --decorate --date=relative --pretty=medium"
        overrideGpg: false
        disableForcePushing: false
        parseEmoji: false
        diffContextSize: 3
        truncateCopiedCommitHashesTo: 12
        
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
          gotoTop: '<'
          gotoBottom: '>'
          scrollLeft: 'H'
          scrollRight: 'L'
          prevBlock: '<left>'
          nextBlock: '<right>'
          prevBlock-alt: 'h'
          nextBlock-alt: 'l'
          jumpToBlock: ['1', '2', '3', '4', '5']
          nextMatch: 'n'
          prevMatch: 'N'
          optionMenu: '<disabled>'
          optionMenu-alt1: '?'
          select: '<space>'
          goInto: '<enter>'
          openRecentRepos: '<c-r>'
          confirm: '<enter>'
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
          increaseRenameSimilarityThreshold: ')'
          decreaseRenameSimilarityThreshold: '('
          openDiffTool: '<c-t>'
        status:
          checkForUpdate: 'u'
          recentRepos: '<enter>'
          allBranchesLogGraph: 'a'
        files:
          commitChanges: 'c'
          commitChangesWithoutHook: 'w'
          amendLastCommit: 'A'
          commitChangesWithEditor: 'C'
          ignoreFile: 'i'
          refreshFiles: 'r'
          stashAllChanges: 's'
          viewStashOptions: 'S'
          toggleStagedAll: 'a'
          viewResetOptions: 'D'
          fetch: 'f'
          toggleTreeView: '`'
          openMergeTool: 'M'
          openStatusFilter: '<c-b>'
        branches:
          createPullRequest: 'o'
          viewPullRequestOptions: 'O'
          checkoutBranchByName: 'c'
          forceCheckoutBranch: 'F'
          rebaseBranch: 'r'
          renameBranch: 'R'
          mergeIntoCurrentBranch: 'M'
          viewGitFlowOptions: 'i'
          fastForward: 'f'
          createTag: 'T'
          pushTag: 'P'
          setUpstream: 'u'
          fetchRemote: 'f'
        commits:
          squashDown: 's'
          renameCommit: 'r'
          renameCommitWithEditor: 'R'
          viewResetOptions: 'g'
          markCommitAsFixup: 'f'
          createFixupCommit: 'F'
          squashAboveCommits: 'S'
          moveDownCommit: '<c-j>'
          moveUpCommit: '<c-k>'
          amendToCommit: 'A'
          pickCommit: 'p'
          revertCommit: 't'
          cherryPickCopy: 'c'
          cherryPickCopyRange: 'C'
          pasteCommits: 'v'
          tagCommit: 'T'
          checkoutCommit: '<space>'
          resetCherryPick: '<c-R>'
          copyCommitMessageToClipboard: '<c-y>'
          openLogMenu: '<c-l>'
          viewBisectOptions: 'b'
        stash:
          popStash: 'g'
          renameStash: 'r'
        commitFiles:
          checkoutCommitFile: 'c'
        main:
          toggleSelectHunk: 'a'
          pickBothHunks: 'b'
          editSelectHunk: 'E'
        submodules:
          init: 'i'
          update: 'u'
          bulkMenu: 'b'
    '';
  };
}

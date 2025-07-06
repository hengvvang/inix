{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.lazygit.enable && config.myHome.dotfiles.lazygit.method == "homemanager") {
    # 方式1: Home Manager 程序模块
    programs.lazygit = {
      enable = true;
      
      settings = {
        gui = {
          # 界面设置
          theme = {
            lightTheme = false;
            activeBorderColor = [ "cyan" "bold" ];
            inactiveBorderColor = [ "default" ];
            optionsTextColor = [ "blue" ];
            selectedLineBgColor = [ "default" ];
            selectedRangeBgColor = [ "blue" ];
            cherryPickedCommitBgColor = [ "cyan" ];
            cherryPickedCommitFgColor = [ "blue" ];
            unstagedChangesColor = [ "red" ];
            defaultFgColor = [ "default" ];
          };
          
          # 界面布局
          sidePanelWidth = 0.3333;
          expandFocusedSidePanel = false;
          mainPanelSplitMode = "flexible";
          language = "auto";
          timeFormat = "02 Jan 06 15:04 MST";
          shortTimeFormat = "15:04";
          
          # 显示选项
          showListFooter = true;
          showFileTree = true;
          showRandomTip = true;
          showCommandLog = true;
          showBottomLine = true;
          showPanelJumps = true;
          showBranchCommitHash = false;
          showIcons = false;
        };
        
        git = {
          # Git 设置
          paging = {
            colorArg = "always";
            pager = "delta --dark --paging=never";
          };
          
          commit = {
            signOff = false;
            autoWrapCommitMessage = true;
            autoWrapWidth = 72;
          };
          
          merging = {
            manualCommit = false;
            args = "";
          };
          
          skipHookPrefix = "WIP";
          autoFetch = true;
          autoRefresh = true;
          branchLogCmd = "git log --graph --color=always --abbrev-commit --decorate --date=relative --pretty=medium {{branchName}} --";
          allBranchesLogCmd = "git log --graph --all --color=always --abbrev-commit --decorate --date=relative  --pretty=medium";
          overrideGpg = false;
          disableForcePushing = false;
          parseEmoji = false;
        };
        
        update = {
          method = "prompt";
          days = 14;
        };
        
        refresher = {
          refreshInterval = 10;
          fetchInterval = 60;
        };
        
        confirmOnQuit = false;
        quitOnTopLevelReturn = false;
        
        # 自定义命令
        customCommands = [
          {
            key = "C";
            command = "git cz";
            description = "commit with commitizen";
            context = "files";
            loadingText = "opening commitizen commit tool";
            subprocess = true;
          }
          {
            key = "<c-r>";
            command = "gh pr create --fill";
            description = "create pull request";
            context = "localBranches";
            loadingText = "creating pull request";
          }
        ];
        
        # 服务设置
        services = {
          "github.com" = "github:{{owner}}/{{repo}}";
          "gitlab.com" = "gitlab:{{owner}}/{{repo}}";
        };
        
        # 按键绑定
        keybinding = {
          universal = {
            quit = "q";
            quit-alt1 = "<c-c>";
            return = "<esc>";
            quitWithoutChangingDirectory = "Q";
            togglePanel = "<tab>";
            prevItem = "<up>";
            nextItem = "<down>";
            prevItem-alt = "k";
            nextItem-alt = "j";
            prevPage = ",";
            nextPage = ".";
            gotoTop = "<";
            gotoBottom = ">";
            prevBlock = "<left>";
            nextBlock = "<right>";
            prevBlock-alt = "h";
            nextBlock-alt = "l";
            jumpToBlock = [ "1" "2" "3" "4" "5" ];
            nextMatch = "n";
            prevMatch = "N";
            optionMenu = "x";
            optionMenu-alt1 = "?";
            select = "<space>";
            goInto = "<enter>";
            openRecentRepos = "<c-r>";
            confirm = "<enter>";
            remove = "d";
            new = "n";
            edit = "e";
            openFile = "o";
            scrollUpMain = "<pgup>";
            scrollDownMain = "<pgdown>";
            scrollUpMain-alt1 = "K";
            scrollDownMain-alt1 = "J";
            scrollUpMain-alt2 = "<c-u>";
            scrollDownMain-alt2 = "<c-d>";
            executeCustomCommand = ":";
            createRebaseOptionsMenu = "m";
            pushFiles = "P";
            pullFiles = "p";
            refresh = "R";
            createPatchOptionsMenu = "<c-p>";
            nextTab = "]";
            prevTab = "[";
            nextScreenMode = "+";
            prevScreenMode = "_";
            undo = "z";
            redo = "<c-z>";
            filteringMenu = "<c-s>";
            diffingMenu = "W";
            diffingMenu-alt = "<c-e>";
            copyToClipboard = "<c-o>";
            submitEditorText = "<enter>";
            appendNewline = "<a-enter>";
            extrasMenu = "@";
            toggleWhitespaceInDiffView = "<c-w>";
            increaseContextInDiffView = "}";
            decreaseContextInDiffView = "{";
          };
          
          status = {
            checkForUpdate = "u";
            recentRepos = "<enter>";
          };
          
          files = {
            commitChanges = "c";
            commitChangesWithoutHook = "w";
            amendLastCommit = "A";
            commitChangesWithEditor = "C";
            ignoreFile = "i";
            refreshFiles = "r";
            stashAllChanges = "s";
            viewStashOptions = "S";
            toggleStagedAll = "a";
            viewResetOptions = "D";
            fetch = "f";
            toggleTreeView = "`";
          };
          
          branches = {
            createPullRequest = "o";
            viewPullRequestOptions = "O";
            checkoutBranchByName = "c";
            forceCheckoutBranch = "F";
            rebaseBranch = "r";
            renameBranch = "R";
            mergeIntoCurrentBranch = "M";
            viewGitFlowOptions = "i";
            fastForward = "f";
            pushTag = "P";
            setUpstream = "u";
            fetchRemote = "f";
          };
          
          commits = {
            squashDown = "s";
            renameCommit = "r";
            renameCommitWithEditor = "R";
            viewResetOptions = "g";
            markCommitAsFixup = "f";
            createFixupCommit = "F";
            squashAboveCommits = "S";
            moveDownCommit = "<c-j>";
            moveUpCommit = "<c-k>";
            amendToCommit = "A";
            pickCommit = "p";
            revertCommit = "t";
            cherryPickCopy = "c";
            cherryPickCopyRange = "C";
            pasteCommits = "v";
            tagCommit = "T";
            checkoutCommit = "<space>";
            resetCherryPick = "<c-R>";
            copyCommitMessageToClipboard = "<c-y>";
            openLogMenu = "<c-l>";
            viewBisectOptions = "b";
          };
          
          stash = {
            popStash = "g";
            renameStash = "r";
          };
          
          commitFiles = {
            checkoutCommitFile = "c";
          };
          
          main = {
            toggleDragSelect = "v";
            toggleDragSelect-alt = "V";
            toggleSelectHunk = "a";
            pickBothHunks = "b";
          };
          
          submodules = {
            init = "i";
            update = "u";
            bulkMenu = "b";
          };
        };
      };
    };
  };
}

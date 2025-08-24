# 主配置
$env.config = {
  show_banner: false
  completions: {
    case_sensitive: false
    quick: true
    partial: true
    algorithm: "fuzzy"
  }
  history: {
    max_size: 10000
    sync_on_enter: true
    file_format: "plaintext"
  }
  edit_mode: emacs
}

# 基础别名
alias ll = ls -la
alias la = ls -a
alias l = ls
alias .. = cd ..
alias ... = cd ../..

# Git 别名
alias gs = git status
alias ga = git add
alias gc = git commit
alias gp = git push
alias gl = git log --oneline

# 配置设置
$env.config = {
    show_banner: false
    completions: {
        case_sensitive: false
        quick: true
        partial: true
        algorithm: "fuzzy"
    }
    history: {
        max_size: 10000
        sync_on_enter: true
        file_format: "plaintext"
    }
    edit_mode: emacs
}

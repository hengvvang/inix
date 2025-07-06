# Nushell 配置文件 - 外部文件方式

# 别名
alias ll = ls -la
alias la = ls -a
alias l = ls
alias .. = cd ..
alias ... = cd ../..
alias .... = cd ../../..

# Git 别名
alias gs = git status
alias ga = git add
alias gc = git commit
alias gp = git push
alias gl = git log --oneline
alias gd = git diff
alias gb = git branch
alias gco = git checkout

# 现代工具别名
alias cat = bat
alias find = fd
alias grep = rg
alias du = dust
alias df = duf
alias ps = procs
alias top = btop

# 自定义命令
def mkcd [dir: string] {
    mkdir $dir
    cd $dir
}

def extract [file: string] {
    if ($file | path exists) {
        let ext = ($file | path parse | get extension)
        match $ext {
            "zip" => { unzip $file }
            "tar" => { tar -xf $file }
            "gz" => { 
                if ($file | str ends-with ".tar.gz") {
                    tar -xzf $file
                } else {
                    gunzip $file
                }
            }
            "bz2" => {
                if ($file | str ends-with ".tar.bz2") {
                    tar -xjf $file
                } else {
                    bunzip2 $file
                }
            }
            "7z" => { 7z x $file }
            "rar" => { unrar x $file }
            _ => { echo $"Cannot extract ($file): unsupported format" }
        }
    } else {
        echo $"File ($file) does not exist"
    }
}

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

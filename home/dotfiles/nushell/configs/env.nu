# Nushell 环境配置文件 - 外部文件方式

# 环境变量
$env.EDITOR = "vim"
$env.BROWSER = "google-chrome"
$env.TERM = "xterm-256color"

# 路径设置
$env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.HOME)/.local/bin" | prepend $"($env.HOME)/.cargo/bin")

# 自定义提示符
def create_left_prompt [] {
    let home = $nu.home-path
    let dir = (
        if ($env.PWD | path relative-to $home | is-empty) {
            "~"
        } else {
            ($env.PWD | str replace $home "~")
        }
    )
    
    let user = (whoami)
    let host = (hostname)
    
    $"(ansi cyan)($user)@($host)(ansi reset):(ansi blue)($dir)(ansi reset)$ "
}

def create_right_prompt [] {
    let time_segment = ([
        (date now | format date '%H:%M:%S')
    ] | str join)
    
    $time_segment
}

$env.PROMPT_COMMAND = {|| create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = {|| create_right_prompt }
$env.PROMPT_INDICATOR = "〉"
$env.PROMPT_INDICATOR_VI_INSERT = ": "
$env.PROMPT_INDICATOR_VI_NORMAL = "〉"
$env.PROMPT_MULTILINE_INDICATOR = "::: "

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.vscode.enable && config.myHome.dotfiles.vscode.method == "direct") {
    # Visual Studio Code 配置 - 直接安装包方式
    home.packages = with pkgs; [
      vscode                      # 官方 Visual Studio Code
      # vscodium                  # 开源替代版本
      
      # 相关开发工具包 (可选)
      nodejs                      # Node.js 运行时
      python3                     # Python 解释器
      git                         # Git 版本控制
    ];
    
    # 提示用户手动配置
    home.file."vscode-setup-note.txt" = {
      text = ''
        VSCode 直接安装模式配置说明:
        
        1. 已安装 Visual Studio Code 到系统环境
        2. 请手动安装和配置所需扩展
        3. 配置文件位置: ~/.config/Code/User/settings.json
        4. 扩展安装: Ctrl+Shift+X 打开扩展面板
        
        推荐扩展:
        - Python (ms-python.python)
        - Nix IDE (jnoortheen.nix-ide)
        - GitLens (eamodio.gitlens)
        - Prettier (esbenp.prettier-vscode)
        - Vim (vscodevim.vim)
        
        如需自动化配置，请切换到 homemanager 模式。
      '';
      target = "Documents/vscode-setup-note.txt";
    };
  };
}

    myHome = {
        # ...
        pkgs = {
            enable = true;
            toolkits = {
            enable = true;              # 启用工具包模块
            waxingCrescent.enable = true;  # 🌒 峨眉月
            firstQuarter.enable = true;    # 🌓 上弦月
            waxingGibbous.enable = true;   # 🌔 盈凸月
            fullMoon.enable = false;       # 🌕 满月
            };
            apps = {
            waningCrescent.enable = true;  # 🌘 残月
            lastQuarter.enable = true;     # 🌗 下弦月
            waningGibbous.enable = true;   # 🌖 亏凸月
            newMoon.enable = false;        # 🌑 新月
            };
        };
    }
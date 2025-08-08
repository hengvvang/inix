# Niri 配置项完整参考（基于官方文档与 Wiki）

> 适用版本：以 niri Wiki 最新页面为准（标注 Since/Until/next release 的条目请结合你安装的版本核对）。配置文件格式为 KDL。本文为提炼与归纳，非逐句翻译。

- 配置文件路径加载顺序：
  - $XDG_CONFIG_HOME/niri/config.kdl 或 ~/.config/niri/config.kdl；若缺失则回退至 /etc/niri/config.kdl。
  - 可用参数 --config/-c 或环境变量 NIRI_CONFIG 指定其它路径（命令行优先于环境变量）。
  - 支持热重载；可用 niri validate 预检语法。
- 语法要点：
  - 注释：行首 //；整段注释：在段落前加 /-。
  - Flag：写出即启用，省略或注释即禁用。
  - Section：大多数段不可重复；按设备/输出名区分者可重复（如 output "..."）。
  - 默认值：大多数段落可省略使用默认值；binds {} 例外，省略不会自动填充默认绑定。

目录：
- input {}
- output "NAME" {}
- binds {}
- switch-events {}
- layout {}
- workspace "NAME" {...}
- 顶层选项（Miscellaneous）
- window-rule {}
- layer-rule {}
- animations {}
- gestures {}
- debug {}

---

## input {}
配置输入设备与通用输入行为。当前按设备类型统一配置（暂不区分单个设备）。

子段 keyboard/touchpad/mouse/trackpoint/trackball/tablet/touch；以及通用设置。

### keyboard {}
- xkb {}
  - layout: 字符串（如 "us"）
  - variant: 字符串（如 "colemak_dh_ortho"）
  - options: 字符串（如 "compose:ralt,ctrl:nocaps"）
  - model: 字符串
  - rules: 字符串
  - file: 路径（.xkb 键盘映射文件，设置后覆盖上述 xkb 各项）
- repeat-delay: 毫秒（键重复延迟）
- repeat-rate: 每秒字符数（键重复速率）
- track-layout: "global" | "window"（多布局切换跟踪策略）
- numlock: Flag（启动时开启数字锁定）

说明：xkb 为空时将从 systemd-localed 读取；localectl 可设置。

### 指针类设备共有选项（touchpad/mouse/trackpoint/trackball）
- off: Flag（关闭设备事件）
- natural-scroll: Flag（反向滚动）
- accel-speed: 浮点 -1.0..1.0（默认 0.0）
- accel-profile: "adaptive" | "flat"
- scroll-method: "no-scroll" | "two-finger" | "edge" | "on-button-down"
- scroll-button: 整数（按钮代码，用 libinput debug-events 获取；用于 on-button-down）
- scroll-button-lock: Flag（单击锁定滚动，双击视作单击）
- left-handed: Flag（左手模式）
- middle-emulation: Flag（左右键同时按下模拟中键）
- scroll-factor: 浮点（缩放滚动速度）

### touchpad 专有
- tap: Flag（轻触点击）
- dwt: Flag（打字时禁用触控板）
- dwtp: Flag（轨迹点使用时禁用触控板）
- drag: 布尔（Since 25.05，轻触拖拽）
- drag-lock: Flag（抬指短暂停留不丢拖拽）
- tap-button-map: "left-right-middle" | "left-middle-right"
- click-method: "button-areas" | "clickfinger"
- disabled-on-external-mouse: Flag（外接指针时禁用触控板）

### mouse/trackpoint/trackball 专有
- 对应上述共有选项；trackpoint/trackball 常用 scroll-method="on-button-down"。

### tablet/touch 绝对定位设备
- off: Flag
- map-to-output: 输出名（与 output 段相同命名）
- tablet.calibration-matrix: 6 个浮点数（校准矩阵）

### 通用输入设置
- disable-power-key-handling: Flag（让位给 logind 等处理电源键）
- warp-mouse-to-focus [mode=...]: Flag + 属性
  - mode: "center-xy" | "center-xy-always"（默认分别独立按 X/Y 轴吸附）
- focus-follows-mouse [max-scroll-amount="PCT%"]: Flag + 百分比（0% 表示不允许引起滚动）
- workspace-auto-back-and-forth: Flag（重复切换相同序号工作区时回到上一个）
- mod-key: 设定绑定中的 Mod 键（允许：Super, Alt, Mod3, Mod5, Ctrl, Shift）
- mod-key-nested: 嵌套运行窗口中的 Mod 键（同上）

---

## output "NAME" {}
按连接器名（如 eDP-1/HDMI-A-1，大小写不敏感）或“厂商+型号+序列号”匹配。niri msg outputs 可查看可用名与模式。

- off: Flag（关闭该输出）
- mode: "<WxH>" | "<WxH>@<RRR.rrr>"
- scale: 浮点（>=0 且 <=10；支持分数）
- transform: "normal" | "90" | "180" | "270" | "flipped" | "flipped-90" | "flipped-180" | "flipped-270"
- position: x=INT y=INT（全局逻辑坐标；考虑 scale/rotation；若重叠/无效则自动编排）
- variable-refresh-rate [on-demand=true]: Flag + 属性（VRR/自适应同步）
- focus-at-startup: Flag（启动时优先聚焦；多输出按配置出现顺序优先级）
- background-color: 颜色（工作区背景；Until 25.05 忽略 alpha）
- backdrop-color: 颜色（工作区之间/总览的幕布色；忽略 alpha）

自动定位算法：显式 position 的先放置，若重叠则顺延至最右；其余按名称排序依次右移。

---

## binds {}
声明快捷键到动作的映射。
- 键名：修饰符用 + 连接，末尾为 XKB key name。支持修饰符：Ctrl/Control, Shift, Alt, Super/Win, ISO_Level3_Shift/Mod5, ISO_Level5_Shift, 以及 Mod（可自定义，TTY 下默认 Super，嵌套窗口下默认 Alt）。
- 属性：
  - repeat=false（默认会重复触发）
  - cooldown-ms=INT（节流）
  - allow-when-locked=true（仅对 spawn；锁屏时也生效）
  - allow-inhibiting=false（忽略键盘抑制）
  - hotkey-overlay-title="..." | null（自定义/隐藏热键帮助中的标题；支持 Pango 标记）
- 鼠标滚轮绑定：WheelScrollUp/Down/Left/Right；受 natural-scroll 影响
- 触控板滚动绑定：TouchpadScrollUp/Down（按距离量化）
- 鼠标点击绑定（Since 25.01）：MouseLeft/Right/Middle/Forward/Back（注意会覆盖默认拖动/缩放手势）

常用动作（完整列表用 niri msg action 查看）：
- spawn "prog" "arg1" ...（不经 shell；需要 sh -c 手动启用变量/通配/管道；程序名开头的 ~ 会展开）
- quit [skip-confirmation=true]
- do-screen-transition [delay-ms=INT]
- screenshot | screenshot-screen | screenshot-window [write-to-disk=false] [show-pointer=false]
- toggle-window-rule-opacity
- toggle-keyboard-shortcuts-inhibit
- 以及窗口/列/工作区移动、切换、缩放等所有内置动作（详见内置帮助与 msg action）。

辅助：wev 可查看按键符号；libinput debug-events 可查鼠标按钮码。

---

## switch-events {}
系统开关事件绑定（即使会话锁定也会执行；当前仅支持 spawn）。
- lid-close / lid-open
- tablet-mode-on / tablet-mode-off

---

## layout {}
控制窗口布局、尺寸、边框/阴影/插入提示、分栏/分页等外观与空间分配。

- gaps: 浮点（逻辑像素；支持小数，按输出 scale 四舍五入到物理像素）
- center-focused-column: "never" | "always" | "on-overflow"
- always-center-single-column: Flag（始终居中单列）
- empty-workspace-above-first: Flag（最顶端也保留空工作区）
- default-column-display: "normal" | "tabbed"（新建列的显示模式）
- background-color: 颜色（默认工作区背景）

尺寸预设：
- preset-column-widths { proportion FLOAT | fixed INT }（列宽预设，供切换动作轮换）
- default-column-width { proportion FLOAT | fixed INT | 空 }（新窗口默认宽度；空则由客户端决定）
- preset-window-heights { proportion FLOAT | fixed INT }（窗口高预设，供切换动作轮换）

focus-ring 与 border（二者选项一致；focus-ring 仅绘制在各显示器的活动窗口周围；border 影响所有窗口并参与尺寸计算）：
- off（禁用；仅 layout 段）
- width: 浮点（逻辑像素；按 scale 四舍五入）
- active-color/inactive-color/urgent-color: 颜色
- active-gradient/inactive-gradient/urgent-gradient: 渐变，语法近似 CSS linear-gradient
  - angle=FLOAT（度）
  - relative-to: "workspace-view" | 省略（默认相对每个窗口）
  - in: "srgb" | "srgb-linear" | "oklab" | "oklch longer hue" | "oklch shorter hue" | "oklch increasing hue" | "oklch decreasing hue"

shadow（Since 25.02）：
- on/off
- softness: 浮点（模糊半径；0 为硬阴影）
- spread: 浮点（可为负，Since 25.05）
- offset: x=INT y=INT（逻辑偏移）
- draw-behind-window: 布尔（为修复 CSD 圆角内阴影缺口而在窗口后面绘制）
- color/inactive-color: 颜色
（几何圆角由 window-rule 的 geometry-corner-radius 指定）

tab-indicator（Since 25.02）：
- off / hide-when-single-tab / place-within-column
- gap: 浮点（允许负值，表示覆盖到窗口）
- width: 浮点
- length total-proportion=FLOAT（默认 0.5）
- position: "left" | "right" | "top" | "bottom"
- gaps-between-tabs: 浮点
- corner-radius: 浮点
- active/inactive/urgent-color 与对应 gradient：同上色彩/渐变语法

insert-hint（插入位置提示，Since 0.1.10）：
- off
- color / gradient（同上）

struts（外边界缩进，逻辑像素；支持负值模拟“内/外间隙”）：
- left/right/top/bottom: 浮点

---

## workspace "NAME" {...}
命名工作区（始终存在；可与 open-on-output 结合固定到某输出）。
- open-on-output: 输出名（可用“厂商 型号 序列号”）
- 运行时可用动作 set-workspace-name/unset-workspace-name 动态改名（Since 25.01）。
- 命名工作区更“粘”原输出（Since 25.02）。

---

## 顶层选项（Miscellaneous）
- spawn-at-startup "prog" ["args" ...]
  - 语义同 binds.spawn；如果使用 systemd --session，XDG Autostart 也可用。
- prefer-no-csd: Flag（请求客户端去除 CSD；配合 tiled-state 行为更佳；更改后重启应用以生效完整效果）
- screenshot-path: 路径模板（支持 ~ 与 strftime；或 null 禁止落盘）
- environment { KEY "VAL" | KEY null }
- cursor {
  - xcursor-theme: 主题名
  - xcursor-size: 整数
  - hide-when-typing: Flag
  - hide-after-inactive-ms: 毫秒
}
- overview（Since 25.05）{
  - zoom: 0..0.75（越小越缩）
  - backdrop-color: 颜色（忽略 alpha）
  - workspace-shadow: 参照 layout.shadow 语法；注意需更大的 softness/spread/offset
}
- xwayland-satellite（Since next release）{
  - off（禁用一体化集成）
  - path: 二进制路径（默认 "xwayland-satellite"）
}
- clipboard {
  - disable-primary: Flag（禁用选中即复制/中键粘贴）
}
- hotkey-overlay {
  - skip-at-startup: Flag（启动时不显示重要热键提示）
  - hide-not-bound: Flag（Since next release；隐藏未绑定的动作）
}

---

## window-rule {}
按窗口匹配并应用属性（按出现顺序处理；无法“取消”只可覆盖，需用 exclude 排除）。

匹配器（match / exclude，支持多条件合取；正则用 r#"..."#）：
- title: 正则（匹配窗口标题任意位置）
- app-id: 正则（匹配应用 ID 任意位置）
- is-active: true|false（活动窗口，按工作区/显示器定义）
- is-focused: true|false（键盘焦点窗口，唯一）
- is-active-in-column: true|false（每列的“活动窗口”；Since 0.1.6）
- is-floating: true|false（浮动窗口；Since 25.01）
- is-window-cast-target: true|false（被窗口级投屏捕获；Since 25.02）
- is-urgent: true|false（请求关注；Since 25.05）
- at-startup: true|false（启动后 60 秒内）

“开窗时”一次性属性：
- default-column-width { proportion FLOAT | fixed INT }
- default-window-height { proportion FLOAT | fixed INT }（Since 25.01）
- open-on-output: 输出名（含“厂商 型号 序列号”支持）
- open-on-workspace: 工作区名（命名工作区）
- open-maximized: 布尔
- open-fullscreen: 布尔
- open-floating: 布尔（Since 25.01）
- open-focused: 布尔（是否在打开时给予焦点；Since 25.01）

“持续”动态属性：
- block-out-from: "screencast" | "screen-capture"（投屏/所有截屏中打黑）
- opacity: 0.0..1.0（叠加于客户端自身透明度）
- variable-refresh-rate: 布尔（与 output.on-demand 结合）
- default-column-display: "normal" | "tabbed"（Since 25.02）
- default-floating-position: x=INT y=INT [relative-to="top-left"|"top-right"|"bottom-left"|"bottom-right"|"top"|"bottom"|"left"|"right"]（Since 25.01）
- scroll-factor: 浮点（窗口滚动缩放；Since 25.02）
- draw-border-with-background: 布尔（覆盖是否以实心背景绘制边框/焦点环）
- focus-ring { off|on; width; 颜色/渐变 同 layout；on 优先于 off }
- border { off|on; 同上 }
- shadow { on|off; softness/spread/offset/color/inactive-color 同 layout；Since 25.02 }
- tab-indicator { 同 layout；Since 25.02 }
- geometry-corner-radius: 浮点 | 四值（TL,TR,BR,BL；用于边框/焦点环圆角；可配合剪裁）
- clip-to-geometry: 布尔（裁剪到可视几何，去除 CSD 阴影并按圆角裁剪）
- tiled-state: 布尔（向客户端声明“已平铺”；Since 25.05）
- baba-is-float: 布尔（愚人节趣味效果；Since 25.02）
- 尺寸覆盖：min-width/max-width/min-height/max-height（逻辑像素；注意 max-height 仅当等于 min-height 时对自动高有效）

实用：niri msg focused-window 可查当前窗口 title/app-id；Waybar wlr/taskbar 可在 tooltip 展示 {title}/{app_id}。

---

## layer-rule {}
与 window-rule 类似，匹配 layer-shell 表面（通知/启动器/壁纸等）。

匹配器：
- namespace: 正则（niri msg layers 可查看）
- at-startup: true|false

动态属性：
- block-out-from: "screencast" | "screen-capture"
- opacity: 0.0..1.0
- shadow { on|off; softness/spread/offset/color 等，注意需客户端去除自带边距/阴影 }
- geometry-corner-radius: 浮点（仅影响阴影圆角）
- place-within-backdrop: true（将背景层嵌入总览幕布，典型用于壁纸；Since 25.05）
- baba-is-float: 布尔（Since 25.05）

---

## animations {}
全局动画控制与各子动画配置。
- off: Flag（关闭所有动画；也可在各子动画内单独 off）
- slowdown: 浮点（全局放慢系数；<1 加速）

动画类型：
- Easing：
  - duration-ms: 毫秒
  - curve: "ease-out-quad" | "ease-out-cubic" | "ease-out-expo" | "linear"
- Spring：
  - spring damping-ratio=0.1..10.0（建议 ≤1.0） stiffness=FLOAT epsilon=FLOAT
  - 注：质量固定为 1.0；可用 Elastic 应用可视化；过阻尼可能有数值不稳。

可配置动画键（默认类型）：
- workspace-switch（spring）
- window-open（easing；支持 custom-shader）
- window-close（easing；支持 custom-shader）
- horizontal-view-movement（spring）
- window-movement（spring）
- window-resize（spring；支持 custom-shader）
- config-notification-open-close（spring，轻微回弹）
- screenshot-ui-open（easing）
- overview-open-close（spring）

同步动画：相关动作会驱动相同配置以保持观感一致（如调整尺寸导致视图移动时共用 window-resize 的参数）。

---

## gestures {}
- dnd-edge-view-scroll {
  - trigger-width: 浮点（触发区宽，逻辑像素）
  - delay-ms: 毫秒（延迟触发）
  - max-speed: 浮点（逻辑像素/秒）
}
- dnd-edge-workspace-switch（Since 25.05）{
  - trigger-height: 浮点（触发区高）
  - delay-ms: 毫秒
  - max-speed: 浮点（1500≈每秒一屏高）
}
- hot-corners {
  - off: Flag（禁用左上角开启总览；拖拽中同样有效）
}

---

## debug {}
仅用于调试/实验，可能随时变更（不受兼容保证）。
- preview-render: "screencast" | "screen-capture"（预览打黑/投屏路径）
- enable-overlay-planes: Flag（启用覆盖平面直出）
- disable-cursor-plane: Flag（禁用光标平面）
- disable-direct-scanout: Flag（禁用主/覆盖平面直出）
- restrict-primary-scanout-to-matching-format: Flag（限制主平面直出需与合成链格式完全一致）
- render-drm-device: 路径（选择渲染 DRM 设备）
- force-pipewire-invalid-modifier: Flag（PipeWire 使用 invalid modifier；Since 25.01）
- dbus-interfaces-in-non-session-instances: Flag（非 session 也创建 D-Bus 接口）
- wait-for-frame-completion-before-queueing: Flag（排查同步/性能）
- emulate-zero-presentation-time: Flag（模拟 NVIDIA 上 0 呈现时间）
- disable-resize-throttling: Flag（禁用窗口 resize 节流；Since 0.1.9）
- disable-transactions: Flag（禁用联合事务；Since 0.1.9）
- keep-laptop-panel-on-when-lid-is-closed: Flag（合盖保持内屏）
- disable-monitor-names: Flag（禁用 EDID 名称；绕过 0.1.9/0.1.10 双同款屏崩溃）
- strict-new-window-focus-policy: Flag（严格依赖 xdg-activation 获焦；Since 25.01）
- honor-xdg-activation-with-invalid-serial: Flag（接受无效 serial 的激活；Since 25.05）
- skip-cursor-only-updates-during-vrr: Flag（VRR 时略过仅因指针移动触发的重绘；Since next release）
- deactivate-unfocused-windows: Flag（为解决 Chromium/Electron 的 Activated 误用；Since next release）
- keep-max-bpc-unchanged: Flag（不强制 max bpc=8；AMDGPU 某些显示器问题；Since next release）

调试相关快捷键（配置于 binds）：
- toggle-debug-tint（直出检测，非直出加绿染色）
- debug-toggle-opaque-regions（不透明/非不透明着色对比；Since 0.1.6）
- debug-toggle-damage（损伤区域着色；Since 0.1.6）

---

## 实用命令/工具
- niri validate（校验配置）
- niri msg outputs（枚举输出/模式/VRR 能力）
- niri msg focused-window（当前窗口 title/app-id 等）
- niri msg layers（列出 layer-shell namespace）
- niri msg action（列出动作与说明）
- wev（键名识别）、libinput debug-events（按钮码）

## 颜色/渐变输入格式速查
- 颜色：CSS 命名色；#rgb/#rgba/#rrggbb/#rrggbbaa；rgb()/rgba()/hsl()/…
- 渐变：linear-gradient 风格（angle/from/to），支持颜色空间 in=srgb|srgb-linear|oklab|oklch…；relative-to 可相对工作区视图。

## 注意与兼容
- VRR 可能导致光标低帧率、闪屏等；必要时结合 debug 选项或 on-demand 使用。
- prefer-no-csd 更改对已运行应用不完全生效；重启应用以彻底应用。
- 某些“next release”项需使用更新版本或 git 构建。

参考：
- 配置总览与语法：https://github.com/YaLTeR/niri/wiki/Configuration:-Introduction
- 输入：https://github.com/YaLTeR/niri/wiki/Configuration:-Input
- 输出：https://github.com/YaLTeR/niri/wiki/Configuration:-Outputs
- 绑定：https://github.com/YaLTeR/niri/wiki/Configuration:-Key-Bindings
- 开关事件：https://github.com/YaLTeR/niri/wiki/Configuration:-Switch-Events
- 布局：https://github.com/YaLTeR/niri/wiki/Configuration:-Layout
- 命名工作区：https://github.com/YaLTeR/niri/wiki/Configuration:-Named-Workspaces
- 顶层选项：https://github.com/YaLTeR/niri/wiki/Configuration:-Miscellaneous
- 窗口规则：https://github.com/YaLTeR/niri/wiki/Configuration:-Window-Rules
- Layer 规则：https://github.com/YaLTeR/niri/wiki/Configuration:-Layer-Rules
- 动画：https://github.com/YaLTeR/niri/wiki/Configuration:-Animations
- 手势：https://github.com/YaLTeR/niri/wiki/Configuration:-Gestures
- 调试：https://github.com/YaLTeR/niri/wiki/Configuration:-Debug-Options

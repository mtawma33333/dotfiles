# wezterm 配置

ref: https://github.com/KevinSilvester/wezterm-config

## 目录结构

```
.wezterm/
  ├── wezterm.lua             ← 主入口
  ├── colors/custom.lua       ← Catppuccin Mocha 主题 + 调色板
  ├── config/
  │   ├── appearance.lua      ← 前端
  │   ├── bindings.lua        ← 禁用默认键绑定 / 所有自定义绑定 / 鼠标绑定
  │   ├── domains.lua         ← SSH 域（localhost） / WSL：Ubuntu-fish OR Ubuntu-bash / 默认工作目录 & 默认程序
  │   ├── fonts.lua           ← 字体配置 (JetBrainsMono Nerd Font Medium 14px FreeType)
  │   ├── general.lua         ← 通用配置 (自动重载 / 退出行为 / 滚动历史 / 超链接规则)
  │   ├── init.lua            ← 配置入口 
  │   └── launch.lua          ← 启动配置 (默认启动程序 / 启动菜单列表）
  ├── events/
  │   ├── gui-startup.lua     ← 启动时最大化窗口
  │   ├── left-status.lua     ← 状态栏（左）
  │   ├── right-status.lua    ← 状态栏（右）
  │   ├── tab-title.lua       ← 制表符标题栏
  │   └── new-tab-button.lua  ← 右键新标签按钮打开启动菜单
  └── utils/
      ├── cells.lua           ← 状态栏 / 标题栏 渲染工具
      ├── gpu-adapter.lua     ← GPU 适配器自动选择
      ├── math.lua
      ├── opts-validator.lua
      ├── platform.lua
      └── str.lua
```

## 核心功能

1. GPU 适配器自动选择
  - Windows：Dx12 > Vulkan > OpenGL
  - Linux：Vulkan > OpenGL
  - Mac：Metal
  - 按设备类型（Discrete > Integrated > Other > CPU）优先级排序

2. 状态栏
  - 左侧：键表名称 / 按键图标
  - 右侧：时间（%a %H:%M:%S） + 电池电量 + 充电图标

3. 制表符标题栏
  - 显示进程名称
  - 进度条（indeterminate / percentage / error）
  - 未读输出计数（带数字角标）
  - WSL / 管理员 / 调试 / 启动器 图标

4. 新标签按钮右键菜单
  - 启动菜单（PowerShell / CMD / Git Bash / WSL / SSH）

5. 其他
  - 自动重载配置
  - 窗口启动时最大化
  - 自定义键表（字体/面板调整）
  - 禁用 WezTerm 默认键绑定

## 安装

```bash
git clone https://github.com/KevinSilvester/wezterm-config.git ~/.config/wezterm
```

要求
- WezTerm 2024-01-27 或更高（推荐 Nightly）
- JetBrainsMono Nerd Font
- Windows：pwsh / fish / Ubuntu（WSL）

## 键绑定

### 平台区分

MacOs:
- SUPER → Super
- SUPER_REV → Super + Ctrl

Windows & Linux:
- SUPER → Alt
- SUPER_REV → Alt + Ctrl

all platforms:
- LEADER → SUPER_REV + Space

### Miscellaneous/Useful

- F1: 打开复制模式`ActivateCopyMode`
- F2: 打开目录面板`ActivateCommandPalette`
- F3: 打开启动菜单`ShowLauncher`
- F4: 打开启动菜单(tabs only)
- F5: 打开启动菜单(workspace only)
- F11: 全屏切换`ToggleFullScreen`
- F12: 打开调试`ShowDebugOverlay`

### Tabs

- SUPER + t: 新建标签`SpawnTab`(DefaultDomain)
- SUPER_REV + t: 新建标签`SpawnTab`(WSL:Ubuntu)
- SUPER_REV + w: 关闭标签`CloseCurrentTab`
- SUPER + [: 跳转到下一个标签
- SUPER + ]: 跳转到上一个标签
- SUPER_REV + [: 移动标签到前一个位置
- SUPER_REV + ]: 移动标签到后一个位置
- SUPER + 9: 切换标签栏显示
- SUPER + 0: 重命名当前标签
- SUPER_REV + 0: 撤回标签命名

### Windows
- SUPER + n: 新建窗口`SpawnWindow`
- SUPER + =: 增大窗口大小(disabled on Windows due to a bug)
- SUPER + -: 减小窗口大小(disabled on Windows due to a bug)

### Panes
- SUPER + \: 分割面板`SplitVertical`(CurrentPaneDomain)
- SUPER + |: 分割面板`SplitHorizontal`(CurrentPaneDomain)
- SUPER + Enter: 切换面板最大化`TogglePaneZoomState`
- SUPER + w: 关闭面板`CloseCurrentPane`
- SUPER_REV + k: 切换面板(↑)
- SUPER_REV + j: 切换面板(↓)
- SUPER_REV + h: 切换面板(←)
- SUPER_REV + l: 切换面板(→)
- SUPER_REV + p: 交换面板位置
- SUPER + u: 向上滚动 5 行
- SUPER + d: 向下滚动 5 行
- PageUp: 向上滚动一页
- PageDown: 向下滚动一页

### Cursor Movements

- SUPER + ←: 移动到行始
- SUPER + →: 移动到行末
- SUPER + Backspace: 删除行(does not work in PowerShell or cmd)

### Mouse
- Ctrl + leftclick(url): 打开超链接
- Ctrl + rightclick(newTabButton): 打开启动菜单

## 高级用法

1. 手动选择 GPU
```lua
    webgpu_preferred_adapter = gpu_adapters:pick_manual('Dx12', 'IntegratedGpu')
```

2. 锁定制表符名称
```lua
    window:perform_action(act.EmitEvent('tabs.manual-update-tab-title'), pane)
```

3. 禁用制表符进度显示
```lua
    tab-title:setup({ show_progress = false })
```

## 常见问题

- 字体缺失：安装 Nerd Font
- GPU 选择失败：注释 webgpu_power_preference 行或手动指定
- WSL 连接慢：使用 fish 而非 bash
- 键冲突：Windows 原生键优先级更高

-- ================================
-- Yazi 高级初始化脚本 (init.lua)
-- 提供现代化文件管理器的增强功能
-- ================================

-- ===== 状态栏增强 =====
-- 自定义状态栏显示更多有用信息
function Status:name()
  local h = self._tab.current.hovered
  if not h then
    return ui.Line {}
  end

  local linked = ""
  if h.link_to then
    linked = " -> " .. tostring(h.link_to)
  end

  -- 显示文件权限（如果是文件）
  local permissions = ""
  if not h.cha.is_dir then
    permissions = string.format(" [%o]", h.cha.permissions)
  end

  return ui.Line(" " .. h.name .. linked .. permissions)
end

-- 增强文件大小显示
function Status:size()
  local h = self._tab.current.hovered
  if not h then
    return ui.Line {}
  end

  local size = h.cha.len
  if size == 0 then
    return ui.Line("")
  end

  -- 智能单位转换
  local units = {"B", "K", "M", "G", "T"}
  local unit_index = 1
  while size >= 1024 and unit_index < #units do
    size = size / 1024
    unit_index = unit_index + 1
  end

  if unit_index == 1 then
    return ui.Line(string.format("%d %s", size, units[unit_index]))
  else
    return ui.Line(string.format("%.1f %s", size, units[unit_index]))
  end
end

-- ===== 智能预览增强 =====
-- 根据文件类型和大小智能决定预览方式
function Manager:peek(force)
  local hovered = self.current.hovered
  if not hovered or hovered.cha.is_dir then
    return
  end

  -- 大文件跳过预览（超过50MB）
  if hovered.cha.len > 50 * 1024 * 1024 then
    return
  end

  -- 二进制文件检测
  local name = hovered.name:lower()
  local binary_exts = {
    ".exe", ".bin", ".so", ".dylib", ".dll", 
    ".zip", ".rar", ".7z", ".tar", ".gz",
    ".mp4", ".avi", ".mkv", ".mov",
    ".jpg", ".jpeg", ".png", ".gif", ".bmp"
  }
  
  for _, ext in ipairs(binary_exts) do
    if name:match(ext .. "$") then
      return self:_peek(force)
    end
  end

  return self:_peek(force)
end

-- ===== 快速操作增强 =====
-- 智能文件操作
function Manager:create(opts)
  local input = ""
  if opts and opts.dir then
    input = Input:new({
      title = "Create directory:",
      value = "",
      realtime = false
    })
  else
    input = Input:new({
      title = "Create file:",
      value = "",
      realtime = false
    })
  end

  local callback = function(value)
    if value and value ~= "" then
      if opts and opts.dir then
        -- 创建目录
        os.execute("mkdir -p " .. ya.quote(self.cwd.url.path .. "/" .. value))
      else
        -- 创建文件
        local file_path = self.cwd.url.path .. "/" .. value
        local file = io.open(file_path, "w")
        if file then
          file:close()
        end
      end
      self:refresh()
    end
  end

  input:show(callback)
end

-- ===== 搜索增强 =====
-- 智能搜索功能
function Manager:find_smart()
  local input = Input:new({
    title = "Smart search:",
    value = "",
    realtime = true
  })

  local callback = function(value)
    if value and value ~= "" then
      -- 支持正则表达式搜索
      self:find(value, { smart = true, regex = true })
    end
  end

  input:show(callback)
end

-- ===== Git 集成增强 =====
-- 显示 Git 状态
function Status:gitignore()
  local cwd = self._tab.current.cwd
  if not cwd then
    return ui.Line {}
  end

  -- 检查是否在 Git 仓库中
  local git_dir = cwd.url.path .. "/.git"
  local stat = fs.stat(git_dir)
  if not stat or stat.cha.typ ~= fs.CHA_DIR then
    return ui.Line {}
  end

  return ui.Line(" 🌿")
end

-- ===== 书签系统 =====
-- 快速书签功能
local bookmarks = {
  h = os.getenv("HOME"),
  c = os.getenv("HOME") .. "/.config",
  d = os.getenv("HOME") .. "/Downloads",
  D = os.getenv("HOME") .. "/Documents",
  p = os.getenv("HOME") .. "/Pictures",
  v = os.getenv("HOME") .. "/Videos",
  m = os.getenv("HOME") .. "/Music",
}

function Manager:bookmark_jump(key)
  local path = bookmarks[key]
  if path and fs.stat(path) then
    self:cd(path)
  end
end

-- ===== 性能优化 =====
-- 缓存优化
ya.sync(function()
  -- 预加载常用目录
  local common_dirs = {
    os.getenv("HOME"),
    os.getenv("HOME") .. "/.config",
    os.getenv("HOME") .. "/Downloads"
  }
  
  for _, dir in ipairs(common_dirs) do
    if fs.stat(dir) then
      -- 预缓存目录内容
      Manager:cd(dir, { cache_only = true })
    end
  end
end)

-- ===== 主题动态调整 =====
-- 根据时间自动调整主题亮度
function Theme:auto_adjust()
  local hour = tonumber(os.date("%H"))
  
  -- 夜间模式 (18:00 - 06:00)
  if hour >= 18 or hour <= 6 then
    -- 降低亮度
    self.manager.cwd = { fg = "darkblue", bold = true }
    self.manager.hovered = { bg = "black", bold = true }
  else
    -- 日间模式
    self.manager.cwd = { fg = "lightblue", bold = true }
    self.manager.hovered = { bg = "darkgray", bold = true }
  end
end

-- 初始化主题调整
-- Theme:auto_adjust()

-- ===== 键位绑定增强 =====
-- 添加自定义命令
ya.setup {
  commands = {
    -- 智能搜索命令
    find_smart = function()
      Manager:find_smart()
    end,
    
    -- 书签跳转命令
    bookmark_jump = function(_, args)
      if args and args[1] then
        Manager:bookmark_jump(args[1])
      end
    end,
    
    -- 批量重命名
    bulk_rename = function()
      -- TODO: 实现批量重命名功能
    end,
  }
}

-- ===== 文件类型检测增强 =====
-- 改进的 MIME 类型检测
function File:mime_type()
  local name = self.name:lower()
  
  -- 编程语言文件
  local code_extensions = {
    [".rs"] = "text/x-rust",
    [".py"] = "text/x-python", 
    [".js"] = "text/javascript",
    [".ts"] = "text/typescript",
    [".jsx"] = "text/jsx",
    [".tsx"] = "text/tsx",
    [".go"] = "text/x-go",
    [".java"] = "text/x-java",
    [".c"] = "text/x-c",
    [".cpp"] = "text/x-cpp",
    [".h"] = "text/x-c-header",
    [".hpp"] = "text/x-cpp-header"
  }
  
  for ext, mime in pairs(code_extensions) do
    if name:match(ext .. "$") then
      return mime
    end
  end
  
  -- 回退到系统检测
  return self:_mime_type()
end

-- ===== 启动消息 =====
ya.notify {
  title = "Yazi Enhanced",
  content = "现代化文件管理器配置已加载",
  timeout = 2
}

-- ===============================================================================
--                          Yazi 初始化配置文件
-- ===============================================================================
-- 此文件在 Yazi 启动时自动加载，用于初始化插件和自定义配置

-- ===== 插件配置区域 =====
-- 在这里可以配置自定义插件的设置

-- 示例：配置插件设置
-- require("smart-enter"):setup({
--     auto_open = true
-- })

-- ===== 全局设置 =====
-- 设置一些全局变量或配置

-- ===== 自定义函数 =====
-- 在这里可以定义一些全局可用的辅助函数

-- 获取文件扩展名的辅助函数
function get_file_extension(filename)
    return filename:match("%.([^%.]+)$")
end

-- 格式化文件大小的辅助函数
function format_file_size(size)
    if size < 1024 then
        return size .. " B"
    elseif size < 1024 * 1024 then
        return string.format("%.1f KB", size / 1024)
    elseif size < 1024 * 1024 * 1024 then
        return string.format("%.1f MB", size / 1024 / 1024)
    else
        return string.format("%.1f GB", size / 1024 / 1024 / 1024)
    end
end


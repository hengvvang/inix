--- @sync entry

return {
	entry = function(state, job)
		local h = cx.active.current.hovered
		if not h then
			ya.notify({ title = "File Size", content = "No file selected", timeout = 3 })
			return
		end

		local size_text
		if h.cha.is_dir then
			size_text = "Directory"
		else
			local size = h.cha.len
			if size < 1024 then
				size_text = size .. " B"
			elseif size < 1024 * 1024 then
				size_text = string.format("%.1f KB", size / 1024)
			elseif size < 1024 * 1024 * 1024 then
				size_text = string.format("%.1f MB", size / 1024 / 1024)
			else
				size_text = string.format("%.1f GB", size / 1024 / 1024 / 1024)
			end
		end

		ya.notify({
			title = "File Size",
			content = h:name() .. ": " .. size_text,
			timeout = 3,
		})
	end,
}

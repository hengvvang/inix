--- @sync entry

return {
	entry = function(state, job)
		local value = ya.input({
			title = "Create directory:",
			position = { "top-center", y = 3, w = 40 },
		})

		if value and value ~= "" then
			local target = cx.active.current.cwd:join(value)
			local ok, err = fs.create_dir_all(target)
			if ok then
				ya.manager_emit("refresh", {})
			else
				ya.err("Failed to create directory: " .. tostring(err))
			end
		end
	end,
}

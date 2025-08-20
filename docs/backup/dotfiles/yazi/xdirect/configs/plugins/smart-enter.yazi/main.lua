--- @sync entry

return {
	entry = function(state, job)
		local h = cx.active.current.hovered
		if not h then
			return
		end

		if h.cha.is_dir then
			ya.manager_emit("enter", { hovered = true })
		else
			ya.manager_emit("open", { hovered = true })
		end
	end,
}

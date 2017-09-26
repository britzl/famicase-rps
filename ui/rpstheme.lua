local gooey = require "gooey.gooey"


local M = {}


local function shake(node, initial_scale)
	gui.cancel_animation(node, "scale.x")
	gui.cancel_animation(node, "scale.y")
	gui.set_scale(node, initial_scale)
	local scale = gui.get_scale(node)
	gui.set_scale(node, scale * 1.2)
	gui.animate(node, "scale.x", scale.x, gui.EASING_OUTELASTIC, 0.8)
	gui.animate(node, "scale.y", scale.y, gui.EASING_OUTELASTIC, 0.8, 0.05, function()
		gui.set_scale(node, initial_scale)
	end)
end


function M.acquire_input()
	gooey.acquire_input()
end


function M.button(node_id, action_id, action, fn)
	local button = gooey.button(node_id .. "/bg", action_id, action, fn)
	if button.pressed_now or button.released_now then
		shake(button.node, vmath.vector3(1))
	end
	if button.pressed then
		--gui.play_flipbook(button.node, hash("blue_button05"))
	else
		gui.play_flipbook(button.node, hash("button"))
	end
	return button
end

return M
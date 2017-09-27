local settings = require "utils.settings"
local opponents = require "game.opponents"

local M = {}

settings.unlocks = settings.unlocks or {}
settings.save()


function M.music()
	return settings.music
end

function M.sfx()
	return settings.sfx
end

function M.toggle_music()
	settings.music = not settings.music
	settings.save()
	if settings.music then
		msg.post("controller:/sounds#music", "play_sound", { gain = 0.5 })
	else
		msg.post("controller:/sounds#music", "stop_sound")
	end
end

function M.toggle_sfx()
	settings.sfx = not settings.sfx
	settings.save()
end

function M.is_unlocked(id)
	return settings.unlocks[id] == true
end


function M.unlock(id)
	if id then
		settings.unlocks[id] = true
		settings.save()
	end
end

function M.unlock_next(id)
	for i,opponent_id in ipairs(opponents.IDS) do
		if opponent_id == id then
			M.unlock(opponents.IDS[i + 1])
			break
		end
	end
end


return M


local savetable = require "ludobits.m.savetable"


local M = {}

local settings = savetable.open("settings").load()
if settings.music == nil then
	settings.music = true
end

if settings.sfx == nil then
	settings.sfx = true
end


function M.save()
	savetable.open("settings").save(settings)
end

function M.load()
	settings = savetable.open("settings").load()
	return settings
end

local mt = {}
function mt.__index(t, k)
	return settings[k]
end
function mt.__newindex(t, k, v)
	settings[k] = v
end


return setmetatable(M, mt)

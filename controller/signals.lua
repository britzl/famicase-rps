local signal = require "ludobits.m.signal"

local M = {}

M.GAME_FINISHED = signal.create(hash("GAME_FINISHED"))


return M
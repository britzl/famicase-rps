local M = {}

M.ROCK = hash("rock")
M.PAPER = hash("paper")
M.SCISSORS = hash("scissor")

M.DRAW = "draw"
M.WIN = "win"
M.LOSS = "loss"


local function reverse(t)
	local r = {}
	for i=1,#t do
		r[i] = t[#t + 1 - i]
	end
	return r
end

local PAPER_POINTS = {
	{ x = 0.0, y = 0.0 },
	{ x = 0.1, y = 0.1 },
	{ x = 0.2, y = 0.2 },
	{ x = 0.3, y = 0.3 },
	{ x = 0.4, y = 0.4 },
	{ x = 0.5, y = 0.5 },
	{ x = 0.6, y = 0.6 },
	{ x = 0.7, y = 0.7 },
	{ x = 0.8, y = 0.8 },
	{ x = 0.9, y = 0.9 },
	{ x = 1.0, y = 1.0 },
}

local SCISSORS_POINTS = {
	{ x = 0.0, y = 1.0 },
	{ x = 0.2, y = 0.9 },
	{ x = 0.4, y = 0.8 },
	{ x = 0.6, y = 0.7 },
	{ x = 0.8, y = 0.6 },
	{ x = 1.0, y = 0.5 },
	{ x = 0.8, y = 0.4 },
	{ x = 0.6, y = 0.3 },
	{ x = 0.4, y = 0.2 },
	{ x = 0.2, y = 0.1 },
	{ x = 0.0, y = 0.0 },
}

M.GESTURES = {
	{
		char = "P",
		symbol = M.PAPER,
		points = PAPER_POINTS,
	},
	{
		char = "P",
		symbol = M.PAPER,
		points = reverse(PAPER_POINTS),
	},
	{
		char = "S",
		symbol = M.SCISSORS,
		points = SCISSORS_POINTS,
	},
	{
		char = "S",
		symbol = M.SCISSORS,
		points = reverse(SCISSORS_POINTS),
	},
}

for a=0,360,30 do
	local gesture = {
		char = "R",
		symbol = M.ROCK,
		points = {},
	}
	for o=0,360,30 do
		local rad = math.rad(a + o)
		local x = (1 + math.sin(rad)) / 2
		local y = (1 + math.cos(rad)) / 2
		table.insert(gesture.points, { x = x, y = y })
	end
	table.insert(M.GESTURES, gesture)
end


function M.get(symbol)
	for _,gesture in pairs(M.GESTURES) do
		if gesture.symbol == symbol then
			return gesture
		end
	end
end

function M.evaluate(a, b)
	if a == b then
		return M.DRAW
	end
	if a == M.ROCK and b == M.SCISSORS then
		return M.WIN
	elseif a == M.PAPER and b == M.ROCK then
		return M.WIN
	elseif a == M.SCISSORS and b == M.PAPER then
		return M.WIN
	end
	return M.LOSS
end


function M.char_to_symbol(char)
	if char == "?" then
		local i = math.random(1, 3)
		char = ("RPS"):sub(i, i)
	end	
	if char == "R" then
		return M.ROCK
	elseif char == "P" then
		return M.PAPER
	elseif char == "S" then
		return M.SCISSORS
	end
end


function M.spawn_symbol(symbol, position)
	return factory.create("game:/game#symbolfactory", position or vmath.vector3(160, 650, 0), nil, { symbol_type = symbol })
end

return M
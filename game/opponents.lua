local rps = require "game.rps"

local M = {}

local function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end


M.TUTORIAL = { "tutorial" }

M.BATTLE = { "borg", "threeeye", "grunt" }

local emotes = {
	"You're sleepy now",
	"Your silhouette is so stationary",
	"It's confusing these days",
	"Moondust will cover you",
	"This chaos is killing me",
}

local opponents = {
	tutorial = {
		name = "The Trainer",
		portrait = hash("borg"),
		interval = 6,
		speed = 12,
		health = 3,
		pattern = "RPS",
		damage = { [rps.ROCK] = 1, [rps.PAPER] = 1, [rps.SCISSORS] = 1 },
		emotes_won = { "Aww, that was close! Better luck next time. Come back if you want to practice some more." },
		emotes_lost = { "Well done! Now you know everything there is to know about Rock, Paper and Scissors." },
	},
	borg = {
		name = "Cy the Borg",
		portrait = hash("borg"),
		interval = 2.5,
		speed = 8,
		health = 8,
		pattern = "RPS",
		damage = { [rps.ROCK] = 1, [rps.PAPER] = 1, [rps.SCISSORS] = 1 },
		powerups = { hash("meteorshower"), hash("papercut"), hash("cloakingdevice") },
		emotes = emotes,
		emotes_won = { "If it bleeds, we can kill it", "Take that you sack of meat!" },
		emotes_lost = { "Syntax error!", "Does not compute!" },
	},
	threeeye = {
		name = "Threeeye",
		portrait = hash("threeeye"),
		interval = 2.5,
		speed = 8,
		health = 8,
		pattern = "RPS",
		damage = { [rps.ROCK] = 1, [rps.PAPER] = 1, [rps.SCISSORS] = 1 },
		powerups = { hash("meteorshower"), hash("papercut"), hash("cloakingdevice") },
		emotes = emotes,
		emotes_won = { "Take that you filthy Terran!", "Weak Terrans are no match for my might!" },
		emotes_lost = { "Curse you and your dirty socks!", "You stink worse than old cheese!" },
	},
	grunt = {
		name = "Gorkan the Grunt",
		portrait = hash("grunt"),
		interval = 2.5,
		speed = 8,
		health = 8,
		pattern = "RPS",
		damage = { [rps.ROCK] = 1, [rps.PAPER] = 1, [rps.SCISSORS] = 1 },
		powerups = { hash("meteorshower"), hash("papercut"), hash("cloakingdevice") },
		emotes = emotes,
		emotes_won = { "You hit like a vegetarian!" },
		emotes_lost = { "Whaaaaargh! That hurt!" },
	},
}


function M.get(id)
	local o = deepcopy(opponents[id])
	o.max_health = o.health
	o.power = 0
	return o
end

return M
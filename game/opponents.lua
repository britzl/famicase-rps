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


M.IDS = { "tutorial", "borg", "threeeye", "grunt", "mohawk", "twoface", "hivequeen" }

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
		portrait = hash("trainer"),
		interval = 6,
		speed = 12,
		health = 3,
		pattern = "RPS",
		damage = { [rps.ROCK] = 1, [rps.PAPER] = 1, [rps.SCISSORS] = 1 },
		emotes_won = { "Aww, that was close! Better luck next time. Come back if you want to practice some more." },
		emotes_lost = { "Well done! Now you know everything there is to know about Rock, Paper and Scissors." },
		screen = hash("tutorial"),
	},
	borg = {
		name = "Cy the Borg",
		portrait = hash("borg"),
		interval = 2.5,
		speed = 8,
		health = 4,
		pattern = "RPS",
		damage = { [rps.ROCK] = 1, [rps.PAPER] = 1, [rps.SCISSORS] = 1 },
		powerups = { hash("cloakingdevice") },
		emotes = emotes,
		emotes_won = { "If it bleeds, we can kill it", "Take that you sack of meat!" },
		emotes_lost = { "Syntax error!", "Does not compute!" },
		screen = hash("game"),
	},
	threeeye = {
		name = "Threeeye",
		portrait = hash("threeeye"),
		interval = 2.5,
		speed = 6,
		health = 8,
		pattern = "RRRPPPSSS?",
		damage = { [rps.ROCK] = 1, [rps.PAPER] = 1, [rps.SCISSORS] = 1 },
		powerups = { hash("meteorshower"), hash("papercut"), hash("cloakingdevice") },
		emotes = emotes,
		emotes_won = { "Take that you filthy Terran!", "Weak Terrans are no match for my might!" },
		emotes_lost = { "Curse you and your dirty socks!", "You stink worse than old cheese!" },
		screen = hash("game"),
	},
	grunt = {
		name = "Gorkan the Grunt",
		portrait = hash("grunt"),
		interval = 2.5,
		speed = 4,
		health = 12,
		pattern = "RRRP?S?",
		damage = { [rps.ROCK] = 1, [rps.PAPER] = 1, [rps.SCISSORS] = 1 },
		powerups = { hash("meteorshower") },
		emotes = emotes,
		emotes_won = { "You hit like a vegetarian!" },
		emotes_lost = { "Whaaaaargh! That hurt!" },
		screen = hash("game"),
	},
	mohawk = {
		name = "Mohawk",
		portrait = hash("mohawk"),
		interval = 2.25,
		speed = 3.5,
		health = 16,
		pattern = "R?P?S?",
		damage = { [rps.ROCK] = 1, [rps.PAPER] = 1, [rps.SCISSORS] = 1 },
		powerups = { hash("meteorshower"), hash("papercut"), hash("cloakingdevice") },
		emotes = emotes,
		emotes_won = { "Another scalp for my belt!" },
		emotes_lost = { "I have shamed my ancestors by losing to a pale-faced Terran such as you!" },
		screen = hash("game"),
	},
	twoface = {
		name = "Two-face",
		portrait = hash("twoface"),
		interval = 2,
		speed = 3,
		health = 18,
		pattern = "RPS???",
		damage = { [rps.ROCK] = 1, [rps.PAPER] = 1, [rps.SCISSORS] = 1 },
		powerups = { },
		emotes = emotes,
		emotes_won = { "Yesss, we got you!" },
		emotes_lost = { "Nooo, he beat usss!" },
		screen = hash("game"),
	},
	hivequeen = {
		name = "The Hive Queen",
		portrait = hash("alien"),
		interval = 2,
		speed = 2,
		health = 20,
		pattern = "?",
		damage = { [rps.ROCK] = 1, [rps.PAPER] = 1, [rps.SCISSORS] = 1 },
		powerups = { hash("meteorshower"), hash("papercut"), hash("cloakingdevice") },
		emotes = emotes,
		emotes_won = { "You are no match to my superior intellect!" },
		emotes_lost = { "This cannot be! I will return..." },
		screen = hash("game"),
	},
}


function M.get(id)
	assert(id, "You must provide an id")
	assert(opponents[id], "No opponent with id " .. id)
	local o = deepcopy(opponents[id])
	o.max_health = o.health
	o.power = 0
	return o
end

return M
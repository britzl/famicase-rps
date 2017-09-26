local M = {}

M.TUTORIAL = { "tutorial" }

M.QUICKBATTLE = { "borg", "threeeye", "grunt" }

M.TOURNAMENT = {}

M.ALL = {
	tutorial = {
		name = "The Trainer",
		portrait = hash("wazoo"),
		interval = 6,
		speed = 12,
		health = 3,
		pattern = "RPS",
		emotes_won = { "Aww, that was close! Better luck next time. Come back if you want to practice some more." },
		emotes_lost = { "Well done! Now you know everything there is to know about Rock, Paper and Scissors." },
	},
	borg = {
		name = "Cy the Borg",
		portrait = hash("borg"),
		interval = 1.25,
		speed = 6,
		health = 8,
		pattern = "RPS",
		emotes_won = { "If it bleeds, we can kill it", "Take that you sack of meat!" },
		emotes_lost = { "Syntax error!", "Does not compute!" },
	},
	threeeye = {
		name = "Threeeye",
		portrait = hash("threeeye"),
		interval = 1.25,
		speed = 6,
		health = 8,
		pattern = "RPS",
		emotes_won = { "Take that you filthy Terran!" },
		emotes_lost = { "Curse you and your dirty socks!" },
	},
	grunt = {
		name = "Gorkan the Grunt",
		portrait = hash("grunt"),
		interval = 1.25,
		speed = 6,
		health = 8,
		pattern = "RPS",
		emotes_won = { "You hit like a vegetarian!" },
		emotes_lost = { "Whaaaaargh! That hurt!" },
	},
}


return M
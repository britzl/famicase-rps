local M = {}

local TOUCH = hash("touch")

function M.create(gestures)
	local instance = {}
	
	local points = {}
	
	local function similarity(p1, p2)
		return 2 - math.abs(p1.x - p2.x) - math.abs(p1.y - p2.y)
	end
	
	
	local function evaluate()
		if #points == 0 then
			print("no points")
			return nil
		end
		
		-- get the bounding box for all points
		local min_x = points[1].x
		local max_x = points[1].x
		local min_y = points[1].y
		local max_y = points[1].y
		for _,p in pairs(points) do
			min_x = math.min(min_x, p.x)
			max_x = math.max(max_x, p.x)
			min_y = math.min(min_y, p.y)
			max_y = math.max(max_y, p.y)
		end
		
		-- make the bounding box square
		-- and center it
		local dx = max_x - min_x
		local dy = max_y - min_y
		local dmax = math.max(dx, dy)
		if dmax == 0 then
			print("dmax 0")
			return
		end
		max_x = max_x + (dmax - dx) / 2
		min_x = min_x - (dmax - dx) / 2
		max_y = max_y + (dmax - dy) / 2
		min_y = min_y - (dmax - dy) / 2

		-- normalise points
		for _,p in pairs(points) do
			p.x = (p.x - min_x) / dmax
			p.y = (p.y - min_y) / dmax
		end
		
	
		local best = { score = 0, gesture = nil }
		for _,gesture in pairs(gestures) do
			local score = 0
			local len = #gesture.points
			local ratio = #points / len
			for i=1,len do
				local p1 = gesture.points[i]
				local p2 = points[math.max(1, math.floor(i * ratio))]
				score = score + similarity(p1, p2)
			end
			score = score / #gesture.points
			if score > best.score then
				best.gesture = gesture
				best.score = score
			end
		end
	
		return best.gesture
	end
	
	
	function instance.on_input(action_id, action)
		if action_id == TOUCH then
			if action.released then
				return evaluate()
			elseif action.pressed then
				points = {}
			end
			
			-- ignore samples too close in time?
			if true then
				table.insert(points, { x = action.x, y = action.y })
			end
		end
	end
	
	
	return instance
end



return M
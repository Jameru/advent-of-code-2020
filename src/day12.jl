using Match

function solve_ship(input)
	dirs = [(1, 0), (0, 1), (-1, 0), (0, -1)]
	facing::Int64 = 1
	x = y = 0
	for instruction in input
		action = instruction[1]
		value::Int64 = parse(Int64, instruction[2:end])
		@match action begin
			'E' => begin
				x += value
			end
			'N' => begin
				y += value
			end
			'W' => begin
				x -= value
			end
			'S' => begin
				y -= value
			end
			'L' => begin
				facing = mod1(facing + value / 90, 4)
			end
			'R' => begin
				facing = mod1(facing - value / 90, 4)
			end
			'F' => begin
				x += dirs[facing][1] * value
				y += dirs[facing][2] * value
			end 
		end
	end
	abs(x) + abs(y)
end

function solve_waypoint(input, waypoint = [10 1])
	rotations_l = [
		[ 0  1; -1  0],
		[-1  0;  0 -1],
		[ 0 -1;  1  0],
		[ 1  0;  0  1]
	]
	rotations_r = [
		[ 0 -1;  1  0],
		[-1  0;  0 -1],
		[ 0  1; -1  0],
		[ 1  0;  0  1]
	]
	x = y = 0
	waypoint_pos = copy(waypoint)
	for instruction in input
		action = instruction[1]
		value::Int64 = parse(Int64, instruction[2:end])
		@match action begin
			'E' => begin
				waypoint_pos[1] += value
			end
			'N' => begin
				waypoint_pos[2] += value
			end
			'W' => begin
				waypoint_pos[1] -= value
			end
			'S' => begin
				waypoint_pos[2] -= value
			end
			'L' => begin
				waypoint_pos *= rotations_l[mod1(value ÷ 90, 4)]
			end
			'R' => begin
				waypoint_pos *= rotations_r[mod1(value ÷ 90, 4)]
			end
			'F' => begin
				x += waypoint_pos[1] * value
				y += waypoint_pos[2] * value
			end
		end
	end
	abs(x) + abs(y)
end

@assert solve_ship(eachline("input/test/test_day12.txt")) == 25 ["test case 1 failed"]
@assert solve_waypoint(eachline("input/test/test_day12.txt")) == 286 ["test case 2 failed"]

println("First star: " * string(solve_ship(eachline("input/day12.txt"))))
println("Second star: " * string(solve_waypoint(eachline("input/day12.txt"))))

function solve_for_slope(input, dx, dy)
	ret = 0
	x_coord = 1
	width, tail = Iterators.peel(input)
	width = length(width)
	for line in Iterators.partition(tail, dy)
		x_coord += dx
		if (x_coord > width)
			x_coord -= width
		end
		if (line[dy][x_coord] == '#')
			ret += 1
		end
	end
	ret
end

function solve_for_all(input)
	slopes = [(1, 1) (3, 1) (5, 1) (7, 1) (1, 2)]
	reduce(*, map(slp -> solve_for_slope(eachline(input), slp[1], slp[2]), slopes))
end

@assert solve_for_slope(eachline("input/test/test_day3.txt"), 3, 1) == 7 ["test case 1 failed"]
@assert solve_for_all("input/test/test_day3.txt") == 336 ["test case 2 failed"]

println("First star: " * string(solve_for_slope(eachline("input/day3.txt"), 3, 1)))
println("Second star: " * string(solve_for_all("input/day3.txt")))

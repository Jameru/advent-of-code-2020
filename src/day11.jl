function occupied_neig(matr, i, j)
	occ = 0
	for x in (i > 1 ? i - 1 : i):(i < length(matr) ? i + 1 : i)
		for y in (j > 1 ? j - 1 : j):(j < length(matr[i]) ? j + 1 : j)
			if (x != i || y != j) && matr[x][y] == '#'
				occ += 1
			end
		end
	end
	occ
end

function occupied_look(matr, i, j)
	occ = 0
	dirs = [(1, 0), (1, 1), (0, 1), (-1, 1), (-1, 0), (-1, -1), (0, -1), (1, -1)]
	for dir in dirs
		x = i + dir[1]
		y = j + dir[2]
		while (1 <= x && x <= length(matr)) && (1 <= y && y <= length(matr[x])) && matr[x][y] == '.'
			x += dir[1]
			y += dir[2]
		end
		if (1 <= x && x <= length(matr)) && (1 <= y && y <= length(matr[x])) && matr[x][y] == '#'
			occ += 1
		end
	end
	occ
end

function update(matr, occupied, tolerance)
	curr = copy(matr)
	next = [collect(str) for str in matr]
	for i in 1:length(curr)
		for j in 1:length(curr[i])
			if curr[i][j] == 'L' && occupied(curr, i, j) == 0
				next[i][j] = '#'
			elseif curr[i][j] == '#' && occupied(curr, i, j) >= tolerance
				next[i][j] = 'L'
			end
		end
	end
	[join(chars) for chars in next]
end

function solve_neig(input)
	curr = copy(input)
	prev = []
	while prev != curr	
		prev = copy(curr)
		curr = update(prev, occupied_neig, 4)
	end
	count(c -> c == '#', join(curr))
end

function solve_look(input)
	curr = copy(input)
	prev = []
	while prev != curr	
		prev = copy(curr)
		curr = update(prev, occupied_look, 5)
	end
	count(c -> c == '#', join(curr))
end

@assert solve_neig(readlines("input/test/test_day11.txt")) == 37 ["test case 1 failed"]
@assert solve_look(readlines("input/test/test_day11.txt")) == 26 ["test case 2 failed"]

input = readlines("input/day11.txt")
println("First star: " * string(@time solve_neig(input)))
println("Second star: " * string(@time solve_look(input)))

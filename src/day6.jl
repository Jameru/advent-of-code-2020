function solve_first(input)
	ret = 0
	lines = collect(Iterators.takewhile(line -> line != "", input))
	while length(lines) > 0
		ret += lines |> join |> unique |> length
		lines = collect(Iterators.takewhile(line -> line != "", input))
	end
	ret
end

function solve_second(input)
	ret = 0
	lines = collect(Iterators.takewhile(line -> line != "", input))
	while length(lines) > 0
		ret +=  count(char -> all(line -> contains(line, char), lines), collect(lines[1]))
		lines = collect(Iterators.takewhile(line -> line != "", input))
	end
	ret
end

@assert solve_first(eachline("input/test_day6.txt")) == 11 ["test case 1 failed"]
@assert solve_second(eachline("input/test_day6.txt")) == 6 ["test case 2 failed"]

println("First star: " * string(solve_first(eachline("input/day6.txt"))))
println("Second star: " * string(solve_second(eachline("input/day6.txt"))))

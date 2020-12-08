using Combinatorics

function solve(arr)
	pairs = collect(combinations(arr, 2));
	idx = findfirst(x -> x[1] + x[2] == 2020, pairs);
	pairs[idx][1] * pairs[idx][2]
end

function solve_for_2_better(input)
	arr = sort(input)
	lower_i = 1
	upper_i = length(arr)
	sum = arr[lower_i] + arr[upper_i]
	while sum != 2020
		if sum < 2020
			lower_i += 1
		else
			upper_i -= 1
		end
		sum = arr[lower_i] + arr[upper_i]
	end
	arr[lower_i] * arr[upper_i]
end

function solve_for_2_also_better(input)
	arr = zeros(2020)
	for x in input
		arr[x] = true
		if arr[2020 - x] == true
			return x * (2020 - x)
		end
	end
end

function solve_for_n(arr, n)
	pairs = collect(combinations(arr, n));
	idx = findfirst(x -> sum(x) == 2020, pairs);
	reduce(*, pairs[idx])
end

test_input = [1721, 979, 366, 299, 675, 1456];
@assert solve(test_input) == 514579 ["test case 1 failed"];
@assert solve_for_2_better(test_input) == 514579 ["test case 1a failed"];
@assert solve_for_2_also_better(test_input) == 514579 ["test case 1b failed"];
@assert solve_for_n(test_input, 3) == 241861950 ["test case 2 failed"];

input = map(x -> parse(Int64, x), readlines("input/day1.txt"));
println("First star: " * string(@time solve(input)))
println("First star: " * string(@time solve_for_2_better(input)))
println("First star: " * string(@time solve_for_2_also_better(input)))
println("Second star: " * string(@time solve_for_n(input, 3)))

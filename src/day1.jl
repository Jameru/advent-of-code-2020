using Combinatorics

function solve(arr)
	pairs = collect(combinations(arr, 2));
	idx = findfirst(x -> x[1] + x[2] == 2020, pairs);
	pairs[idx][1] * pairs[idx][2]
end

function solve_for_n(arr, n)
	pairs = collect(combinations(arr, n));
	idx = findfirst(x -> sum(x) == 2020, pairs);
	reduce(*, pairs[idx])
end

test_input = [1721 979 366 299 675 1456];
@assert solve(test_input) == 514579 ["solve(test_input, 2) failed"];
@assert solve_for_n(test_input, 3) == 241861950 ["solve(test_input, 3) failed"];

input = map(x -> parse(Int64, x), readlines("input/day1.txt"));
println("First star: " * string(solve(input)))
println("Second star: " * string(solve_for_n(input, 3)))

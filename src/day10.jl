function solve_plug_everything(input)
	arr = sort(input)
	ones = arr[1] == 1 ? 1 : 0
	twos = arr[1] == 2 ? 1 : 0
	threes = arr[1] == 3 ? 2 : 1
	for i in 2:length(arr)
		if arr[i] - arr[i - 1] == 1
			ones += 1
		elseif arr[i] - arr[i - 1] == 2
			twos += 1
		else
			threes += 1
		end
	end
	println("twos: " * string(twos)) # <- Note there are no twos!
	ones * threes
end

function solve_2(input)
	arr = sort(input)
	contiguous_ones = []
	ones = arr[1] == 1 ? 0 : -1
	for i in 2:length(arr)
		if arr[i] - arr[i - 1] == 1
			ones += 1
		else
			push!(contiguous_ones, ones)
			ones = -1
		end
	end
	push!(contiguous_ones, ones)
	reduce(*, calc_configs.(filter(x -> x > 0, contiguous_ones)), init = 1)
end

function calc_configs(n)::Int64
	2^n - (n - 2)*(n - 1)/2
end

@assert solve_plug_everything(parse.(Int64, readlines("input/test/test_day10.txt"))) == 220 ["test case 1 failed"]
@assert solve_2(parse.(Int64, readlines("input/test/test_day10.txt"))) == 19208 ["test case 2 failed"]

input = parse.(Int64, readlines("input/day10.txt"))
println("First star: " * string(solve_plug_everything(input)))
println("Second star: " * string(solve_2(input)))

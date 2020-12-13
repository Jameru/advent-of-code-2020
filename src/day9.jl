function solve_find_invalid(input, n)
	preamble = input[1:n]
	sums = zeros(Int64, n, n)
	for i in 1:n
		for j in i + 1:n
			sums[i,j] = preamble[i] + preamble[j]
		end
	end
	ret_i = n + 1
	while !isnothing(findfirst(x -> x == input[ret_i], sums))
		i = ret_i % n != 0 ? ret_i % n : n
		preamble[i] = input[ret_i]
		for j in filter(x -> x != i, 1:n)
			sums[i, j] = preamble[i] + preamble[j]
		end
		ret_i += 1
	end
	input[ret_i]
end

function solve_find_weakness(input, target)
	i = 2
	arr = input[1:2]
	while sum(arr) != target
		if sum(arr) < target
			i += 1
			push!(arr, input[i])
		else
			popfirst!(arr)
		end
	end
	minimum(arr) + maximum(arr)
end

@assert solve_find_invalid(parse.(Int64, readlines("input/test/test_day9.txt")), 5) == 127 ["test case 1 failed"]
@assert solve_find_weakness(parse.(Int64, readlines("input/test/test_day9.txt")), 127) == 62 ["test case 2 failed"]

invalid_number = solve_find_invalid(parse.(Int64, readlines("input/day9.txt")), 25)
println("First star: " * string(invalid_number))
println("Second star: " * string(solve_find_weakness(parse.(Int64, readlines("input/day9.txt")), invalid_number)))

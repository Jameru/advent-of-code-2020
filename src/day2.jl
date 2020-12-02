function solve_old(input)
	ret = 0;
	for line in input
		arr = split(line);
		mini, maxi = map(x -> parse(Int64, x), split(arr[1], "-"));
		aux = count(x -> x == arr[2][1], arr[3]);
		if (mini <= aux && aux <= maxi)
			ret += 1;
		end
	end
	ret
end

function solve_new(input)
	ret = 0;
	for line in input
		arr = split(line);
		fir, las = map(x -> parse(Int64, x), split(arr[1], "-"));
		aux = arr[2][1];
		if ((aux == arr[3][fir]) ⊻ (aux == arr[3][las]))
			ret += 1;
		end
	end
	ret
end

@assert solve_old(eachline("input/test_day2.txt")) == 2 ["solve(test_input) failed"];
@assert solve_new(eachline("input/test_day2.txt")) == 1 ["solve(test_input) failed"];

println("First star: " * string(solve_old(eachline("input/day2.txt"))))
println("First star: " * string(solve_new(eachline("input/day2.txt"))))

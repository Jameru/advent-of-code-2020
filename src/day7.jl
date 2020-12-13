function very_inefficient_solve(input)
	ret = 0
	conditions = ["shiny gold"]
	bags = [split(x, r" bags?", limit = 2) for x in input]
	i = 1
	while i <= length(bags)
		if any([contains(bags[i][2], condition) for condition in conditions])
			push!(conditions, bags[i][1])
			deleteat!(bags, i)
			ret += 1
			i = 1
		else
			i += 1
		end
	end
	ret
end

function solve(input)
	bags = split.(input, r" bags?")
	rules = Dict([ bag[1] => [ !contains(rule, "no other") ? match(r"\d [ \w]*", rule).match : nothing for rule in bag[2: end - 1] ] for bag in bags ])
	ret = 0
	queue = [("shiny gold", 1)]
	while (!isempty(queue))
		(bag, count) = pop!(queue)
		if !isnothing(rules[bag][1])
			children = split.(rules[bag], ' ', limit = 2)
			for child in children
				n = parse(Int64, child[1])
				push!(queue, (child[2], n * count))
				ret += n * count
			end
		end
	end
	ret
end

@assert very_inefficient_solve(readlines("input/test/test_day7.txt")) == 4 ["test case 1 failed"]
@assert solve(readlines("input/test/test_day7.txt")) == 32 ["test case 2 failed"]

println("First star: " * string(@time very_inefficient_solve(readlines("input/day7.txt"))))
println("Second star: " * string(@time solve(readlines("input/day7.txt"))))

function solve_with_loop(input)
	pc = 1
	visited = falses(length(input))
	ret = 0
	while !visited[pc]
		visited[pc] = true
		instruction, value = split(input[pc])
		if instruction == "acc"
			ret += parse(Int64, value)
			pc += 1
		elseif instruction == "jmp"
			pc += parse(Int64, value)
		elseif instruction == "nop"
			pc += 1
		end
	end
	ret
end

function solve_fix_loop(input)
	pc = saved_pc = 1
	visited = saved_visited = falses(length(input))
	ret = saved_acc = 0
	fix = fixable = true
	while pc <= length(input)
		if !visited[pc]
			visited[pc] = true
			instruction, value = split(input[pc])
			if instruction == "acc"
				ret += parse(Int64, value)
				pc += 1
			elseif instruction == "jmp"
				if fixable
					if fix
						fixable = false
						saved_pc = pc
						saved_visited = copy(visited)
						saved_acc = ret
						pc += 1
					else
						pc += parse(Int64, value)
						fix = true
					end
				else
					pc += parse(Int64, value)
				end
			elseif instruction == "nop"
				if fixable
					if fix
						fixable = false
						saved_pc = pc
						saved_visited = copy(visited)
						saved_acc = ret
						pc += parse(Int64, value)
					else
						fix = true
						pc += 1
					end
				else
					pc += 1
				end
			end
		else
			fixable = true
			pc = saved_pc
			visited = copy(saved_visited)
			visited[pc] = false
			fix = false
			ret = saved_acc
		end
	end
	ret
end

@assert solve_with_loop(readlines("input/test/test_day8.txt")) == 5 ["test case 1 failed"]
@assert solve_fix_loop(readlines("input/test/test_day8.txt")) == 8 ["test case 2 failed"]

println("First star: " * string(solve_with_loop(readlines("input/day8.txt"))))
println("Second star: " * string(solve_fix_loop(readlines("input/day8.txt"))))

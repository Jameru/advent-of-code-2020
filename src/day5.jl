function solve_max_seat_id(input)
	max_seat_id = 0
	for pass in input
		seat_id = parse(Int16, replace(replace(pass, ('B', 'R') => '1'), ('F', 'L')=>'0'), base = 2)
		if seat_id > max_seat_id
			max_seat_id = seat_id
		end
	end
	max_seat_id
end

function solve_my_seat_id(input)
	my_seat_id = max_seat_id = 0
	min_seat_id = 1023
	for pass in input
		seat_id = parse(Int16, replace(replace(pass, ('B', 'R') => '1'), ('F', 'L')=>'0'), base = 2)
		if seat_id > max_seat_id
			max_seat_id = seat_id
		elseif seat_id < min_seat_id
			min_seat_id = seat_id
		end
		my_seat_id ⊻= seat_id
	end
	for i in 1:min_seat_id - 1
		my_seat_id ⊻= i
	end
	for i in max_seat_id + 1:1023
		my_seat_id ⊻= i
	end
	my_seat_id
end

@assert solve_max_seat_id(eachline("input/test/test_day5.txt")) == 820 ["test case 1 failed"]

println("First star: " * string(solve_max_seat_id(eachline("input/day5.txt"))))
println("Second star: " * string(solve_my_seat_id(eachline("input/day5.txt"))))

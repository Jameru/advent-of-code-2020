using Match

required = ["byr:" "iyr:" "eyr:" "hgt:" "hcl:" "ecl:" "pid:"]

function solve(input)
	ret = 0
	lines = collect(Iterators.takewhile(line -> line != "", input))
	while length(lines) > 0
		passport = join(lines, ' ')
		if all(contains.(passport, required))
			ret += 1
		end
		lines = collect(Iterators.takewhile(line -> line != "", input))
	end
	ret
end

function solve_with_validations(input)
	ret = 0
	lines = collect(Iterators.takewhile(line -> line != "", input))
	while length(lines) > 0
		passport = join(lines, ' ')
		fields = split(passport)
		if all(validate.(passport, required))
			ret += 1
		end
		lines = collect(Iterators.takewhile(line -> line != "", input))
	end
	ret
end

function validate(passport, req)
	@match req begin
		"byr:" => begin
			m = match(r"byr:\d{4}\b", passport)
			if m === nothing
				false
			else
				n = parse(Int16, m.match[5:end])
				1920 <= n && n <= 2002
			end
		end
		"iyr:" => begin
			m = match(r"iyr:\d{4}\b", passport)
			if m === nothing
				false
			else
				n = parse(Int16, m.match[5:end])
				2010 <= n && n <= 2020
			end
		end 
		"eyr:" => begin
			m = match(r"eyr:\d{4}\b", passport)
			if m === nothing
				false
			else
				n = parse(Int16, m.match[5:end])
				2020 <= n && n <= 2030
			end
		end
		"hgt:" => begin
			m = match(r"hgt:(\d{3}cm|\d{2}in)\b", passport)
			if m === nothing
				false
			else
				if contains(m.match, "cm")
					n = parse(Int16, m.match[5:7])
					150 <= n && n <= 193
				else
					n = parse(Int16, m.match[5:6])
					59 <= n && n <= 76
				end
			end
		end
		"hcl:" => occursin(r"hcl:#[\dabcdef]{6}\b", passport)
		"ecl:" => occursin(r"ecl:(amb|blu|brn|gry|grn|hzl|oth)\b", passport)
		"pid:" => occursin(r"pid:\d{9}\b", passport)
		_ => true
	end
end

@assert solve(eachline("input/test_day4.txt")) == 2 ["test case 1 failed"]

println("First star: " * string(solve(eachline("input/day4.txt"))))
println("Second star: " * string(solve_with_validations(eachline("input/day4.txt"))))

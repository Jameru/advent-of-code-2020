function solve_naive(input)
    earliest = earlier = parse(Int64, input[1])
    buses = parse.(Int64, filter(x -> x != "x", split(input[2], ',')))
    idx = findfirst(id -> earlier % id == 0, buses)
    while isnothing(idx)
        earlier += 1
        idx = findfirst(id -> earlier % id == 0, buses)
    end
    buses[idx] * (earlier - earliest)
end

# Taken from https://rosettacode.org/wiki/Chinese_remainder_theorem#Julia
function chineseremainder(n::Array, a::Array)
    Π = prod(n)
    mod(sum(ai * invmod(Π ÷ ni, ni) * (Π ÷ ni) for (ni, ai) in zip(n, a)), Π)
end

function solve_with_flashbacks(input)
    # (Flashbacks OMA) Esto sale con teorema chino del resto...
    buses = map(x -> x == "x" ? 0 : parse(Int64, x), split(input[2], ','))
    n = []
    a = []
    for i in 0:length(buses) - 1
        if buses[i + 1] > 0
            push!(n, -i)
            push!(a, buses[i + 1])
        end
    end
    chineseremainder(a, n)
end

@assert solve_naive(readlines("input/test/test_day13.txt")) == 295 ["test case 1 failed"]
@assert solve_with_flashbacks(readlines("input/test/test_day13.txt")) == 1068781 ["test case 2 failed"]

println("First star: " * string(solve_naive(readlines("input/day13.txt"))))
println("Second star: " * string(solve_with_flashbacks(readlines("input/day13.txt"))))

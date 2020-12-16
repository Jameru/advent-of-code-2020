function barely_solve(input)
    dict = Dict{Int64, Array{Int64}}()
    for (i, n) in enumerate(input)
        dict[n] = [i]
    end
    latest = input[end]
    for i in length(input) + 1:2020
        latest = length(dict[latest]) < 2 ? 0 : dict[latest][end] - dict[latest][end - 1]
        !haskey(dict, latest) ? dict[latest] = [i] : push!(dict[latest], i)
    end
    latest
end

# TO DO: Find an efficient way to do this

function slow_solve(input)
    dict = Dict{Int64, Array{Int64}}()
    for (i, n) in enumerate(input)
        dict[n] = [i, 0]
    end
    latest = input[end]
    for i in length(input) + 1:30000000
        latest = dict[latest][2] == 0 ? 0 : dict[latest][1] - dict[latest][2]
        if !haskey(dict, latest)
            dict[latest] = [i, 0]
        else
            dict[latest][2] = dict[latest][1]
            dict[latest][1] = i
        end
    end
    latest
end

@assert barely_solve([0, 3, 6]) == 436 ["test case 1 failed"]
@assert barely_solve([1, 3, 2]) == 1   ["test case 1a failed"]
@assert barely_solve([2, 1, 3]) == 10  ["test case 1b failed"]
@assert slow_solve([0, 3, 6]) == 175594 ["test case 2 failed"]
@assert slow_solve([1, 3, 2]) == 2578   ["test case 2a failed"]
@assert slow_solve([2, 1, 3]) == 3544142  ["test case 2b failed"]

println("First star: " * string(barely_solve([15, 12, 0, 14, 3, 1])))
println("Second star: " * string(slow_solve([15, 12, 0, 14, 3, 1])))

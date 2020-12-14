function apply(bitmask, rval)
    b = collect(bitstring(parse(Int64, rval))[end - 35:end])
    for i in 1:36
        if bitmask[i] != 'X'
            b[i] = bitmask[i]
        end
    end
    parse(Int64, join(b), base = 2)
end

function solve_decoder_chip_v1(input)
    mem = zeros(Int64, 99999)
    bitmask, tail = Iterators.peel(input)
    bitmask = split(bitmask)[3]
    for line in tail
        lval, _, rval = split(line)
        if lval[4] == '['
            mem[parse(Int64, lval[5:findfirst(x -> x == ']', lval) - 1])] = apply(bitmask, rval)
        else
            bitmask = rval
        end
    end
    sum(mem)
end

function resolve_addresses(bitmask, address)
    b = collect(bitstring(address)[end - 35:end])
    addresses = [join([bitmask[i] == '0' ? b[i] : bitmask[i] for i in 1:36])]
    idxs = findall(x -> x == 'X', addresses[1])
    for i in 1:length(idxs)
        news = []
        for a in addresses
            a0 = collect(a)
            a0[idxs[i]] = '0'
            push!(news, join(a0))
            a1 = collect(a)
            a1[idxs[i]] = '1'
            push!(news, join(a1))
        end
        addresses = [addresses[1 + 2^(i - 1):end]; news]
    end
    parse.(Int64, addresses, base = 2)
end

function solve_decoder_chip_v2(input)
    mem = Dict{Int64, Int64}()
    bitmask, tail = Iterators.peel(input)
    bitmask = split(bitmask)[3]
    for line in tail
        lval, _, rval = split(line)
        if lval[4] == '['
            for a in resolve_addresses(bitmask, parse(Int64, lval[5:findfirst(x -> x == ']', lval) - 1]))
                mem[a] = parse(Int64, rval)
            end
        else
            bitmask = rval
        end
    end
    mem |> values |> sum
end

@assert solve_decoder_chip_v1(eachline("input/test/test_day14.txt")) == 165 ["test case 1 failed"]
@assert solve_decoder_chip_v2(eachline("input/test/test_day14a.txt")) == 208 ["test case 2 failed"]

println("First star: " * string(solve_decoder_chip_v1(readlines("input/day14.txt"))))
println("Second star: " * string(solve_decoder_chip_v2(readlines("input/day14.txt"))))

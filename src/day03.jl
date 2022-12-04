"Priority of char depends on ASCII"
priority(c::Char) = isuppercase(c) ? c - 'A' + 27 : c - 'a' + 1

function priority(s::AbstractString)
    n = length(s)
    @assert iseven(n) "The length of string '$s' is not even."
    l = n ÷ 2
    part1 = s[1:l]
    part2 = s[l+1:end]
    common = Set(part1) ∩ Set(part2)
    @assert length(common) == 1 "The set '$(common)' contains more than one element"
    ch = pop!(common)
    return priority(ch)
end

priority(strs::Vector{T}) where {T<:AbstractString} = sum(priority(s) for s in strs)

function day03a(strs)
    return priority(strs)
end

"Find a character common to all strings"
function badge(strs)
    common = intersect([Set(s) for s in strs]...)
    @assert length(common) == 1 "The badge should be 1. Found $(length(common)) badges: $(common)."
    return pop!(common)
end

function day03b(strs)
    @assert length(strs) % 3 == 0 "The number of rows must be a multiple of 3"
    l = length(strs) ÷ 3
    s = 0
    for i in 1:l
        b = badge(strs[(i-1)*3+1:i*3])
        s += priority(b)
    end
    return s
end

function day03(fpath)
    strs = readlines(fpath)
    return (day03a(strs), day03b(strs))
end
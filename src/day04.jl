function day04a(pairs)
    return sum(contains(i1, i2) || contains(i2, i1) for (i1, i2) in pairs)
end

function day04b(pairs)
    return sum(overlap(pair...) for pair in pairs)
end

function day04(fpath)
    lines = readlines(fpath)
    pairs = [split(line, ',') for line in lines]
    return (day04a(pairs), day04b(pairs))
end
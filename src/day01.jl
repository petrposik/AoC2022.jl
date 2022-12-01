"Find the maximal number of calories"
function day01a(calories)
    return max(calories...)
end

"Return the sum of the three biggest numbers of calories"
function day01b(calories)
    sorted = sort(calories, rev=true)
    return sum(sorted[1:3])
end

function day01(fpath)
    numbers = parse_parts(fpath)
    parse_int(x) = parse(Int, x)
    calories = [sum(parse_int.(items)) for items in numbers]
    return (day01a(calories), day01b(calories))
end
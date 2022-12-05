struct Interval
    from::Int
    to::Int
end

function Interval(s::AbstractString)
    parts = split(s, '-')
    @assert length(parts) == 2 "Cannot build interval from string '$s'."
    from = parse(Int, parts[1])
    to = parse(Int, parts[2])
    Interval(from, to)
end

"Return true if interval1 contains interval 2."
contains(interval1::Interval, interval2::Interval) = interval1.from <= interval2.from && interval1.to >= interval2.to
contains(interval1::AbstractString, interval2::AbstractString) = contains(Interval(interval1), Interval(interval2))

#Return tru if interval 1 overlaps with interval 2."
overlap12(i1::Interval, i2::Interval) = i1.from <= i2.from <= i1.to || i1.from <= i2.to <= i1.to
overlap(i1::Interval, i2::Interval) = overlap12(i1, i2) || overlap12(i2, i1)
overlap(i1::AbstractString, i2::AbstractString) = overlap(Interval(i1), Interval(i2))
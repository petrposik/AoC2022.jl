Pos = CartesianIndex{2}

DELTA_FROM_DIR = Dict('U' => Pos(-1, 0), 'D' => Pos(1, 0), 'L' => Pos(0, -1), 'R' => Pos(0, 1))

mutable struct Rope
    nodes::Vector{Pos}
    tail_positions::Vector{Pos}
end

function Rope(n::Int)
    nodes = [Pos(0, 0) for _ in 1:n]
    tail_positions = [Pos(0, 0)]
    return Rope(nodes, tail_positions)
end

Base.length(r::Rope) = length(r.nodes)

function move!(r::Rope, direction::Char)
    r.nodes[1] += DELTA_FROM_DIR[direction]
    for i in 2:length(r)
        move_node!(r, i)
    end
    push!(r.tail_positions, r.nodes[end])
end

function move_node!(r::Rope, i::Int)
    dif = Tuple(r.nodes[i-1] - r.nodes[i])
    maximum(abs.(dif)) < 2 && return
    r.nodes[i] += Pos(map(sign, dif))
end

function execute_moves!(r::Rope, moves)
    for (direction, count) in moves
        for _ in 1:parse(Int, count)
            move!(r, direction[1])  # direction[1 to extract Char from String
        end
    end
end

function day09a(moves)
    r = Rope(2)
    execute_moves!(r, moves)
    return length(Set(r.tail_positions))
end

function day09b(moves)
    r = Rope(10)
    execute_moves!(r, moves)
    return length(Set(r.tail_positions))
end

function day09(fpath)
    moves = parse_string_pairs(fpath)
    return (day09a(moves), day09b(moves))
end
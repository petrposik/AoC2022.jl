Pos = CartesianIndex{2}

directions = (Pos(-1, 0), Pos(0, -1), Pos(1, 0), Pos(0, 1))

function is_visible(map::AbstractMatrix, p::Pos)
    for d in directions
        if is_visible(map, p, d)
            return true
        end
    end
    return false
end

function is_visible(map::AbstractMatrix, p::Pos, d::Pos)
    tree_height = map[p]
    while true
        p += d
        !valid_position(map, p) && return true
        map[p] >= tree_height && return false
    end
end

valid_position(map::AbstractMatrix, p::Pos) = 1 <= p[1] <= size(map, 1) && 1 <= p[2] <= size(map, 2)

function count_visible(map::AbstractMatrix)
    n = 0
    for p in CartesianIndices(map)
        if is_visible(map, p)
            n += 1
        end
    end
    n
end

function day08a(map::AbstractMatrix)
    count_visible(map)
end

function scenic_score(map::AbstractMatrix, p::Pos)
    score = 1
    for d in directions
        score *= count_visible_trees(map, p, d)
    end
    return score
end

function count_visible_trees(map::AbstractMatrix, p::Pos, d::Pos)
    tree_height = map[p]
    n = 0
    while true
        p += d
        !valid_position(map, p) && return n
        n += 1
        map[p] >= tree_height && return n
    end
end

function find_best_position(map::AbstractMatrix)
    return maximum(scenic_score(map, p) for p in CartesianIndices(map))
end

function day08b(map::AbstractMatrix)
    find_best_position(map)
end

function day08(fpath)
    map = parse_matrix(open(fpath))
    return (day08a(map), day08b(map))
end
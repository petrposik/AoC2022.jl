Pos = CartesianIndex{2}
DIRECTIONS = [Pos(0, 1), Pos(0, -1), Pos(1, 0), Pos(-1, 0)]

mutable struct MapTask
    map::AbstractMatrix{Char}
    start::Pos
    goal::Pos
end

function MapTask(origmap::AbstractMatrix{Char})
    map = copy(origmap)
    start = Pos()
    goal = Pos()
    for pos in CartesianIndices(map)
        if map[pos] == 'S'
            start = pos
            map[pos] = 'a'
        elseif map[pos] == 'E'
            goal = pos
            map[pos] = 'z'
        end
        # @show pos, map[pos], start, goal
    end
    # @show start, goal
    MapTask(map, start, goal)
end

isgoal(t::MapTask, pos::Pos) = pos == t.goal
isstart(t::MapTask, pos::Pos) = pos == t.start
isvalidpos(t::MapTask, pos::Pos) = 1 <= pos[1] <= size(t.map, 1) && 1 <= pos[2] <= size(t.map, 2)

function expand(t::MapTask, pos::Pos)
    neighbors = Pos[]
    for d in DIRECTIONS
        n = pos + d
        if isvalidpos(t, n) && t.map[n] <= t.map[pos] + 1
            push!(neighbors, n)
        end
    end
    neighbors
end

function shortest_path(t::MapTask)
    queue = [t.start]
    distances = Dict(t.start => 0)
    predecessors = Dict{Pos,Pos}()
    while !isempty(queue)
        current_pos = popfirst!(queue)
        if isgoal(t, current_pos)
            return build_path(current_pos, predecessors)
        end
        current_dist = distances[current_pos]
        neighbors = expand(t, current_pos)
        for neighbor in neighbors
            # If we got to the neighbor earlier, skip it
            haskey(distances, neighbor) && continue
            # Process the neighbor
            push!(queue, neighbor)
            predecessors[neighbor] = current_pos
            distances[neighbor] = current_dist + 1
        end
    end
    return Pos[]
end

function build_path(pos, predecessors)
    path = [pos]
    while haskey(predecessors, pos)
        pred = predecessors[pos]
        pushfirst!(path, pred)
        pos = pred
    end
    path
end

function find_starts(t::MapTask)
    starts = Pos[]
    for pos in CartesianIndices(t.map)
        if t.map[pos] == 'a'
            push!(starts, pos)
        end
    end
    starts
end

function day12a(map::AbstractMatrix{Char})
    t = MapTask(map)
    path = shortest_path(t)
    return length(path) - 1
end

# Part two requires to find the shortest path 
# from many possible beginnings to the goal.
# Here I run the path finding from each start.
# If I designed the path finding not as 
# "how to get to any position from start",
# but rather as 
# "how to get from any position to goal",
# this part would be much easier/faster.
# But I am leaving it as it is for now.
function day12b(map::AbstractMatrix{Char})
    shortest_length = typemax(Int)
    t = MapTask(map)
    starts = find_starts(t)
    for start_pos in starts
        t.start = start_pos
        path = shortest_path(t)
        if !isempty(path) && length(path) - 1 < shortest_length
            shortest_length = length(path) - 1
        end
    end
    shortest_length
end


function day12(fpath)
    map = readmatrix(fpath)
    return (day12a(map), day12b(map))
end

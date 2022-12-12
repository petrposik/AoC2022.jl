abstract type FSItem end
name(item::FSItem) = item.name

mutable struct Dir <: FSItem
    name::AbstractString
    parent::Union{Dir,Nothing}
    items::Dict{AbstractString,FSItem}
end

Dir(name::AbstractString) = Dir(name, nothing, Dict{AbstractString,FSItem}())
function add!(d::Dir, item::FSItem)
    item.parent = d
    d.items[item.name] = item
end

mutable struct File <: FSItem
    name::AbstractString
    parent::Union{Dir,Nothing}
    size::Int
end

File(name::AbstractString, size::Int) = File(name, nothing, size)

size(f::File) = f.size
size(d::Dir) = sum(size(item) for item in values(d.items))
size(f::File, s::AbstractString) = f.name == s ? size(f) : nothing
function size(d::Dir, s::AbstractString)
    if d.name == s
        return size(d)
    end
    for (name, item) in d.items
        sz = size(item, s)
        if !isnothing(sz)
            return sz
        end
    end
end

function parse_fs(io::IO)
    root = Dir("/")
    current = root
    while true
        line = readline(io)
        isempty(line) && break
        parts = split(line)
        if parts[1] == "\$"
            if parts[2] == "cd"
                if parts[3] == "/"
                    current = root
                elseif parts[3] == ".."
                    current = current.parent
                else
                    current = current.items[parts[3]]
                end
            elseif parts[2] == "ls"
                parse_dir_contents(current, io)
            else
                error("I do not know how to parse '$(parts[2])'.")
            end
        else
            error("Expected line starting with '\$'.")
        end
    end
    return root
end

function parse_dir_contents(current::Dir, io::IO)
    while true
        if bytesavailable(io) == 0 || peek(io, Char) == '$'
            break
        end
        parts = split(readline(io))
        if parts[1] == "dir"
            add!(current, Dir(parts[2]))
        else
            size = parse(Int, parts[1])
            add!(current, File(parts[2], size))
        end
    end
end

sum_small_dirs(::File) = 0
function sum_small_dirs(current::Dir)
    total = 0
    sz = size(current)
    if sz <= 100000
        total += sz
    end
    for (name, item) in current.items
        total += sum_small_dirs(item)
    end
    total
end

function day07a(root::Dir)
    sum_small_dirs(root)
end


list_all_dirs_greater_than(::File, ::Int) = Int[]
function list_all_dirs_greater_than(current::Dir, limit::Int)
    sizes = Int[]
    sz = size(current)
    if sz >= limit
        push!(sizes, sz)
    end
    for (name, item) in current.items
        append!(sizes, list_all_dirs_greater_than(item, limit))
    end
    sizes
end

function day07b(root::Dir)
    used = size(root)
    free = 70000000 - used
    to_be_freed = 30000000 - free
    sizes = list_all_dirs_greater_than(root, to_be_freed)
    minimum(sizes)
end

function day07(fpath)
    root = parse_fs(open(fpath))
    return (day07a(root), day07b(root))
end
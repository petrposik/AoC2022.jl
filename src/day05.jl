Stacks = Vector{Vector{Char}}
struct Command
    n::Int
    from::Int
    to::Int
end

Base.show(io::IO, cmd::Command) = print(io, "Moving $(cmd.n) from $(cmd.from) to $(cmd.to)")

function Base.show(io::IO, stacks::Stacks)
    for (i, stack) in enumerate(stacks)
        println(io, "$(i) $(join(stack))")
    end
end

function parse_stacks_file(fpath::AbstractString)
    lines = readlines(fpath)
    empty = findfirst(isempty, lines)
    stacks = parse_stacks(reverse(lines[1:empty-1]))
    commands = parse_commands(lines[empty+1:end])
    return stacks, commands
end

function parse_stacks(lines::Vector{String})
    N = parse(Int, split(lines[1])[end])
    stacks = [[] for i in 1:N]
    for line in lines[2:end]
        chars = [line[(i-1)*4+2] for i in 1:N]
        for (i, ch) in enumerate(chars)
            if ch != ' '
                push!(stacks[i], ch)
            end
        end
    end
    # @show stacks
    return Stacks(stacks)
end

function parse_commands(lines::Vector{String})
    commands = Vector{Command}()
    for line in lines
        push!(commands, parse_command(line))
    end
    return commands
end

function parse_command(line::String)
    parts = split(line)
    return Command(parse(Int, parts[2]), parse(Int, parts[4]), parse(Int, parts[6]))
end

function process_commands_a!(stacks::Stacks, commands::Vector)
    for cmd in commands
        for i in 1:cmd.n
            move!(stacks, cmd.from, cmd.to)
        end
    end
    return stacks
end

function move!(stacks::Stacks, from::Int, to::Int)
    push!(stacks[to], pop!(stacks[from]))
end

function process_commands_b!(stacks::Stacks, commands::Vector)
    for cmd in commands
        l = length(stacks[cmd.from])
        what = stacks[cmd.from][(l-cmd.n+1):l]
        append!(stacks[cmd.to], what)
        deleteat!(stacks[cmd.from], (l-cmd.n+1):l)
    end
    return stacks
end



function day05a(stacks, commands)
    process_commands_a!(stacks, commands)
    return join([s[end] for s in stacks])
end

function day05b(stacks, commands)
    process_commands_b!(stacks, commands)
    return join([s[end] for s in stacks])
end

function day05(fpath)
    (stacks, commands) = parse_stacks_file(fpath)
    return (
        day05a(deepcopy(stacks), commands),
        day05b(deepcopy(stacks), commands))
end
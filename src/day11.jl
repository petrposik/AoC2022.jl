mutable struct Monkey
    items::Vector{Int}
    operation::AbstractString
    divider::Int
    true_monkey::Int
    false_monkey::Int
    n_inspections::Int
end

Monkey(i, o, d, t, f) = Monkey(i, o, d, t, f, 0)

function inspect_item!(m::Monkey, division_const::Int=3)
    m.n_inspections += 1
    old = popfirst!(m.items)
    # @show old
    item = evaluate(m.operation, old)
    item = item ÷ division_const
    if item % m.divider == 0
        target = m.true_monkey
    else
        target = m.false_monkey
    end
    return (item, target)
end

function evaluate(operation::AbstractString, old::Int)
    first, op, second = split(operation)
    # @show first, op, second
    first_num = (first == "old") ? old : parse(Int, first)
    second_num = (second == "old") ? old : parse(Int, second)
    if strip(op) == "+"
        return first_num + second_num
    elseif strip(op) == "-"
        return first_num - second_num
    elseif strip(op) == "*"
        return first_num * second_num
    else
        error("Unknown operation: $(op)")
    end
end

function parse_monkey(io::IO)
    while true
        line = strip(readline(io))
        isempty(line) || break
    end
    startswith(line, "Monkey") || error("Expected 'Monkey <num>'")
    line = strip(readline(io))
    startswith(line, "Starting items:") || error("Expected 'Starting items: <num> <num> ...'")
    items = [parse(Int, s) for s in split(line[length("Starting items:")+1:end], ',')]
    line = strip(readline(io))
    startswith(line, "Operation:") || error("Expected 'Operation: new = ...'")
    operation = line[length("Operation: new = ")+1:end]
    line = strip(readline(io))
    startswith(line, "Test: divisible by ") || error("Expected 'Test: divisible by <num>'")
    divider = parse(Int, line[length("Test: divisible by ")+1:end])
    line = strip(readline(io))
    startswith(line, "If true: throw to monkey ") || error("Expected 'If true: throw to monkey <num>'")
    true_monkey = 1 + parse(Int, line[length("If true: throw to monkey ")+1:end])
    line = strip(readline(io))
    startswith(line, "If false: throw to monkey ") || error("Expected 'If false: throw to monkey <num>'")
    false_monkey = 1 + parse(Int, line[length("If false: throw to monkey ")+1:end])
    return Monkey(items, operation, divider, true_monkey, false_monkey)
end

mutable struct MonkeyGroup
    monkeys::Vector{Monkey}
    n_rounds::Int
    division_const::Int
    modulus::Int
end

MonkeyGroup() = MonkeyGroup(Monkey[], 0, 3, 0)

inspections(g::MonkeyGroup) = [m.n_inspections for m in g.monkeys]

function compute_modulus!(group::MonkeyGroup)
    group.modulus = prod(m.divider for m in group.monkeys)
end

function parse_monkey_group(io::IO)
    group = MonkeyGroup()
    while !eof(io)
        monkey = parse_monkey(io)
        # @show monkey
        push!(group.monkeys, monkey)
    end
    compute_modulus!(group)
    group
end

function run_round!(group::MonkeyGroup, update_item::Function)
    for monkey in group.monkeys
        while !isempty(monkey.items)
            (item, target_monkey) = inspect_item!(monkey, group.division_const)
            push!(group.monkeys[target_monkey].items, update_item(item))
        end
    end
    group.n_rounds += 1
end

function advance_rounds!(group::MonkeyGroup, target::Int, update_item::Function=x -> x)
    while group.n_rounds < target
        run_round!(group, update_item)
    end
end


function day11a(group)
    group.division_const = 3
    advance_rounds!(group, 20)
    insp = inspections(group)
    sort!(insp)
    return insp[end-1] * insp[end]
end


function day11b(group)
    group.division_const = 1
    advance_rounds!(group, 10000, x -> x % group.modulus)
    insp = inspections(group)
    sort!(insp)
    return insp[end-1] * insp[end]
end

function day11(fpath)
    group = parse_monkey_group(open(fpath))
    return (day11a(deepcopy(group)), day11b(deepcopy(group)))
end

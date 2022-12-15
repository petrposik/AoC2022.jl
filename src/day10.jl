function day10a(program)
    cpu = CPU()
    load_program!(cpu, program)
    total = 0
    for target in (20, 60, 100, 140, 180, 220)
        cycle!(cpu, target)
        total += signal_strength(cpu)
    end
    return total
end

function day10b(program)
    crt = AoC2022.CRT()
    AoC2022.load_program!(crt, program)
    AoC2022.cycle!(crt, 240)
    io = IOBuffer()
    print(io, crt)
    print(crt)
    return String(take!(io))
end

function day10(fpath)
    program = AoC2022.parse_string_pairs(fpath)
    return (day10a(program), day10b(program))
end
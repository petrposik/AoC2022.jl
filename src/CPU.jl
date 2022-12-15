struct Instruction
    wait_cycles::Int
    opcode::String
    arg::Int
end

Base.show(io::IO, inst::Instruction) = print(io, "$(inst.opcode) $(inst.arg)")

mutable struct CPU
    x::Int
    last_x::Int
    elapsed_cycles::Int
    instruction_queue::Vector{Instruction}
    CPU() = new(1, 1, 0, Instruction[])
end

Base.show(io::IO, cpu::CPU) = print(io, "Cycles elapsed: $(cpu.elapsed_cycles), during: $(cpu.last_x), after: $(cpu.x)")

signal_strength(cpu::CPU) = cpu.last_x * cpu.elapsed_cycles

function load_program!(cpu::CPU, program::Vector{Vector{T}}) where {T<:AbstractString}
    cpu.instruction_queue = program |> to_instructions
end

function to_instructions(program::Vector{Vector{T}}) where {T<:AbstractString}
    instructions = Instruction[]
    for line_parts in program
        # Defaults for noop opcode
        wait_cycles = 0
        opcode = line_parts[1]
        arg = 0
        if opcode == "addx"
            wait_cycles = 1
            arg = parse(Int, line_parts[2])
        end
        push!(instructions, Instruction(wait_cycles, opcode, arg))
    end
    return instructions
end

function cycle!(cpu::CPU, target_cycles::Int)
    while cpu.elapsed_cycles < target_cycles
        cycle!(cpu)
    end
end

function cycle!(cpu::CPU)
    cpu.last_x = cpu.x
    inst = cpu.instruction_queue[1]
    if inst.wait_cycles > 0
        cpu.instruction_queue[1] = cycle(inst)
    else
        deleteat!(cpu.instruction_queue, 1)
        execute_instruction!(cpu, inst)
    end
    cpu.elapsed_cycles += 1
    # @show cpu, inst
end


function cycle(inst::Instruction)
    return Instruction(inst.wait_cycles - 1, inst.opcode, inst.arg)
end

function execute_instruction!(cpu::CPU, inst::Instruction)
    if inst.opcode == "noop"
        # Do nothing
    elseif inst.opcode == "addx"
        cpu.x += inst.arg
    else
        error("Unknown instruction opcode.")
    end
end



struct CRT
    cpu::CPU
    pixels::Vector{Char}
end

function CRT()
    cpu = CPU()
    pixels = Char[]
    CRT(cpu, pixels)
end

function Base.show(io::IO, crt::CRT)
    for i in 1:6
        if length(crt.pixels) > 40 * i
            s = join(crt.pixels[((i-1)*40+1):(40*i)])
            println(io, s)
        else
            s = join(crt.pixels[((i-1)*40+1):end])
            println(io, s)
            break
        end
    end
end

load_program!(crt::CRT, program) = load_program!(crt.cpu, program)

sprite_position(crt::CRT) = crt.cpu.x

function cycle!(crt::CRT)
    sp = sprite_position(crt)
    if sp - 1 <= crt.cpu.elapsed_cycles % 40 <= sp + 1
        push!(crt.pixels, '#')
    else
        push!(crt.pixels, '.')
    end
    cycle!(crt.cpu)
    @assert length(crt.pixels) == crt.cpu.elapsed_cycles "The number of pixels $(length(crt.pixels)) should be equal to the number of elapsed cycles $(crt.cpu.elapsed_cycles)."
end

function cycle!(crt::CRT, target_cycles::Int)
    while crt.cpu.elapsed_cycles < target_cycles
        cycle!(crt)
    end
end

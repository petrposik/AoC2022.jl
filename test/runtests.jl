using Test
using AoC2022

day10_test_output = """##..##..##..##..##..##..##..##..##..##..
###...###...###...###...###...###...###.
####....####....####....####....####....
#####.....#####.....#####.....#####.....
######......######......######......####
#######.......#######.......#######.....
"""

day10_output = """####..##..#....#..#.###..#....####...##.
#....#..#.#....#..#.#..#.#....#.......#.
###..#....#....####.###..#....###.....#.
#....#.##.#....#..#.#..#.#....#.......#.
#....#..#.#....#..#.#..#.#....#....#..#.
####..###.####.#..#.###..####.#.....##..
"""


@testset "AoC2022" begin

    @testset "Day 1" begin
        @test AoC2022.day01("../data/test_input01.txt") == (24000, 45000)
        @test AoC2022.day01("../data/input01.txt") == (69528, 206152)
    end

    @testset "Day 2" begin
        @test AoC2022.score('A', 'Y') == 8
        @test AoC2022.score('B', 'X') == 1
        @test AoC2022.score('C', 'Z') == 6
        @test AoC2022.score2('A', 'Y') == 4
        @test AoC2022.score2('B', 'X') == 1
        @test AoC2022.score2('C', 'Z') == 7
        @test AoC2022.day02("../data/test_input02.txt") == (15, 12)
        @test AoC2022.day02("../data/input02.txt") == (10404, 10334)
    end

    @testset "Day 3" begin
        @test AoC2022.priority('p') == 16
        @test AoC2022.priority('L') == 38
        @test AoC2022.priority('P') == 42
        @test AoC2022.priority('v') == 22
        @test AoC2022.priority('t') == 20
        @test AoC2022.priority('s') == 19
        @test AoC2022.priority("vJrwpWtwJgWrhcsFMMfFFhFp") == 16
        @test AoC2022.priority("jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL") == 38
        @test AoC2022.priority("PmmdzqPrVvPwwTWBwg") == 42
        @test AoC2022.priority("wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn") == 22
        @test AoC2022.priority("ttgJtRGJQctTZtZT") == 20
        @test AoC2022.priority("CrZsJsPPZsGzwwsLwLmpwMDw") == 19
        @test AoC2022.badge(["vJrwpWtwJgWrhcsFMMfFFhFp",
            "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL",
            "PmmdzqPrVvPwwTWBwg"]) == 'r'
        @test AoC2022.badge(["wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn",
            "ttgJtRGJQctTZtZT",
            "CrZsJsPPZsGzwwsLwLmpwMDw"]) == 'Z'
        @test AoC2022.day03("../data/test_input03.txt") == (157, 70)
        @test AoC2022.day03("../data/input03.txt") == (7746, 2604)
    end

    @testset "Day 4" begin
        @test AoC2022.contains("6-6", "4-6") == false
        @test AoC2022.contains("4-6", "6-6") == true
        @test AoC2022.overlap("3-5", "4-6") == true
        @test AoC2022.overlap("4-6", "3-5") == true
        @test AoC2022.overlap("1-3", "4-6") == false
        @test AoC2022.overlap("4-6", "1-3") == false
        @test AoC2022.overlap("4-4", "4-6") == true
        @test AoC2022.overlap("4-6", "4-4") == true
        @test AoC2022.overlap("6-6", "4-6") == true
        @test AoC2022.overlap("4-6", "6-6") == true
        @test AoC2022.overlap("1-4", "2-3") == true
        @test AoC2022.overlap("2-3", "1-4") == true
        @test AoC2022.day04("../data/test_input04.txt") == (2, 4)
        @test AoC2022.day04("../data/input04.txt") == (573, 867)
    end

    @testset "Day 5" begin
        @test AoC2022.day05("../data/test_input05.txt") == ("CMZ", "MCD")
        @test AoC2022.day05("../data/input05.txt") == ("MQTPGLLDN", "LVZPSTTCZ")
    end

    @testset "Day 6" begin
        @test AoC2022.find_packet_marker("mjqjpqmgbljsphdztnvjfqwrcgsmlb") == 7
        @test AoC2022.find_packet_marker("bvwbjplbgvbhsrlpgdmjqwftvncz") == 5
        @test AoC2022.find_packet_marker("nppdvjthqldpwncqszvftbrmjlhg") == 6
        @test AoC2022.find_packet_marker("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg") == 10
        @test AoC2022.find_packet_marker("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw") == 11
        @test AoC2022.find_message_marker("mjqjpqmgbljsphdztnvjfqwrcgsmlb") == 19
        @test AoC2022.find_message_marker("bvwbjplbgvbhsrlpgdmjqwftvncz") == 23
        @test AoC2022.find_message_marker("nppdvjthqldpwncqszvftbrmjlhg") == 23
        @test AoC2022.find_message_marker("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg") == 29
        @test AoC2022.find_message_marker("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw") == 26
        @test AoC2022.day06("../data/test_input06.txt") == (7, 19)
        @test AoC2022.day06("../data/input06.txt") == (1042, 2980)
    end

    @testset "Day 7" begin
        input = IOBuffer("""\$ cd /
        \$ ls
        dir a
        1 b.txt
        \$ cd a
        \$ ls
        1 a.txt
        \$ cd ..
        """)
        parsed = AoC2022.parse_fs(input)
        @test AoC2022.size(parsed) == 2
        @test AoC2022.size(parsed, "/") == 2
        @test AoC2022.size(parsed, "a") == 1
        @test AoC2022.size(parsed, "a.txt") == 1
        @test AoC2022.size(parsed, "b.txt") == 1
        root = AoC2022.parse_fs(open("../data/test_input07.txt"))
        @test AoC2022.size(root, "e") == 584
        @test AoC2022.size(root, "a") == 94853
        @test AoC2022.size(root, "d") == 24933642
        @test AoC2022.size(root, "/") == 48381165
        @test AoC2022.day07("../data/test_input07.txt") == (95437, 24933642)
        @test AoC2022.day07("../data/input07.txt") == (1307902, 7068748)
    end

    @testset "Day 8" begin
        @test AoC2022.day08("../data/test_input08.txt") == (21, 8)
        @test AoC2022.day08("../data/input08.txt") == (1789, 314820)
    end

    @testset "Day 9" begin
        @test AoC2022.day09("../data/test_input09.txt") == (13, 1)
        @test AoC2022.day09("../data/input09.txt") == (5858, 2602)
    end

    @testset "Day 10" begin

        @testset "CPU" begin
            program = AoC2022.parse_string_pairs("../data/test_input10_small.txt")
            expected_instructions = [
                AoC2022.Instruction(0, "noop", 0),
                AoC2022.Instruction(1, "addx", 3),
                AoC2022.Instruction(1, "addx", -5)
            ]
            @test program |> AoC2022.to_instructions == expected_instructions
            cpu = AoC2022.CPU()
            AoC2022.load_program!(cpu, program)
            @test cpu.x == 1
            @test cpu.elapsed_cycles == 0
            # At the start of the first cycle, the noop instruction begins execution. 
            # During the first cycle, X is 1. After the first cycle, 
            # the noop instruction finishes execution, doing nothing.
            AoC2022.cycle!(cpu)
            @test cpu.x == 1
            @test cpu.elapsed_cycles == 1
            # At the start of the second cycle, the addx 3 instruction begins execution. 
            # During the second cycle, X is still 1.
            AoC2022.cycle!(cpu)
            @test cpu.x == 1
            @test cpu.elapsed_cycles == 2
            # During the third cycle, X is still 1. 
            # After the third cycle, the addx 3 instruction finishes execution, setting X to 4.
            AoC2022.cycle!(cpu)
            @test cpu.x == 4
            @test cpu.elapsed_cycles == 3
            # At the start of the fourth cycle, the addx -5 instruction begins execution. 
            # During the fourth cycle, X is still 4.
            AoC2022.cycle!(cpu)
            @test cpu.x == 4
            @test cpu.elapsed_cycles == 4
            # During the fifth cycle, X is still 4. 
            # After the fifth cycle, the addx -5 instruction finishes execution, setting X to -1.
            AoC2022.cycle!(cpu)
            @test cpu.x == -1
            @test cpu.elapsed_cycles == 5

            # Signal strength
            program = AoC2022.parse_string_pairs("../data/test_input10.txt")
            cpu = AoC2022.CPU()
            AoC2022.load_program!(cpu, program)
            # During the 20th cycle, register X has the value 21, 
            # so the signal strength is 20 * 21 = 420. 
            AoC2022.cycle!(cpu, 20)
            @test cpu.elapsed_cycles == 20
            @test cpu.last_x == 21
            @test AoC2022.signal_strength(cpu) == 20 * 21
            # During the 60th cycle, register X has the value 19, so the signal strength is 60 * 19 = 1140.
            AoC2022.cycle!(cpu, 60)
            @test cpu.elapsed_cycles == 60
            @test cpu.last_x == 19
            @test AoC2022.signal_strength(cpu) == 60 * 19
            # During the 100th cycle, register X has the value 18, so the signal strength is 100 * 18 = 1800.
            AoC2022.cycle!(cpu, 100)
            @test cpu.elapsed_cycles == 100
            @test cpu.last_x == 18
            @test AoC2022.signal_strength(cpu) == 100 * 18
            # During the 140th cycle, register X has the value 21, so the signal strength is 140 * 21 = 2940.
            AoC2022.cycle!(cpu, 140)
            @test cpu.elapsed_cycles == 140
            @test cpu.last_x == 21
            @test AoC2022.signal_strength(cpu) == 140 * 21
            # During the 180th cycle, register X has the value 16, so the signal strength is 180 * 16 = 2880.
            AoC2022.cycle!(cpu, 180)
            @test cpu.elapsed_cycles == 180
            @test cpu.last_x == 16
            @test AoC2022.signal_strength(cpu) == 180 * 16
            # During the 220th cycle, register X has the value 18, so the signal strength is 220 * 18 = 3960.
            AoC2022.cycle!(cpu, 220)
            @test cpu.elapsed_cycles == 220
            @test cpu.last_x == 18
            @test AoC2022.signal_strength(cpu) == 220 * 18
        end

        @testset "CRT" begin
            crt = AoC2022.CRT()
            program = AoC2022.parse_string_pairs("../data/test_input10.txt")
            AoC2022.load_program!(crt, program)
            @test join(crt.pixels) == ""
            @test AoC2022.sprite_position(crt) == 1
            # Cycle 1
            AoC2022.cycle!(crt)
            @test join(crt.pixels) == "#"
            @test AoC2022.sprite_position(crt) == 1
            # Cycle 2
            AoC2022.cycle!(crt)
            @test join(crt.pixels) == "##"
            @test AoC2022.sprite_position(crt) == 16
            # Cycle 3
            AoC2022.cycle!(crt)
            @test join(crt.pixels) == "##."
            @test AoC2022.sprite_position(crt) == 16
            # Cycle 3
            AoC2022.cycle!(crt)
            @test join(crt.pixels) == "##.."
            @test AoC2022.sprite_position(crt) == 5

        end

        @test AoC2022.day10("../data/test_input10.txt") == (13140, day10_test_output)
        @test AoC2022.day10("../data/input10.txt") == (13920, day10_output)
    end

    # @testset "Day 11" begin
    #     state0 = AoC2022.parse_matrix(IOBuffer("11111\n19991\n19191\n19991\n11111"))
    #     state1 = AoC2022.parse_matrix(IOBuffer("34543\n40004\n50005\n40004\n34543"))
    #     AoC2022.step!(state0)
    #     @test state0 == state1
    #     @test AoC2022.day11("../data/test_input11.txt") == (1656, 195)
    #     @test AoC2022.day11("../data/input11.txt") == (1757, 422)
    # end
end

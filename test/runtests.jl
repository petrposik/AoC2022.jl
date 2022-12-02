using Test
using AoC2022

@testset "AoC2022" begin

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

    @testset "Day 1" begin
        @test AoC2022.day01("../data/test_input01.txt") == (24000, 45000)
        @test AoC2022.day01("../data/input01.txt") == (69528, 206152)
    end

    # @testset "Day 3" begin
    #     @test AoC2022.day03("../data/test_input03.txt") == (198, 230)
    #     @test AoC2022.day03("../data/input03.txt") == (4139586, 1800151)
    # end

    # @testset "Day 4" begin
    #     @test AoC2022.day04("../data/test_input04.txt") == (4512, 1924)
    #     @test AoC2022.day04("../data/input04.txt") == (10680, 31892)
    # end

    # @testset "Day 5" begin
    #     @test AoC2022.parse_point("123,456") == [124, 457] # Intentionally add 1
    #     @test AoC2022.parse_segment("123,456 -> 78,9") == AoC2022.Segment([124, 457], [79, 10])
    #     @test length(AoC2022.parse_segments("../data/test_input05.txt")) == 10
    #     @test AoC2022.day05("../data/test_input05.txt") == (5, 12)
    #     @test AoC2022.day05("../data/input05.txt") == (4728, 17717)
    # end

    # @testset "Day 6" begin
    #     @test AoC2022.step_ages([3, 4, 3, 1, 2]) == [1, 1, 2, 1, 0, 0, 0, 0, 0]
    #     @test AoC2022.step_ages([2, 3, 2, 0, 1]) == [1, 2, 1, 0, 0, 0, 1, 0, 1]
    #     @test AoC2022.step_counters([0, 0, 0, 1, 1, 3, 2, 2, 1]) == [0, 0, 1, 1, 3, 2, 2, 1, 0]
    #     @test AoC2022.step_counters([1, 3, 2, 2, 1, 0, 1, 0, 1]) == [3, 2, 2, 1, 0, 1, 1, 1, 1]
    #     @test sum(AoC2022.step_n_ages(18, [3, 4, 3, 1, 2])) == 26
    #     @test sum(AoC2022.step_n_ages(80, [3, 4, 3, 1, 2])) == 5934
    #     @test AoC2022.day06("../data/test_input06.txt") == (5934, 26984457539)
    #     @test AoC2022.day06("../data/input06.txt") == (379414, 1705008653296)
    # end

    # @testset "Day 7" begin
    #     positions = [16, 1, 2, 0, 4, 2, 7, 1, 2, 14]
    #     @test AoC2022.day07b(positions) == 168
    #     @test AoC2022.day07("../data/test_input07.txt") == (37, 168)
    #     @test AoC2022.day07("../data/input07.txt") == (328187, 91257582)
    # end

    # @testset "Day 8" begin
    #     signals = AoC2022.normalize.(split("acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab"))
    #     quartets = AoC2022.normalize.(split("cdfeb fcadb cdfeb cdbaf"))
    #     correct_encoding = Dict("abcdefg" => 8, "bcdef" => 5, "acdfg" => 2, "abcdf" => 3, "abd" => 7,
    #         "abcdef" => 9, "bcdefg" => 6, "abef" => 4, "abcdeg" => 0, "ab" => 1)
    #     @test AoC2022.find_encoding(signals) == correct_encoding
    #     @test AoC2022.decode(correct_encoding, quartets) == 5353
    #     @test AoC2022.day08("../data/test_input08.txt") == (26, 61229)
    #     @test AoC2022.day08("../data/input08.txt") == (495, 1055164)
    # end

    # @testset "Day 9" begin
    #     m = AoC2022.parse_matrix("../data/test_input09.txt")
    #     lp = AoC2022.low_points(m)
    #     @test lp == [(1, 2), (1, 10), (3, 3), (5, 7)]
    #     @test AoC2022.basin_area(m, (1, 2)) == 3
    #     @test AoC2022.basin_area(m, (1, 10)) == 9
    #     @test AoC2022.basin_area(m, (3, 3)) == 14
    #     @test AoC2022.basin_area(m, (5, 7)) == 9
    #     @test AoC2022.day09("../data/test_input09.txt") == (15, 1134)
    #     @test AoC2022.day09("../data/input09.txt") == (489, 1056330)
    # end

    # @testset "Day 10" begin
    #     @test AoC2022.closing_score("}}]])})]") == 288957
    #     @test AoC2022.day10("../data/test_input10.txt") == (26397, 288957)
    #     @test AoC2022.day10("../data/input10.txt") == (216297, 2165057169)
    # end

    # @testset "Day 11" begin
    #     state0 = AoC2022.parse_matrix(IOBuffer("11111\n19991\n19191\n19991\n11111"))
    #     state1 = AoC2022.parse_matrix(IOBuffer("34543\n40004\n50005\n40004\n34543"))
    #     AoC2022.step!(state0)
    #     @test state0 == state1
    #     @test AoC2022.day11("../data/test_input11.txt") == (1656, 195)
    #     @test AoC2022.day11("../data/input11.txt") == (1757, 422)
    # end
end

# Rock-Paper-Scissors
# A for Rock, B for Paper, and C for Scissors
# X for Rock, Y for Paper, and Z for Scissors (hopefully, part 1)
# Your total score is the sum of your scores for each round. 
# The score for a single round is 
# the score for the shape you selected 
# (1 for Rock, 2 for Paper, and 3 for Scissors) 
# plus the score for the outcome of the round 
# (0 if you lost, 3 if the round was a draw, and 6 if you won).

@enum Shape rock = 1 paper = 2 scissors = 3
@enum Outcome loss = 0 draw = 3 win = 6

opp_shape = Dict{Char,Shape}('A' => rock, 'B' => paper, 'C' => scissors)
my_shape_from_XYZ = Dict{Char,Shape}('X' => rock, 'Y' => paper, 'Z' => scissors)
outcome = Dict{Tuple{Shape,Shape},Outcome}(
    (rock, rock) => draw,
    (rock, paper) => win,
    (rock, scissors) => loss,
    (paper, rock) => loss,
    (paper, paper) => draw,
    (paper, scissors) => win,
    (scissors, rock) => win,
    (scissors, paper) => loss,
    (scissors, scissors) => draw)


score(opp_shape::Shape, my_shape::Shape) = Int(my_shape) + Int(outcome[opp_shape, my_shape])
score(opp::Char, my::Char) = score(opp_shape[opp], my_shape_from_XYZ[my])

function day02a(pairs)
    return sum(score(pair...) for pair in pairs)
end

# "Anyway, the second column says how the round needs to end: 
# X means you need to lose, 
# Y means you need to end the round in a draw, 
# and Z means you need to win. Good luck!"

outcome_from_XYZ = Dict{Char,Outcome}('X' => loss, 'Y' => draw, 'Z' => win)
my_shape = Dict{Tuple{Shape,Outcome},Shape}(
    (rock, draw) => rock,
    (rock, win) => paper,
    (rock, loss) => scissors,
    (paper, loss) => rock,
    (paper, draw) => paper,
    (paper, win) => scissors,
    (scissors, win) => rock,
    (scissors, loss) => paper,
    (scissors, draw) => scissors)

function score2(opp_char::Char, out_char::Char)
    opp = opp_shape[opp_char]
    out = outcome_from_XYZ[out_char]
    my = my_shape[opp, out]
    score(opp, my)
end

function day02b(pairs)
    return sum(score2(pair...) for pair in pairs)
end

function day02(fpath)
    pairs = parse_char_pairs(fpath)
    return (day02a(pairs), day02b(pairs))
end